#!/usr/bin/fish

set dwm_version 6.5

sudo pacman -S xorg-{server,xsetroot,xauth,xinit,xrandr,server-xephyr,xclipboard} dmenu feh
wget "https://dl.suckless.org/dwm/dwm-$dwm_version.tar.gz"
gzip -d dwm-$dwm_version.tar.gz
tar -xf dwm-$dwm_version.tar
cd dwm-$dwm_version/
# git branch mydwl
# git switch mydwl
sudo cp ~/dotfiles/dwm/80-keyboard.conf /etc/X11/xorg.conf.d/
# config.h : sw -> kitty, Mod1Key -> Mod4Key
sudo cp ~/dotfiles/dwm/config.h ~/dwm-$dwm_version
sudo mkdir /usr/share/xsessions
sudo cp ~/dotfiles/dwm/dwm.desktop /usr/share/xsessions/dwm.desktop
ln -s ~/dotfiles/dwm/xinitrc ~/.xinitrc
ln -s ~/dotfiles/dwm/fehbg ~/.fehbg
make
sudo make install
