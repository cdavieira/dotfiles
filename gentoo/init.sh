#!/bin/sh

if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR="/run/user/${UID}"
else
	echo "XDG_RUNTIME_DIR is already set to ${XDG_RUNTIME_DIR}"
fi

if test ! -d "${XDG_RUNTIME_DIR}"; then
	sudo mkdir --parents ${XDG_RUNTIME_DIR}
	sudo chown carlos ${XDG_RUNTIME_DIR}
	#sudo chmod 0700 ${XDG_RUNTIME_DIR}
else
	echo "'${XDG_RUNTIME_DIR}' already exists"
fi

if test "$1" = "sway"; then
	echo "dbus-launch sway"
elif test "$1" = "dwl"; then
	#dbus-launch dwl -s ~/repos/dwl/startup.sh <&-
	dbus-launch dwl -s ~/repos/dwl/startup.sh
else
	echo "Unknown window manager!"
	echo "run: $0 sway/dwl"
fi
