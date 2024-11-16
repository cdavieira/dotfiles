#!/bin/sh

# basic folder structure at $HOME
mkdir ~/temp ~/persistent ~/repos ~/
mkdir ~/.config/{,vim,fish,kitty,tmux,waybar,qutebrowser}
mkdir ~/.cache/vim/{,backup,swap,undo}

# cloning git repos
git clone https://codeberg.org/dwl/dwl.git ~/repos
git clone https://github.com/cdavieira/notes.git ~/repos
git clone https://github.com/cdavieira/code.git ~/repos

# creating symlinks
ln -s ~/repos/dotfiles/mailcap/mailcap ~/.mailcap
ln -s ~/repos/dotfiles/nvim/ ~/.config
ln -sf ~/repos/dotfiles/fish/config.fish ~/.config/fish
ln -sf ~/repos/dotfiles/tmux/tmux.conf ~/.config/tmux
ln -sf ~/repos/dotfiles/vim/vimrc ~/.config/vim
ln -sf ~/repos/dotfiles/waybar/config.jsonc ~/.config/waybar
ln -sf ~/repos/dotfiles/waybar/style.css ~/.config/waybar
## arch/gentoo specific
ln -sf ~/repos/dotfiles/kitty/kitty.conf ~/.config/kitty
ln -sf ~/repos/dotfiles/qutebrowser/config.py ~/.config/qutebrowser
ln -s ~/repos/dotfiles/gentoo/init.sh ~

# building custom dynamic libraries
make -C '~/repos/code/c/projects/types/wldraw/'
make -C '~/repos/code/c/projects/types/rational'
make -C '~/repos/code/c/projects/types/stringUtils'
make -C '~/repos/code/c/projects/types/sort'
make -C '~/repos/code/c/projects/types/containers'
make -C '~/repos/code/c/projects/types/wldraw/' 'local'
make -C '~/repos/code/c/projects/types/rational' 'local'
make -C '~/repos/code/c/projects/types/stringUtils' 'local'
make -C '~/repos/code/c/projects/types/sort' 'local'
make -C '~/repos/code/c/projects/types/containers' 'local'
