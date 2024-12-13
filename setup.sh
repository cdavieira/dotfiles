#!/usr/bin/env bash

prefix=$HOME
reposdir=$prefix/repos
xdgconfigdir=$prefix/.config

create_folders(){
	# creating home folders
	cd $prefix
	mkdir tmp save repos books german vids

	# creating $prefix/.config folders
	mkdir .config/{,vim,fish,kitty,tmux,waybar,qutebrowser}

	# creating $prefix/.cache folders
	mkdir .cache/vim/{,backup,swap,undo}
}

clone_repos(){
	git clone https://codeberg.org/dwl/dwl.git ${reposdir}
	git clone https://github.com/cdavieira/dotfiles.git ${reposdir}
	git clone https://github.com/cdavieira/notes.git ${reposdir}
	git clone https://github.com/cdavieira/code.git ${reposdir}
}

# $1 current OS
make_links(){
	ln -sf ${reposdir}/dotfiles/fish/config.fish ${xdgconfigdir}/fish
	ln -sf ${reposdir}/dotfiles/vim/vimrc ${xdgconfigdir}/vim
	ln -s ${reposdir}/dotfiles/nvim/ ${xdgconfigdir}
	ln -sf ${reposdir}/dotfiles/tmux/tmux.conf ${xdgconfigdir}/tmux
	ln -s ${reposdir}/dotfiles/mailcap/mailcap ~/.mailcap
	ln -sf ${reposdir}/dotfiles/waybar/config.jsonc ${xdgconfigdir}/waybar
	ln -sf ${reposdir}/dotfiles/waybar/style.css ${xdgconfigdir}/waybar
	case $1 in
		'archlinux')
			ln -sf ${reposdir}/dotfiles/kitty/kitty.conf ${xdgconfigdir}/kitty
			ln -sf ${reposdir}/dotfiles/qutebrowser/config.py ${xdgconfigdir}/qutebrowser
			;;
		'gentoo')
			ln -sf ${reposdir}/dotfiles/kitty/kitty-gentoo.conf ${xdgconfigdir}/kitty
			ln -sf ${reposdir}/dotfiles/qutebrowser/config-gentoo.py ${xdgconfigdir}/qutebrowser
			ln -s ${reposdir}/dotfiles/gentoo/init.sh ~
			;;
		*) ;;
	esac
}

make_dyn_libs(){
	local rootdir="${reposdir}/code/c/projects/types"
	if ! test -d "$rootdir"; then
		echo "Skip: missing 'code' repo when building dynamic libraries"
		return
	fi

	for dirname in 'wldraw' 'rational' 'stringUtils' 'sort' 'containers'; do
		make -C ${rootdir}/${dirname}
	done
	for dirname in 'wldraw' 'rational' 'stringUtils' 'sort' 'containers'; do
		make -C ${rootdir}/${dirname} 'local'
	done
}

#################################
#################################
#################################

echo "Welcome to my setup script!"
echo "This setup script is meant to be used right after the installation of either: ArchLinux, Gentoo or another OS of my likings"
echo "Inform which distribution you are on right now:"

select linuxdistro in archlinux gentoo; do
	break
done

echo "Distribution selected: ${linuxdistro}. Is that right? [y/N]"
read confirmation
if ! test "${confirmation}" = "y"; then
	echo "Exiting from setup script..."
	exit
fi

echo "Would you like to create folders in $prefix? [y/N]"
read yes_create_folders
if ! test "${yes_create_folders}" = "y"; then
	yes_create_folders="n"
fi

echo "Would you like to clone repos to $prefix/repos? [y/N]"
read yes_clone_repos
if ! test "${yes_clone_repos}" = "y"; then
	yes_clone_repos="n"
fi

echo "Would you like to create links to $prefix/.config? [y/N]"
read yes_make_links
if ! test "${yes_make_links}" = "y"; then
	yes_make_links="n"
fi

echo "Would you like to create all custom dynamic libraries? [y/N]"
read yes_make_dyn_libs
if ! test "${yes_make_dyn_libs}" = "y"; then
	yes_make_dyn_libs="n"
fi

##############################
##############################
##############################

if test ${yes_create_folders} = "y"; then
	echo "Creating folders..."
	#create_folders
	echo "Ok"
fi
if test ${yes_clone_repos} = "y"; then
	echo "Cloning repos..."
	#clone_repos
	echo "Ok"
fi
if test ${yes_make_links} = "y"; then
	echo "Creating symlinks for ${linuxdistro}..."
	#make_links ${linuxdistro} 
	echo "Ok"
fi
if test ${yes_make_dyn_libs} = "y"; then
	echo "Creating dynamic libs..."
	#make_dyn_libs
	echo "Ok"
fi
