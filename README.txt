dwl needs to be configured to work with applications that add more wayland
features:
* waybar needs a custom config
* screenshot needs to be properly setup (this includes creating a shortcut
  which actually works under dwl)
* when dwl gets installed, it installs the default dwl.desktop file which
  does not include a startup command to my shell script. Maybe write a hook to
install the right one
* maybe write a sed script file to regenerate my config.h from the default one

dwl and weston might not work if ly is restarted from another tty by running
systemctl restart ly (even with sudo) (perhaps eaccess/authorization/polkit
problems)

criar dotfiles do dwm
