#!/usr/bin/env fish

set prefix $HOME/repos
set dotfile $prefix/dotfiles

###

cd $prefix

git clone https://github.com/swaywm/sway.git
cd sway

mkdir subprojects
cd subprojects
git clone https://gitlab.freedesktop.org/wlroots/wlroots/
meson setup build/
ninja -C build/
cd ..

meson build/
ninja -C build/
sudo ninja -C build/ install

# sudo ninja -C build/ uninstall

mkdir -p ~/.config/sway
cp $dotfile/sway/config ~/.config/sway
