#!/bin/bash

# check if binaries exist before using them
# time all commands
# preferably test all commands in a vm
# 1 log per function ?
# get config files from github?
# kitty fish

DEV_TOOLS="git"
C_LANGUAGE="make gcc gdb valgrind"
MY_TOOLS="tmux vim neovim micro"
USEFUL_PROGRAMS="ffmpeg gparted"
FLATPAK_PROGRAMS="com.discordapp.Discord com.github.xournalpp.xournalpp com.obsproject.Studio net.lutris.Lutris org.mypaint.MyPaint"

function main(){
	if [ -z ${FEDORA_VERSION} ]; then
		echo "Post install script cannot start! Fedora version not identified!"
		exit
	fi

	echo "Welcome to the post install script for Fedora $(rpm -E %fedora)!"

	echo -e "Would you like to enable debugging? y/n: "
	read debug_flag
	if [ debug_flag == "yes" ]; then
		set -xv
	fi

	# updating all system packages
	# sudo dnf distro-sync
}

function install_dev_tools(){
	echo "Installing dev tools: ${DEV_TOOLS}"
	sudo dnf install ${DEV_TOOLS} -y
}

function install_c_language(){
	echo "Installing c language package: ${C_LANGUAGE}"
	sudo dnf install ${C_LANGUAGE} -y
}

function install_rpm_repos(){
	echo "Setting rpmfusion free and nonfree repositories"
	sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

function install_my_tools(){
	echo "Installing my fav programs: ${MY_TOOLS}"
	sudo dnf install ${MY_TOOLS} -y

	# override editor env variable
	echo -e "\nexport EDITOR=micro" >> ~/.bashrc
}

function install_useful_programs(){
	echo "Installing useful programs: ${USEFUL_PROGRAMS}"
	#obs1: ffmpeg is only available in the RPM fusion free/non-free repositories
	#obs2: ffmpeg is necessary to play some videos in firefox

	sudo dnf install ${USEFUL_PROGRAMS} --allow-erasing -y
}

function install_flatpak_programs(){
	if [ ! -a "/usr/bin/flatpak" ] ; then
		sudo dnf install flatpak -y
		flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo	
		flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org
	fi

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

function install_nvm(){
	# install nvm and latest stable version of npm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
	# spawn new shell and then execute this command
	# nvm install --lts
	bash -c "nvm install --lts"
}

function install_docker(){
	sudo dnf -y install dnf-plugins-core
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo 
	sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
	sudo systemctl start docker
}

main

#6.4 bash conditional expressions: options to be used in []
#3.5 shell expasions
#3.2.5.1 loops
#3.2.5.2 ifs
