#!/usr/bin/env bash

# <&- closes standard input
gentoo-pipewire-launcher <&- &
waybar <&- &
#swaybg -i ~/repos/dotfiles/dwl/background.png -m fit <&- &
swaybg -i ~/repos/dotfiles/dwl/orangutan.png -m fit <&- &
dunst <&- &
