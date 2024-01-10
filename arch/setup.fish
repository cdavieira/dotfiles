#!/usr/bin/fish

sudo pacman -S mesa vulkan-intel {,xorg-x,bemenu-}wayland wlroots wayland-protocols git \
make bear waybar polkit ly ttf-{anonymouspro,firacode,hack}-nerd \
ttf-nerd-fonts-symbols{,-mono} kitty firefox neovim gcc gdb valgrind file which \
ffmpeg pkg-config zip wget usbutils unzip unrar tree lshw os-prober efibootmgr \
pipewire-{jack,alsa,pulse} sof-firmware nodejs python-pynvim fd ripgrep \
wl-clipboard clang {lua,typescript}-language-server pyright ntfs-3g

#nvim /etc/ly/config.ini
sudo systemctl enable ly
sudo systemctl --user --now enable wireplumber

git clone https://codeberg.org/dwl/dwl.git ~/apps/dwl
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

rm ~/.config/fish/config.fish
ln -s ~/dotfiles/fish/config.fish -t ~/.config/fish -v
ln -s ~/dotfiles/tmux/.tmux.conf -t ~ -v
ln -s ~/dotfiles/nvim/ -t ~/.config -v
ln -s ~/dotfiles/kitty/ -t ~/.config -v
ln -s ~/dotfiles/sway/ -t ~/.config -v
sudo ln -s /usr/share/wayland-sessions/sway.desktop -t /usr/local/share/wayland-sessions/ -v
