compile and install

change dwl desktop stored in usr local share wayland-sessions with the one i
modified

customize waybar and create a certain dir/file in $HOME/.config to configure
it

wl-mirror -r (slurp) (slurp -o -f "%o")


```desktop
[Desktop Entry]
Name=dwl
Comment=dwm for Wayland
Exec=dwl -s ~/dotfiles/dwl/startup.fish
Type=Application
```
> dwl.desktop example


mkdir ~/.config/waybar
ln -s ~/dotfiles/dwl/waybar-config.jsonc ~/.config/waybar/config.jsonc
ln -s ~/dotfiles/dwl/waybar-style.css ~/.config/waybar/style.css
