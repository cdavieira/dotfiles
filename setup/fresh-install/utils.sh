#!/usr/bin/env bash

command_exists(){
  command -v $1 &>/dev/null
}

has_yq(){
 command_exists yq
}

ensure_yq_installed(){
  if ! has_yq ; then
    echo "This script depends on 'yq' to work, but 'yq' wasn't detected in your system!"
    echo "Attempting to install 'yq' for distro "${linuxdistro}"..."
    case $1 in
      'arch') sudo pacman -S jq go-yq ;;
      'gentoo') sudo emerge -av app-misc/jq app-misc/yq-go ;;
      *)
        echo "TODO: implement installation of 'jq' and 'yq' for distro '${linuxdistro}'. Exiting..."
        exit
        ;;
    esac
  fi
}

jq_db_wrapper(){
  # How this wrapper works:
  # 1. we read 'db.yaml' and convert it to json through 'yq -o json db.yaml'
  # OBS: 'yq' is provided by the go-yq package!
  # 2. we pipe the json into 'jq' in order to parser it
  # 3. '-L.' adds the current directory to the list of directories where 'jq' looks for modules ('*.jq' files)
  # 4. we import our modules and give a proper namespace to call their functions
  # 5. we provide the variable '$toplevel' as the root of this json document
  # 6. any additional commands should be piped through the | operator that 'jq' provides
  #
  # For example:
  #   $ jq_db_wrapper '
  #     | utils::get_all_single_pkgs($toplevel; .arch)
  #     | .
  #   '
  local jq_cmd="\
  import \"utils\" as utils;
  . as \$toplevel
  $*
"

  # echo "$jq_cmd"
  yq -o json db.yaml | jq -L. "$jq_cmd"
}

jq_install_wrapper(){
  local jq_cmd="\
  import \"utils\" as utils;
  . as \$toplevel
  | .[0] as \$db
  | .[1] as \$install
  $*
"

  # echo "$jq_cmd"

  # 'db.yaml' and 'install.yaml' are merged into a single json
  # because of the '-s' option
  yq -o json db.yaml install.yaml | jq -s -L. "$jq_cmd"
}

jq_clear_output(){
  tr ' ' '\n' | sort | uniq | tr -d '"' | tr '\n' ' '
  echo ''
}

# $1 build name
# $2 distro
# $3 src
jq_install_pkgs_from_src(){
  jq_install_wrapper "\
    | utils::install_get_pkgs_$3(\$install.$1; \$db; .$2)
    | .[]
  " | jq_clear_output
}

# $1 src (pkgmgr, curl, ...)
# $2 distro
# $3 groupname
jq_db_query_group_pkgs(){
  jq_db_wrapper "\
    | utils::db_groups_expand(\$toplevel; [\"$3\"]; .$1) as \$pkgs
    | utils::db_$1_get_pkgs(\$toplevel; \$pkgs; .$2)
    | .[]
  " | jq_clear_output
}

# $1 pkgname
# $2 distro
jq_db_query_pkgname(){
  jq_db_wrapper "\
    | utils::db_pkgmgr_get_pkg(\$toplevel; .$2; \"$1\") as \$pkgs
    | \$pkgs
    | .[]
  " | jq_clear_output
}

jq_install_list_builds(){
  jq_install_wrapper "\
    | utils::install_get_builds(\$install)
    | .[]
  " | jq_clear_output
}

jq_db_list_groups(){
  jq_db_wrapper '
    | utils::db_groups_get_all_names($toplevel)
    | .[]
  ' | jq_clear_output
}
