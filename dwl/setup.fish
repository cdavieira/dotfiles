#!/usr/bin/fish

argparse 'h/help' 'b/branch' 'c/config' 'm/makefile' 'd/debug' 's/startup' -- $argv

if test -n "$_flag_h"
	echo 'dwl_setup.fish [-h/--help] [-c/--config] [-m/--makefile] [-d/--debug]'
	echo ''
	echo '-h/--help: show this help message and quit'
	echo '-b/--branch: create a new branch called "mydwl" and switch to it'
	echo '-c/--config: create new config header file out of config.def.h'
	echo '-d/--debug: create a complete config header for debugging purposes'
	echo '-m/--makefile: create new config makefile out of config.def.mk'
	echo '-s/--startup: add "~/dotfiles/dwl/startup.fish" as the startup command for dwl'
	exit
end

set dwl_path "$HOME/repos/dwl"
set dwl_dotfile "$HOME/dotfiles/dwl"
cd $dwl_path

if test -n "$_flag_b"
	git branch mydwl
	git switch mydwl
end

if test -n "$_flag_c"
	sed -f $dwl_dotfile/config.sed $dwl_path/config.def.h > $dwl_path/config.h
end

if test -n "$_flag_m"
	if not test -f 'config.def.mk'
		cp config.mk config.def.mk
	end
	sed -e '/^\#XWAYLAND/ s/\#//' -e '/^\#XLIBS/ s/\#//' $dwl_path/config.def.mk > $dwl_path/config.mk
end

if test -n "$_flag_d"
	sed -e '/#include "config.h"/,$ d' $dwl_path/dwl.c > $dwl_path/configclangd.h
	cat $dwl_path/config.def.h >> $dwl_path/configclangd.h
end

if test -n "$_flag_s"
	sed '/^Exec=dwl/ c\Exec=dwl -s /home/carlos/dotfiles/dwl/startup.fish' $dwl_path/dwl.desktop > $dwl_path/dwl.desktop.new
end
