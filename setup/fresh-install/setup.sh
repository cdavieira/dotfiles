#!/usr/bin/env bash

source utils.sh

usage(){
  echo "$0 [-d distro -s src [-b buildname | -g group]] [-d distro -j] [-v] [-h]"
  echo ''
  echo 'Description'
  echo 'This script prints one or more package names related to arbitrary softwares/services/resources found in a distro'
  echo ''
  echo 'Options'
  echo "-j: install jq and yq"
  echo "-v: be verbose"
  echo "-h: print this help"
  echo 'Available distros:' 'arch' 'gentoo'
  echo 'Available sources:' 'pkgmgr' 'git' 'yarn' 'pip' 'cargo' 'curl'
  if has_yq; then
	  echo 'Available builds :' $(jq_install_list_builds)
	  echo 'Available groups :' $(jq_db_list_groups)
  fi
  echo ''
  echo 'Notes'
  echo 'This script requires jq and go-yq to be installed'
  exit
}

if test $# -eq 0; then
  usage
fi

#################################
#################################
#################################

prefix=$HOME
reposdir=$prefix/repos
xdgconfigdir=$HOME/.config
linuxdistro=""
src=""
build=""
group=""
verbose=false

while getopts 'b:d:s:g:Dvhj' opt; do
  # $OPTIND, $OPTARG
  case "$opt" in
  	'b')
	  build="$OPTARG"
  	;;

	# distro
  	'd')
	  case "$OPTARG" in
	  	'arch'|'gentoo')
		  linuxdistro="$OPTARG"
	  	;;
	  	*)
		  echo 'Unknown distro:' $OPTARG
		  exit
	  	;;
	  esac
  	;;

	# source
  	's')
	  case "$OPTARG" in
	  	'pkgmgr'|'git'|'yarn'|'pip'|'cargo'|'curl')
		  src="$OPTARG"
	  	;;
	  	*)
		  echo 'Unknown source:' $OPTARG
		  exit
	  	;;
	  esac
  	;;

	# group
  	'g')
	  group="$OPTARG"
  	;;

	# jq and go-yq
  	'j')
	  ensure_yq_installed $linuxdistro
  	;;

	# verbose
  	'v')
	  verbose=true
  	;;

	# usage
  	'h'|'?')
	  usage
	;;
  	*)
	  usage
  	;;
  esac
done

if $verbose; then
  echo 'Selected distro linux:' $linuxdistro
  echo 'Selected src:' $src
  echo 'Selected build:' $build
  echo 'Selected group:' $group
fi

if test -z "$linuxdistro" || test -z "$src"; then
  echo "Select a linux distro and a source"
  exit
fi

if test -z "$build" && test -z "$group"; then
  echo "Select a build or a group"
  exit
fi
 
if test -n "$build"; then
  ensure_yq_installed $linuxdistro
  if has_yq; then
	  jq_install_pkgs_from_src $build $linuxdistro $src
  else
	  echo "Run '$0 -j' before proceeding!"
	  exit
  fi
fi

if test -n "$group"; then
  if has_yq; then
	  jq_db_query_group_pkgs $src $linuxdistro $group
  else
	  echo "Run '$0 -j' before proceeding!"
	  exit
  fi
fi
