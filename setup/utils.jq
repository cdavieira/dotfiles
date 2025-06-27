# generic

# Overview:
# returns a list of the elements of $all found in $selected
#
# Parameters:
# $all: a list of elements
# $selected: a list of the elements you want to be selected
# f: a filter, which gets applied to each member of $all.
#
# Return:
# A list (a subset of $all)
#
# Pseudocode:
#   elements_found = []
#   for element in $all:
#     prop = f(element)
#     if prop in $selected:
#       elements_found.append(element)
#   return elements_found
def filter_selected($all; $selected; f):
  [ $all[] | select(f as $n | $selected | index($n)) ]
;

# Obs: maybe this could be implemented with the '-' operator
def filter_out($all; $toberemoved; f):
  [ $all[] | select(f as $n | $toberemoved | index($n) | not) ]
;

# Overview:
# returns a list of elements whose property accessed by 'f' is non
# null.
# This function expects the input list to be passed with the pipe
# '|' operator
#
# Parameters:
# f: a filter, which gets applied to each member of the list
#    and gives access to the property that should be checked
#
# Return:
# A list of elements whose property accessed by f is non null
#
# Pseudocode:
#   elements_found = []
#   for element in $all:
#     prop = f(element)
#     if prop is not null:
#       elements_found.append(element)
#   return elements_found
def filter_null(f):
  [ .[] | select(f | values) ]
;

def merge_arrays($array1; $array2):
  ( $array1 + $array2 )
;



# db.yaml related

# The following functions are tied to how db.yaml is structured

# In that sense, if the format of how data is layed in the yaml
# changes, then these functions will need to be adapted

# Since the execution of these functions is pretty straight forward
# and because they are very short, it shouldn't be hard to
# introduce changes to db.yaml and change the implementation of
# each function

# Also, even if db.yaml gets redesigned, try to mantain the API as
# it is, so that any code that uses it stays the same

## package manager
def db_pkgmgr_get_all_pkgs($toplevel; distro):
  [ $toplevel.packages.pkgmgr[] | distro ]
  | flatten
  | filter_null(.)
;

def db_pkgmgr_get_pkgs($toplevel; $pkgs; distro):
  filter_selected($toplevel.packages.pkgmgr; $pkgs; .name)
  | map(distro)
  | flatten
  | filter_null(.)
;

def db_pkgmgr_get_pkgs_except($toplevel; $pkgs; $ignore; distro):
  filter_selected($toplevel.packages.pkgmgr; $pkgs; .name) as $selected
  | filter_out($selected; $ignore; .name)
  | map(distro)
  | flatten
  | filter_null(.)
;

## groups
def db_groups_get_all_names($toplevel):
  # both ways work
  # $toplevel.groups | map(.name)
  [ $toplevel.groups[].name ]
;

def db_groups_expand($toplevel; $groups; src):
  filter_selected($toplevel.groups; $groups; .name)
  | map(src)
  | flatten
  | filter_null(.)
  | unique
;

## shared backend implementation for git/curl/yarn/pip/flatpak/cargo
def db_X_get_all_objs($toplevel; method):
  $toplevel.packages
  | method
;

def db_X_get_all_names($toplevel; method):
  $toplevel.packages
  | method
  | map(.name)
  | filter_null(.)
;

def db_X_get_all_urls($toplevel; method):
  $toplevel.packages
  | method
  | map(.url)
  | filter_null(.)
;

def db_X_get_urls_except($toplevel; method; $select; $except):
  $toplevel.packages
  | method as $all
  | filter_selected($all; $select; .name) as $selected
  | filter_out($selected; $except; .name)
  | map(.url)
;

## git
def db_git_get_all_objs($toplevel):
  db_X_get_all_objs($toplevel; .git)
;

def db_git_get_all_names($toplevel):
  db_X_get_all_names($toplevel; .git)
;

def db_git_get_all_urls($toplevel):
  db_X_get_all_urls($toplevel; .git)
;

def db_git_get_urls_except($toplevel; $select; $ignore):
  db_X_get_urls_except($toplevel; .git; $select; $ignore)
;

## curl
def db_curl_get_all_objs($toplevel):
  db_X_get_all_objs($toplevel; .curl)
;

def db_curl_get_all_names($toplevel):
  db_X_get_all_names($toplevel; .curl)
;

def db_curl_get_all_urls($toplevel):
  db_X_get_all_urls($toplevel; .curl)
