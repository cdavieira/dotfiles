#!/bin/sh

gentoo-pipewire-launcher &
# <&- closes standard input
waybar <&- &
swaybg -i ~/repos/dotfiles/dwl/background.png -m fit <&- &
