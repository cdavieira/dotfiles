#!/usr/bin/env fish

argparse \
  'h/help' \
  'p/path=' \
  'd/dotfile=' \
  'w/wlroots=' \
  's/setup' \
  'r/reinstall' \
-- $argv

# Routines
function dwl_help
	echo 'USAGE'
	echo './build.fish [-h|--help] [-p|--path] [-d|--dotfile] [-s|--setup] [-r|--reinstall] [-w|--wlroots]'
	echo ''
	echo 'OPTIONS'
	echo '-h/--help:      show this help message and quit'
	echo '-p/--path:      path to the directory where the dwl repository is located/should be downloaded'
	echo '-d/--dotfile:   path to the directory where my personal dwl dotfile folder is located'
	echo '-s/--setup:     download, build, compile and install dwl'
	echo '-r/--reinstall: rebuild, recompile and reinstall dwl'
	echo '-w/--wlroots:   path to the directory where wlroots\' repository is located/should be downloaded'
	echo ''
	echo 'EXAMPLES'
	echo 'Download and build both dwl and wlroots in ~/tmp/dwl and ~/tmp/dwl/wlroots (respectively) and compile/install dwl to /usr/local/bin'
	echo '	./build.fish -p ~/tmp/dwl -w ~/tmp/dwl/wlroots -s'
	echo ''
	exit
end

function dwl_inform
	if dwl_available
		set dwl_availability "(found)"
	else
		set dwl_availability "(not found)"
	end
	if wlroots_available
		set wlroots_availability "(found)"
	else
		set wlroots_availability "(not found)"
	end

	echo 'SCRIPT SUMMARY'
	echo "dwl path:     $dwl_path $dwl_availability"
	echo "dwl dotfile:  $dwl_dotfile"
	echo "dwl url:      $dwl_repo"
	echo "wlroots path: $dwl_wlroots_path $wlroots_availability"
	echo "wlroots url:  $dwl_wlroots_repo"
	echo ''
end

function dwl_available
	test -d $dwl_path
end

function dwl_download
	git clone $dwl_repo $dwl_path
end

function wlroots_available
	test -d $dwl_wlroots_path
end

function wlroots_download
	git clone $dwl_wlroots_repo $dwl_wlroots_path
end

function wlroots_build
	cd $dwl_wlroots_path
	meson setup build && ninja -C build
end

function dwl_apply_pre_patches
	# alternatively, sed could be used
	patch -b $dwl_path/config.mk $dwl_dotfile/patch/diff-configmk.patch
end

function dwl_rebuild
	cd $dwl_path
	make
end

function dwl_apply_post_patches
	# alternatively, sed could be used
	patch -b $dwl_path/config.h    $dwl_dotfile/patch/diff-config.patch
	patch -b $dwl_path/dwl.desktop $dwl_dotfile/patch/diff-desktop.patch
	# WARNING: the following patch went untested, but it is necessary. Apply it manually if needed.
	# patch -b $dwl_path/dwl.c $dwl_dotfile/patch/git-diff-dwl.patch
end

function dwl_install
	cd $dwl_path
	sudo make install
end

function dwl_reinstall
	cd $dwl_wlroots_path
	git pull
	meson setup --reconfigure build && ninja -C build

	cd $dwl_path
	make &&  sudo make install
end

function dwl_debug
	sed -f $dwl_dotfile/sed/dwl.sed $dwl_path/dwl.c 
end

function dwl_setup
	if ! dwl_available
		dwl_download
	end
	if ! wlroots_available
		wlroots_download
	end
	wlroots_build
	dwl_apply_pre_patches
	dwl_rebuild
	dwl_apply_post_patches
	dwl_rebuild
	ln -s $dwl_dotfile/startup.sh $dwl_path
	ln -s $dwl_dotfile/build.fish $dwl_path
	dwl_install
end

# Defaults
# TODO by default dwl looks for wlroots in the root directory of the project,
# therefore it is necessary to patch 'config.mk' in order to allow using a
# build of wlroots installed elsewhere
set dwl_path "$HOME/repos/dwl"
set dwl_dotfile "$HOME/repos/dotfiles/dwl"
set dwl_repo "https://codeberg.org/dwl/dwl"
set dwl_wlroots_path "$dwl_path/wlroots"
set dwl_wlroots_repo "https://gitlab.freedesktop.org/wlroots/wlroots.git"
if test -n "$_flag_dotfile"
	set dwl_dotfile "$_flag_dotfile"
end
if test -n "$_flag_path"
	set dwl_path "$_flag_path"
end
if test -n "$_flag_wlroots"
	set dwl_wlroots_path "$_flag_wlroots"
end

# Main
if test -n "$_flag_setup"
	dwl_inform
	dwl_setup
	exit
else if test -n "$_flag_reinstall"
	dwl_inform
	dwl_reinstall
	exit
end
dwl_help
