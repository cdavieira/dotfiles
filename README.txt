weston is currently not working with weston.ini
follow the procedures to debug whats going on:
1. open dwl
2. comment all sections in weston.ini
3. run weston inside dwl and redirect the standart output/stderr to a file
4. uncomment all sections in weston.ini
5. run weston inside dwl and redirect the standart output/stderr to a second file
6. run a diff to see whats different in the first and second files
7. take notes on whats different and try to modify weston.ini so that it works
just like the default
8. reboot the system and try to start weston
9. repeat if everything fails

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
