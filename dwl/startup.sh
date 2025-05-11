#!/usr/bin/env bash

# <&- closes standard input

# https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
# command --help
command_exists(){
	command -v $1 &>/dev/null
	return 
}

mywallpaper="$HOME/repos/dotfiles/wallpapers/orangutan.png"

if command_exists gentoo-pipewire-launcher; then
  gentoo-pipewire-launcher <&- &
else
  echo "dwl-startup.sh: fail when starting pipewire (gentoo)"
fi

if command_exists waybar; then
  waybar <&- &
else
  echo "dwl-startup.sh: fail when starting bar (waybar not found)"
fi

if test -e ${mywallpaper}; then
  swaybg -i ${mywallpaper} -m fit <&- &
else
  echo "dwl-startup.sh: fail when setting background (swaybg not found)"
fi

if command_exists dunst; then
  dunst <&- &
else
  echo "dwl-startup.sh: fail when starting notify-daemon (dunst not found)"
fi

# TODO: maybe use xdg-screensaver instead of swayidle/wlopm/swaylock?
if command_exists swayidle && command_exists swaylock && command_exists wlopm; then
  swayidle -w \
    timeout 600 'swaylock -f -c 000000' \
    timeout 1200 'wlopm --off eDP-1' \
    resume 'wlopm --on eDP-1'
else
  echo "dwl-startup.sh: fail when starting screensaving service (swayidle/swaylock/wlopm not found)"
fi
