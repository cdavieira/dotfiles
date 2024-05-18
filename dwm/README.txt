## Dependencies
* xorg-server
* xorg-xsetroot
* xorg-xauth
* xorg-xinit
* xorg-xrandr
* xorg-server-xephyr
* xorg-xclipboard
> `Xephyr :5 & sleep 1 ; DISPLAY=:5 dwm`
* dmenu
* feh
> `feh --bg-scale ~/dotfiles/dwl/background.png`

any dependency can be found by running `pacman -Si <dependency name>`


## Modifications done to config.def.h
* change modkey to windowskey
* change default terminal to kitty


## Other modifications
```sh
# ~/.xinitrc

#!/usr/bin/sh

while xsetroot -name "date: `date` | uptime: `uptime | sed 's/.*,//'` | battery: `cat /sys/class/power_supply/BAT0/capacity` | memory: `free -h | awk '(NR==2){ print $3 }'`/`free -h | awk '(NR==2){ print $2 }'` | enp3s0: `cat /sys/class/net/enp3s0/operstate`, wlan0: `cat /sys/class/net/wlan0/operstate`"
do
	sleep 60
done &

exec dwm
```


## References
* [xorg - ArchWiki](https://wiki.archlinux.org/title/Xorg)
* [startx manpage - ArchManpages](https://man.archlinux.org/man/startx.1.en)
* [dwm status bar - dwm](https://dwm.suckless.org/status_monitor/)
* [Picom - ArchWiki](https://wiki.archlinux.org/title/Picom)
* [feh - ArchWiki](https://wiki.archlinux.org/title/feh)
* [feh - Github](https://github.com/derf/feh)
