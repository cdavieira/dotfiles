#!/usr/bin/env bash

source utils.sh

usage(){
  echo 'Description'
  echo 'This script prints one or more package names related to arbitrary softwares/services/resources found in a distro'
  echo ''
  echo 'Usage'
  echo "$0 [-v | -h]"
  echo "$0 [-d distro -s src [-b buildname | -g group]]"
  echo "$0 [-d distro -j]"
  echo "$0 [-i -d distro -p pkg]"
  echo ''
  echo 'Options'
  echo "-j: install jq and yq"
  echo "-i: inform the name of a package for a distro"
  echo "-v: be verbose"
  echo "-h: print this help"
  echo 'Available distros:' 'arch' 'gentoo'
  echo 'Available sources:' 'pkgmgr' 'git' 'yarn' 'pip' 'cargo' 'curl'
  if has_yq; then
	  echo 'Available builds :' $(jq_install_list_builds)
	  echo 'Available groups :' $(jq_db_list_groups)
  fi
  echo ''
  echo 'Examples'
  echo 'Install jq/go-yq for gentoo:'
  echo "  $0 -j -d gentoo"
  echo 'See what packages are necessary to install ''docker'' in gentoo:'
  echo "  $0 -i -d gentoo -p docker"
  echo 'See what packages are necessary to install ''imv'' in arch:'
  echo "  $0 -i -d arch -p img"
  echo 'See what packages are in the group ''compositor'' for gentoo:'
  echo "  $0 -s pkgmgr -g compositor -d gentoo"
  echo 'See what packages are needed to install the ''mybuild'' build for gentoo:'
  echo "  $0 -s pkgmgr -b mybuild -d gentoo"
  echo ''
  echo 'Notes'
  echo 'This script requires jq and go-yq to be installed'
  if has_yq; then
	  echo '  jq/go-yq are already installed!'
  else
	  echo "  run '$0 -j -d <distro>' in order to try installing jq/go-yq"
  fi
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
pkg=""
verbose=false
routine=""

while getopts 'b:d:s:g:p:Dvhji' opt; do
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

	# inform
  	'i')
	  routine="INFORM"
  	;;

  	'p')
	  pkg="$OPTARG"
  	;;

	# jq and go-yq
  	'j')
	  routine="ENSURE"
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

if test -z "$linuxdistro"; then
  echo "Select a linux distro"
  exit
fi
 
case "${routine}" in
	'INFORM') jq_db_query_pkgname $pkg $linuxdistro
	;;
  	'ENSURE') ensure_yq_installed $linuxdistro
	;;
	*) 
	  if test -z "$src"; then
	    echo "Select a source"
	    exit
	  fi

	  if test -n "$build"; then
	    ensure_yq_installed $linuxdistro
	    if has_yq; then
	  	  jq_install_pkgs_from_src $build $linuxdistro $src
	    else
	  	  echo "Run '$0 -j' before proceeding!"
	    fi
	    exit
	  fi

	  if test -n "$group"; then
	    if has_yq; then
	  	  jq_db_query_group_pkgs $src $linuxdistro $group
	    else
	  	  echo "Run '$0 -j' before proceeding!"
	    fi
	    exit
	  fi
	;;
esac
