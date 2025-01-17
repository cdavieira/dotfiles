#!/bin/sh

# <&- closes standard input
gentoo-pipewire-launcher <&- &
waybar <&- &
swaybg -i ~/repos/dotfiles/dwl/background.png -m fit <&- &
dunst <&- &
