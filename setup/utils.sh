#!/usr/bin/env bash

command_exists(){
  command -v $1 &>/dev/null
}

ensure_yq_installed(){
  if ! command_exists yq ; then
    echo "This script depends on 'yq' to work, but 'yq' wasn't detected in your system!"
    echo "Attempting to install 'yq' for distro "${linuxdistro}"..."
    case $1 in
      'arch') sudo pacman -S jq go-yq ;;
      'gentoo') sudo emerge -av app-misc/jq app-misc/yq-go ;;
      *)
        echo "Ahhh: my script does not know how to install 'jq' and 'yq' for distro '${linuxdistro}'. Exiting..."
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

# $1 build name
# $2 distro
# $3 src
jq_install_pkgs_from_src(){
  jq_install_wrapper "\
    | utils::install_get_pkgs_$3(\$install.$1; \$db; .$2)
    | .[]
  " | jq_clear_output
}

jq_clear_output(){
  tr ' ' '\n' | sort | uniq | tr -d '"'
}
