#!/bin/bash

function main(){
	echo "Welcome to the post install script for Fedora ${FEDORA_VERSION:-'Unknown'}!"

	echo -e "Would you like to enable debugging? yes/no: "
	read debug_flag
	if [ debug_flag == "yes" ]; then
		set -xv
	fi

	# routine
}

function update_fedora(){
	# updating all system packages
	sudo dnf distro-sync

	# setting up rpm's free repo
	sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

	# advanced dnf tools
	sudo dnf -y install dnf-plugins-core

	# install flatpak if it isn't already installed
	if [ ! -a "/usr/bin/flatpak" ] ; then
		sudo dnf install flatpak -y
	fi
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org

	# remove nano
	sudo dnf uninstall nano -y
}

function install_programming_languages(){
	# C/C++ language
	local C_LANGUAGE="make gcc gdb valgrind"
	echo "Installing C language package: ${C_LANGUAGE}"
	sudo dnf install ${C_LANGUAGE} -y

	# Rust
	echo "Installing Rust"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

	# Go

	# Python

	# Javascript
	# echo "Javascript"
	# install nvm and latest stable version of npm
	# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
	# bash -c "nvm install --lts"

	# Lua
}

function install_cli_tools(){
	local COMMANDLINE_PROGRAMS="git tmux vim neovim micro lynx ffmpeg gparted"
	echo "Installing cli tools: ${COMMANDLINE_PROGRAMS}"
	sudo dnf install ${COMMANDLINE_PROGRAMS} -y
}

function install_flatpak_programs(){
	local FLATPAK_PROGRAMS="com.discordapp.Discord org.mypaint.MyPaint"
	echo "Installing flatpak apps: ${FLATPAK_PROGRAMS}"
	sudo flatpak install ${FLATPAK_PROGRAMS} -y
}

function install_nvidia_driver(){
	sudo dnf update -y # and reboot if you are not on the latest kernel
	sudo dnf install akmod-nvidia # rhel/centos users can use kmod-nvidia instead
	sudo dnf install xorg-x11-drv-nvidia-340xx-cuda #optional for cuda up to 6.5 support
	sudo dnf install vulkan

	## this is done by checking if the return of ??? command is ok (read more in the website)
	echo "Sleeping for 4min, while waiting for all nvidia modules get built..."
	sleep 240
}

function install_docker(){
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo 
	sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
	sudo systemctl start docker
}

function set_working_environment(){
	# config files
	git clone https://github.com/paisdegales/dotfiles.git ~

	# personal notes
	git clone https://github.com/paisdegales/notes.git ~

	# kitty terminal
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

	# fish shell
	sudo dnf install fish

	# awesome window manager
	sudo dnf install awesome

	# setup vim environment
	ln -s -r ~/dotfiles/.vimrc -t ~
	mkdir -p ~/.cache/vim/{backup,swap,undo}
	mkdir -p ~/.vim/{doc,ftplugin,pack,plugin}

	# setup tmux environment
	ln -s -r ~/dotfiles/.tmux.conf -t ~

	# setup lynx environment
	ln -s -r ~/dotfiles/lynx/ -t ~/.lynx

	# setup kitty terminal
	mv ~/.config/kitty/{kitty,kitty.old}.conf
	# some environment variables are defined here
	ln -s -r ~/dotfiles/kitty/kitty.conf -t ~/.config/kitty/
	
	# setup awesome
	mv ~/.config/awesome/{rc,rc.old}.lua
	# some environment variables are defined here
	ln -s -r ~/dotfiles/awesome/rc.lua -t ~/.config/awesome/
	ln -s -r ~/dotfiles/awesome/themes -t ~/.config/awesome/themes
	
	# setup fish shell
	# some environment variables are defined here
	ln -s -r ~/dotfiles/fish/config.fish -t ~/.config/fish/
	ln -s -r ~/dotfiles/fish/fish.variables -t ~/.config/fish/

	# set up git
	# GIT_AUTHOR_NAME
	# GIT_AUTHOR_EMAIL
	# GIT_COMMITER_NAME
	# GIT_COMMITER_EMAIL
}

function routine(){
	mkdir log

	log_file=log/update_fedora.log
	time update_fedora > ${log_file}

	log_file=log/install_cli_tools.log
	time install_cli_tools > ${log_file}

	log_file=log/install_programming_languages.log
	time install_programming_languages > ${log_file}

	log_file=log/set_working_environment.log
	time set_working_environment > ${log_file}

	log_file=log/install_flatpak_programs.log
	time install_flatpak_programs > ${log_file}

	# log_file=update_fedora.log
	# time install_nvidia_driver > ${log_file}

	# log_file=update_fedora.log
	# time install_docker > ${log_file}
}

main

# 6.4 BASH CONDITIONAL EXPRESSIONS
# 3.5 SHELL EXPANSION
# 3.2.5.1 LOOP
# 3.2.5.2 IF

# Insomnia, DBeaver, GIMP, Wireshark, OBS, Blender, Epiphany, VLC, Inkscape
