#!/usr/bin/fish

argparse 'h/help' -- $argv

if test -n "$_flag_h"
	echo 'dwl_setup.fish [-h/--help]'
	echo ''
	echo '-h/--help: show this help message and quit'
	exit
end

set dwl_path "$HOME/repos/dwl"
set dwl_dotfile "$HOME/repos/dotfiles/dwl"

function dwl_available
	test -d $dwl_path
	return 
end

function dwl_download
	git clone https://codeberg.org/dwl/dwl $dwl_path
end

function wlroots_available
	cd $dwl_path
	ls | grep wlroots
	return 
end

function wlroots_download
	cd $dwl_path
	git clone https://gitlab.freedesktop.org/wlroots/wlroots.git
end

function wlroots_build
	cd $dwl_path/wlroots
	meson setup build && ninja -C build
end

function apply_pre_patches
	# sed could be used alternatively
	patch -b $dwl_path/config.mk $dwl_dotfile/patch/diff-configmk.patch
end

function dwl_rebuild
	cd $dwl_path
	make
end

function apply_post_patches
	# sed could be used alternatively
	patch -b $dwl_path/config.h    $dwl_dotfile/patch/diff-config.patch
	patch -b $dwl_path/dwl.desktop $dwl_dotfile/patch/diff-desktop.patch
end

function dwl_install
	cd $dwl_path
	sudo make install
end

function dwl_reinstall
	cd $dwl_path/wlroots
	git pull
	sudo meson setup --reconfigure build && ninja -C build

	cd ..
	make &&  sudo make install
end

function dwl_debug
	sed -f $dwl_dotfile/sed/dwl.sed $dwl_path/dwl.c 
end

function run_once
	if ! dwl_available
		dwl_download
	end
	if ! wlroots_available
		wlroots_download
	end
	wlroots_build
	apply_pre_patches
	dwl_rebuild
	apply_post_patches
	dwl_rebuild
	ln -s $dwl_dotfile/startup.sh $dwl_path
	ln -s $dwl_dotfile/build.fish $dwl_path
	dwl_install
end

# run_once
dwl_reinstall
