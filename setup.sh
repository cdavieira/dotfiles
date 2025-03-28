#!/usr/bin/env bash

prefix=$HOME
reposdir=$prefix/repos
xdgconfigdir=$prefix/.config

create_folders(){
	# creating home folders
	cd $prefix
	mkdir tmp save repos books german vids

	# creating $prefix/.config folders
	mkdir .config/{,vim,fish,kitty,tmux,waybar,qutebrowser,dunst}
	mkdir .config/vim/snippets

	# creating $prefix/.cache folders
	mkdir .cache/vim/{,backup,swap,undo}
}

clone_repos(){
	git clone https://codeberg.org/dwl/dwl.git ${reposdir}/dwl
	git clone https://github.com/cdavieira/dotfiles.git ${reposdir}
	#git clone https://github.com/cdavieira/notes.git ${reposdir}
	#git clone https://github.com/cdavieira/code.git ${reposdir}
}

# $1 current OS
make_links(){
	ln -sf ${reposdir}/dotfiles/fish/config.fish ${xdgconfigdir}/fish
	ln -sf ${reposdir}/dotfiles/vim/vimrc ${xdgconfigdir}/vim
	ln -s ${reposdir}/dotfiles/nvim/ ${xdgconfigdir}
	ln -sf ${reposdir}/dotfiles/tmux/tmux.conf ${xdgconfigdir}/tmux
	ln -s ${reposdir}/dotfiles/mailcap/mailcap ~/.mailcap
	ln -sf ${reposdir}/dotfiles/dwl/waybar-config.jsonc ${xdgconfigdir}/waybar
	ln -sf ${reposdir}/dotfiles/dwl/waybar-style.css ${xdgconfigdir}/waybar
	ln -sf ${reposdir}/dotfiles/dunst/dunstrc ${xdgconfigdir}/dunst
	ln -sf ${reposdir}/dotfiles/qutebrowser/config.py ${xdgconfigdir}/qutebrowser
	case $1 in
		'archlinux')
			ln -sf ${reposdir}/dotfiles/kitty/kitty-arch.conf ${xdgconfigdir}/kitty
			;;
		'gentoo')
			ln -sf ${reposdir}/dotfiles/kitty/kitty-gentoo.conf ${xdgconfigdir}/kitty
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

# TODO

install_packages_gentoo(){
  # this one is trickier because of USE_FLAGS
  # 1: check if /etc/portage/package.use/ has all files expected (found under dotfiles/gentoo/package.use/)
  # 2: if not, then warn the user about that and ask if he would like to continue or not
  # 3: OR: run 'sudo cp dotfiles/gentoo/package.use/* /etc/portage/package.use/' and continue
}

install_packages_arch(){
  # system
  SYSTEM_TOOLS="sudo git gcc cmake clang make pkg-config bear gdb valgrind \
  file which zip which wget usbutils unzip unrar tree lshw os-prober \
  efibootmgr ntfs-3g iwd"
  PROPRIETARY_DRIVERS="nvidia-open"
  OPENSOURCE_DRIVERS="mesa vulkan-intel"
  AUDIO="wireplumber pipewire-jack pipewire-alsa pipewire-pulse sof-firmware"
  PRINTER="cups cups-pdf"

  # user
  WAYLAND_CORE="wayland wayland-docs wayland-protocols wayland-utils xorg-xwayland qt6-wayland polkit wlroots"
  WAYLAND_APPS="kitty waybar xdg-desktop-portal-gtk xdg-desktop-portal-wlr wl-clipboard wf-recorder slurp grim swappy dunst fnott swaybg wl-mirror"
  TERMINAL_APPS="fish python-pynvim neovim vim nodejs ffmpeg fd ripgrep zathura zathura-pdf-poppler mpv imv vimiv syncthing"
  OPT_TERMINAL_APPS="glow mutt neomutt"
  GRAPHICAL_APPS="qutebrowser mypaint"
  OPT_GRAPHICAL_APPS="firefox discord xournalpp darktable gimp blender qemu-desktop libreoffice"
  FONTS="otf-firamono-nerd ttf-anonymouspro-nerd ttf-cascadia-code-nerd ttf-firacode-nerd ttf-hack-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono adobe-source-code-pro-fonts noto-fonts-emoji otf-font-awesome"
  MISC="gnome lua-language-server typescript-language-server python-lsp-server"
  # display manager missing


  SYSTEM_SERVICES="gdm cups cups-pdf"
  USER_SERVICES="wireplumber"
}

install_packages(){
	case $1 in
		'archlinux')
			;;
		'gentoo')
			;;
		*) ;;
	esac
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

echo "Would you like to clone repos to ${reposdir}? [y/N]"
read yes_clone_repos
if ! test "${yes_clone_repos}" = "y"; then
	yes_clone_repos="n"
fi

echo "Would you like to create links to ${xdgconfigdir}? [y/N]"
read yes_make_links
if ! test "${yes_make_links}" = "y"; then
	yes_make_links="n"
fi

echo "Would you like to create all custom dynamic libraries? [y/N]"
read yes_make_dyn_libs
if ! test "${yes_make_dyn_libs}" = "y"; then
	yes_make_dyn_libs="n"
fi

echo "Would you like to install packages? [y/N]"
read yes_install_pkgs
if ! test "${yes_install_pkgs}" = "y"; then
	yes_install_pkgs="n"
fi

##############################
##############################
##############################

if test ${yes_create_folders} = "y"; then
	echo "Creating folders..."
	create_folders
	echo "Ok"
fi
if test ${yes_clone_repos} = "y"; then
	echo "Cloning repos..."
	clone_repos
	echo "Ok"
fi
if test ${yes_make_links} = "y"; then
	echo "Creating symlinks for ${linuxdistro}..."
	make_links ${linuxdistro} 
	echo "Ok"
fi
if test ${yes_make_dyn_libs} = "y"; then
	echo "Creating dynamic libs..."
	make_dyn_libs
	echo "Ok"
fi
if test ${yes_install_pkgs} = "y"; then
	echo "Installing packages..."
	install_packages
	echo "Ok"
fi
