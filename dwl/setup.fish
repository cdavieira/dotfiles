#!/usr/bin/fish

argparse 'h/help' 'c/config' 'm/makefile' 'd/debug' -- $argv

if test -n "$_flag_h"
	echo 'dwl_setup.fish [-h/--help] [-c/--config] [-m/--makefile] [-d/--debug]'
	echo ''
	echo '-h/--help: show this help message and quit'
	echo '-c/--config: create new config header file out of config.def.h'
	echo '-m/--makefile: create new config makefile out of config.def.mk '
	echo '-d/--debug: create a complete config header for debugging'
	exit
end

set dwl_path "$HOME/sometimes/repos/dwl"
set dwl_dotfile "$HOME/dotfiles/dwl"
cd $dwl_path
git branch mydwl
git switch mydwl
if test $status -ne 0
	echo "dwl_setup.fish: fail"
	exit 1
end

if test -n "$_flag_c"
	sed -f $dwl_dotfile/configh.sed $dwl_path/config.def.h > $dwl_path/config.h
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