;

def db_curl_get_urls_except($toplevel; $select; $ignore):
  db_X_get_urls_except($toplevel; .curl; $select; $ignore)
;

## yarn
def db_yarn_get_all_objs($toplevel):
  db_X_get_all_objs($toplevel; .yarn)
;

def db_yarn_get_all_names($toplevel):
  db_X_get_all_names($toplevel; .yarn)
;

def db_yarn_get_all_urls($toplevel):
  db_X_get_all_urls($toplevel; .yarn)
;

def db_yarn_get_urls_except($toplevel; $select; $ignore):
  db_X_get_urls_except($toplevel; .yarn; $select; $ignore)
;

## pip
def db_pip_get_all_objs($toplevel):
  db_X_get_all_objs($toplevel; .pip)
;

def db_pip_get_all_names($toplevel):
  db_X_get_all_names($toplevel; .pip)
;

def db_pip_get_all_urls($toplevel):
  db_X_get_all_urls($toplevel; .pip)
;

def db_pip_get_urls_except($toplevel; $select; $ignore):
  db_X_get_urls_except($toplevel; .pip; $select; $ignore)
;

## flatpak
def db_flatpak_get_all_objs($toplevel):
  db_X_get_all_objs($toplevel; .flatpak)
;

def db_flatpak_get_all_names($toplevel):
  db_X_get_all_names($toplevel; .flatpak)
;

def db_flatpak_get_all_urls($toplevel):
  db_X_get_all_urls($toplevel; .flatpak)
;

def db_flatpak_get_urls_except($toplevel; $select; $ignore):
  db_X_get_urls_except($toplevel; .flatpak; $select; $ignore)
;

## cargo
def db_cargo_get_all_objs($toplevel):
  db_X_get_all_objs($toplevel; .cargo)
;

def db_cargo_get_all_names($toplevel):
  db_X_get_all_names($toplevel; .cargo)
;

def db_cargo_get_all_urls($toplevel):
  db_X_get_all_urls($toplevel; .cargo)
;

def db_cargo_get_urls_except($toplevel; $select; $ignore):
  db_X_get_urls_except($toplevel; .cargo; $select; $ignore)
;

## services
def db_services_get_all_objs($toplevel; distro):
  $toplevel.services
  | map(distro)
  | filter_null(.name)
;

def db_services_get_all_names($toplevel; distro):
  db_services_get_all_objs($toplevel; distro)
  | map(.name)
;



# install.yaml related

def install_get_builds($install):
  $install | keys
;

def install_get_pkgs_from_src($build; $db; src):
  $build.srcs
  | src // []
  | filter_null(.)
;

def install_get_pkgs_from_groups($build; $db; src):
  $build.group
  | filter_null(.) as $groups
  | db_groups_expand($db; $groups; src)
;

def install_get_pkgs_for($build; $db; src):
  install_get_pkgs_from_src($build; $db; src) as $spkgs
  | install_get_pkgs_from_groups($build; $db; src) as $gpkgs
  | merge_arrays($spkgs; $gpkgs)
;

def install_get_pkgs_pkgmgr($build; $db; distro):
  install_get_pkgs_for($build; $db; .pkgmgr?) as $pkgs
  | db_pkgmgr_get_pkgs($db; $pkgs; distro)
;

def install_get_pkgs_git($build; $db; distro):
  install_get_pkgs_for($build; $db; .git?) as $pkgs
  | db_git_get_urls_except($db; $pkgs; [])
;

def install_get_pkgs_curl($build; $db; distro):
  install_get_pkgs_for($build; $db; .curl?) as $pkgs
  | db_curl_get_urls_except($db; $pkgs; [])
;

def install_get_pkgs_cargo($build; $db; distro):
  install_get_pkgs_for($build; $db; .cargo?) as $pkgs
  | db_cargo_get_urls_except($db; $pkgs; [])
;

def install_get_pkgs_yarn($build; $db; distro):
  install_get_pkgs_for($build; $db; .yarn?) as $pkgs
  | db_yarn_get_urls_except($db; $pkgs; [])
;

def install_get_pkgs_pip($build; $db; distro):
  install_get_pkgs_for($build; $db; .pip?) as $pkgs
  | db_pip_get_urls_except($db; $pkgs; [])
;





# other stuff
# map_values!
# .[] != map, because .[] returns an iterator, whilst map a list
