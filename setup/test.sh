#!/usr/bin/env bash

source utils.sh

# jq_db_wrapper '
#   | utils::filter_selected(["hello", "world", "how", "are", "you"]; ["hello", "are"]; .)
# '

# jq_db_wrapper '
#   | utils::filter_out(["hello", "world", "how", "are", "you"]; ["hello", "are"]; .)
# '

# jq_db_wrapper '
#   | utils::db_pkgmgr_get_all_pkgs($toplevel; .arch)
#   | .
# '

# jq_db_wrapper '
#   | utils::db_groups_get_all_names($toplevel)
#   | .
# '

# jq_db_wrapper '
#   | utils::db_groups_get_all_names($toplevel) as $groups
#   | utils::db_groups_expand($toplevel; $groups; .git?) as $pkgs
#   | $pkgs
# '

# jq_db_wrapper '
#   | utils::db_groups_get_all_names($toplevel) as $groups
#   | utils::db_groups_expand($toplevel; ["mynettools"]; .pkgmgr) as $pkgs
#   | $pkgs
# '

# jq_db_wrapper '
#   | utils::db_groups_get_all_names($toplevel) as $groups
#   | utils::db_groups_expand($toplevel; ["mynettools"]; .pkgmgr) as $pkgs
#   | utils::db_pkgmgr_get_pkgs($toplevel; $pkgs; .arch) as $selected
#   | $selected
# '

# jq_db_wrapper '
#   | utils::db_groups_get_all_names($toplevel) as $groups
#   | utils::db_groups_expand($toplevel; ["mynettools"]; .pkgmgr) as $pkgs
#   | utils::db_pkgmgr_get_pkgs_except($toplevel; $pkgs; ["curl"]; .arch) as $selected
#   | $selected
# '

# jq_db_wrapper '
#   | utils::db_git_get_all_objs($toplevel)
#   | .
# '

# jq_db_wrapper '
#   | utils::db_git_get_all_names($toplevel)
#   | .
# '

# jq_db_wrapper '
#   | utils::db_git_get_all_urls($toplevel)
#   | .
# '

# jq_db_wrapper '
#   | utils::db_git_get_urls_except($toplevel; ["dwl", "wlopm", "brillo", "nvm", "ladybird", "regreet", "gtkgreet"]; ["gtkgreet"])
#   | .
# '

# jq_db_wrapper '
#   | utils::db_services_get_all_objs($toplevel; .arch)
#   | .
# '

# jq_db_wrapper '
#   | utils::db_services_get_all_names($toplevel; .arch)
#   | .
# '

# jq_db_wrapper '
#   | utils::db_flatpak_get_all_names($toplevel)
#   | .
# '

# jq_db_wrapper '
#   | utils::db_flatpak_get_urls_except($toplevel; ["gimp"]; ["nah"])
#   | .
# '

# jq_db_wrapper '
#   | utils::db_pkgmgr_get_all_pkgs($toplevel; .arch)
#   | .
# '

# pkgs=$(jq_db_wrapper '
#   | utils::db_pkgmgr_get_all_pkgs($toplevel; .gentoo)
#   | .[]
# ')
# echo $pkgs | jq_clear_output

# jq_install_wrapper '
#   | $db
# '

# jq_install_wrapper '
#   | $install
# '

# jq_install_wrapper '
#   | utils::install_get_pkgs_from_src($install.mybuild; $db; .git)
#   | .
# '

# jq_install_wrapper '
#   | utils::install_get_pkgs_from_groups($install.mybuild; $db; .pkgmgr)
#   | .
# '

# jq_db_wrapper '
#   | utils::db_pkgmgr_get_pkgs($toplevel; ["git", "curl", "wayland", "xdg-portals", "xwayland"]; .gentoo)
#   | .
# '

jq_install_wrapper '
  | utils::install_get_pkgs_pkgmgr($install.mybuild; $db; .gentoo)
  | .
'

# jq_install_wrapper '
#   | utils::install_get_pkgs_git($install.mybuild; $db; .gentoo)
#   | .
# '

