#!/usr/bin/fish

# <&- closes standard input
waybar <&- &
swaybg -i ~/dotfiles/dwl/background.png -m fit <&- &
#cat > ~/dwl.log
