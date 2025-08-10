#!/usr/bin/env bash

source utils.sh

usage(){
  echo "$0 [-d distro -s src [-b buildname | -g group]] [-j] [-D] [-v] [-h]"
  echo ''
  echo 'Description'
  echo 'This script prints one or more package names related to arbitrary softwares/services/resources found in a distro'
  echo ''
  echo 'Options'
  echo "-D: create my directory structure at $HOME and symbolic links to my dotfiles"
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

if test $# -lt 2; then
  usage
fi

create_folders(){
  mkdir $1/{tmp,vault,save,repos,books,german,txt,log}
  mkdir $1/.config/{,vim,fish,kitty,tmux,waybar,qutebrowser,dunst}
  mkdir $1/.cache $1/.cache/vim/{,backup,swap,undo}
  git clone https://github.com/cdavieira/dotfiles.git $1/repos
}

make_links(){
  ln -sf $1/dotfiles/fish/config.fish      $2/fish
  # ln -sf $1/dotfiles/fish/functions/*.fish $2/fish/functions
  ln -sf $1/dotfiles/vim/vimrc             $2/vim
  ln -sf $1/dotfiles/vim/snippets          $2/vim
  ln -sf $1/dotfiles/nvim/                 $2
  ln -sf $1/dotfiles/tmux/tmux.conf        $2/tmux
  ln -sf $1/dotfiles/mailcap/mailcap       ~/.mailcap
  ln -sf $1/dotfiles/waybar/config.jsonc   $2/waybar
  ln -sf $1/dotfiles/waybar/style.css      $2/waybar
  ln -sf $1/dotfiles/dunst/dunstrc         $2/dunst
  ln -sf $1/dotfiles/qutebrowser/config.py $2/qutebrowser
  ln -sf $1/dotfiles/init.sh ~
  case $1 in
    'arch')
      ln -sf $1/dotfiles/kitty/kitty-arch.conf $2/kitty/kitty.conf
      ;;
    'gentoo')
      ln -sf $1/dotfiles/kitty/kitty-gentoo.conf $2/kitty/kitty.conf
      ;;
    *) ;;
  esac

  if test -d "$1/code"; then
    sudo ln -sf $1/code/all/fish/projects/auto_pull.fish /usr/local/bin/auto_pull
    sudo ln -sf $1/code/all/fish/projects/auto_push.fish /usr/local/bin/auto_push
    sudo ln -sf $1/code/all/python/projects/qtb-tabsaver/main.py /usr/local/bin/tabsaver
  fi

  if test -d /etc/greetd; then
    sudo ln -sf $1/dotfiles/greetd/config.toml  /etc/greetd
    sudo ln -sf $1/dotfiles/greetd/dwl.sh       /etc/greetd
    sudo ln -sf $1/dotfiles/greetd/guigreet.sh  /etc/greetd
    sudo ln -sf $1/dotfiles/greetd/regreet.toml /etc/greetd
  fi
}

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

	# create desktop dirs and symbolic links
  	'D')
	  create_folders $prefix
	  make_links     $reposdir $xdgconfigdir
	  exit
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
