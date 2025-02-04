#!/usr/bin/fish

function graphics -d "Install nvidia and intel drivers"
	sudo pacman -S mesa vulkan-intel
end

function wayland -d "Install wayland, dwl and a display manager"
	sudo pacman -S wayland xorg-xwayland git make bear polkit pkg-config wlroots \
	wayland-protocols bemenu-wayland waybar ly wl-clipboard wf-recorder slurp \
	grim swappy fnott swaybg wl-mirror bemenu-wayland
	git clone https://codeberg.org/dwl/dwl.git ~/repos
	ln -s ~/repos/dotfiles/dwl/config.h ~/repos/dwl
	#nvim /etc/ly/config.ini
	sudo systemctl enable ly
end

function fonts -d "Install nerd fonts"
	sudo pacman -S ttf-{anonymouspro,firacode,hack}-nerd ttf-nerd-fonts-symbols{,-mono}
end

function vim -d "Install vim and neovim"
	sudo pacman -S neovim nodejs python-pynvim fd ripgrep wl-clipboard clang {lua,typescript}-language-server pyright cmake
	ln -s ~/repos/dotfiles/nvim/ -t ~/.config -v

	sudo pacman -S vim
	ln -s ~/repos/dotfiles/vim/vimrc ~/.config/vim -v
end

function shell -d "Install kitty and setup fish"
	sudo pacman -S kitty
	rm ~/.config/fish/config.fish
	ln -s ~/repos/dotfiles/fish/config.fish ~/.config/fish
	ln -s ~/repos/dotfiles/fish/functions/ ~/.config/fish
	ln -s ~/repos/dotfiles/kitty/ ~/.config
end

function utils -d "Install Misc"
	sudo pacman -S qutebrowser gcc gdb valgrind file which ffmpeg \
	wget usbutils unzip unrar tree lshw os-prober efibootmgr ntfs-3g tmux
	mkdir ~/.config/tmux/{,plugins}
	git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
	ln -s ~/repos/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
end

function audio -d "Setup pipewire and audio dependencies"
	sudo pacman -S pipewire-{jack,alsa,pulse} sof-firmware 
	sudo systemctl --user --now enable wireplumber
end

function optional -d "Install optional programs"
	sudo pacman -S zathura zathura-pdf-poppler mpv vimiv mypaint
end

function routine
	graphics
	wayland
	fonts
	vim
	shell
	utils
	audio
	optional
end

routine
