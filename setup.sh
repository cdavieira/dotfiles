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
	cd ${reposdir}
	git clone https://codeberg.org/dwl/dwl.git
	git clone https://github.com/cdavieira/dotfiles.git
	git clone https://gitlab.com/cameronnemo/brillo
	#git clone https://github.com/cdavieira/notes.git
	#git clone https://github.com/cdavieira/code.git
}

remove_duplicates(){
	echo $@ | tr ' ' '\n' | sort | uniq
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
build_dwl(){

}

build_brillo(){
	sudo usermod -aG video carlos
	cd ${reposdir}/brillo
	make
	sudo make install
}

# TODO
install_packages_gentoo(){
  # this one is trickier because of USE_FLAGS
  # 1: check if /etc/portage/package.use/ has all files expected (found under dotfiles/gentoo/package.use/)
  # 2: if not, then warn the user about that and ask if he would like to continue or not
  # OR: run 'sudo cp dotfiles/gentoo/package.use/* /etc/portage/package.use/' and continue

  # obs: this will function likely break once in a while in the future (more
  # than for ArchLinux, which should be relatively much more stable)

  sudo cp ${reposdir}/dotfiles/gentoo/package.use/* /etc/portage/package.use/
  
  # get the list of installed packages from 'emerge' and put them here
}

# some packages (such as linux, mandb, man-pages, base, base-devel,
# intel-ucode, iwd, efibootmgr, dhcpcd) will mostly likely (or should) be
# already installed before this script gets to be executed
install_packages_arch(){
  SYSTEM_UTILITIES="sudo git file which zip unzip unrar wget curl gpg pass go-md2man"
  SYSTEM_BUILD="gcc cmake clang make pkg-config gdb valgrind bear nodejs flex bison graphviz"
  SYSTEM_MOUNT="ntfs-3g"
  SYSTEM_EFI="os-prober efibootmgr"
  SYSTEM_WIRELESS="iwd dhcpcd"
  SYSTEM_QUERY="usbutils tree lshw vulkaninfo"
  SYSTEM_PRINTER="cups cups-pdf"
  SYSTEM_ARCH_SPECIFIC="pacman-contrib"

  DRIVER_VIDEO_INTEL="mesa vulkan-intel vulkan-tools"
  DRIVER_VIDEO_NVIDIA_OPENSOURCE="mesa vulkan-nouveau vulkan-tools"
  DRIVER_VIDEO_NVIDIA_PROPRIETARY="nvidia-open"
  DRIVER_AUDIO="sof-firmware wireplumber pipewire-jack pipewire-alsa pipewire-pulse"

  DISPLAY_SERVER="wayland wayland-docs wayland-protocols wayland-utils xorg-xwayland qt6-wayland"
  WINDOW_MANAGER="wlroots polkit"
  # DISPLAY_MANAGER="greetd"
  USER_FONTS="otf-firamono-nerd ttf-anonymouspro-nerd ttf-cascadia-code-nerd ttf-firacode-nerd ttf-hack-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono adobe-source-code-pro-fonts noto-fonts-emoji otf-font-awesome"

  APP_CLIPBOARD="wl-clipboard"
  APP_TERMINAL="kitty"
  APP_BROWSER="qutebrowser"
  APP_BAR="waybar"
  APP_BLUETOOTH="bluez bluez-tools bluez-utils"
  APP_NOTIFICATION="dunst"
  APP_BACKGROUND="swaybg"
  APP_SCREENRECORDER="wf-recorder"
  APP_SCREENSHOT="slurp grim swappy"
  APP_SCREENSHARE="wl-mirror"
  APP_PORTALS="xdg-desktop-portal-gtk xdg-desktop-portal-wlr"
  APP_VIEWER_PDF="zathura zathura-pdf-poppler"
  APP_VIEWER_VIDEO="mpv"
  APP_VIEWER_IMAGE="imv vimiv"
  APP_FILESHARE="syncthing"
  APP_SHELL="fish"
  APP_PAINT="mypaint"
  APP_EDITOR="vim python-pynvim neovim"
  APP_TERMINAL="bat fd ripgrep"
  APP_MEDIA="ffmpeg"
  APP_MISC="discord"
  # APP_POWERMANAGEMENT="swayidle swaylock wlopm"
  # APP_LS="lua-language-server typescript-language-server python-lsp-server"
  # APP_DESKTOP="gnome gnome-extra"
  # APP_EMAIL="thunderbird"
  # APP_EDITOR_PDF="xournalpp"
  # APP_EDITOR_IMAGE="darktable gimp inkscape"
  # APP_EDITOR_3D="blender freecad"
  # APP_EDITOR_DOC="libreoffice"
  # APP_HYPERVISOR="qemu-desktop"
  # APP_FILEEXPLORER="dolphin"
  # APP_OPT_BROWSER="firefox"
  # APP_OPT_NOTIFICATION="fnott"
  # APP_OPT_MISC="glow glade mutt neomutt"

  # if using GNOME as the desktop environment, add 'gdm' to 'SERVICES_SYSTEM'
  SERVICES_SYSTEM="cups cups-pdf iwd bluetooth"
  SERVICES_USER="wireplumber"

  PKGS_SYSTEM=$(remove_duplicates $SYSTEM_UTILITIES $SYSTEM_BUILD $SYSTEM_MOUNT $SYSTEM_EFI $SYSTEM_WIRELESS $SYSTEM_QUERY $SYSTEM_PRINTER)
  PKGS_DRIVER=$(remove_duplicates $DRIVER_VIDEO_INTEL $DRIVER_VIDEO_NVIDIA_OPENSOURCE $DRIVER_AUDIO $DISPLAY_SERVER $WINDOW_MANAGER)
  PKGS_APPS=$(remove_duplicates $APP_CLIPBOARD $APP_TERMINAL $APP_BROWSER $APP_BAR $APP_NOTIFICATION $APP_BACKGROUND $APP_SCREENRECORDER \
  $APP_SCREENSHOT $APP_SCREENSHARE $APP_PORTALS $APP_VIEWER_PDF $APP_VIEWER_VIDEO $APP_VIEWER_IMAGE $APP_FILESHARE \
  $APP_SHELL $APP_PAINT $APP_EDITOR $APP_TERMINAL $APP_MEDIA $APP_MISC $APP_BLUETOOTH $USER_FONTS)
  PKGS_ALL=$(remove_duplicates $PKGS_SYSTEM $PKGS_DRIVER $PKGS_APPS)

  sudo pacman -S $PKGS_ALL
  sudo systemctl enable $SERVICES_SYSTEM
  sudo systemctl --user enable $SERVICES_USER
}

install_packages(){
	case $1 in
		'archlinux')
			install_packages_arch
			;;
		'gentoo')
			install_packages_gentoo
			;;
		*) ;;
	esac
	build_dwl
	build_brillo
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
