#!/bin/sh

if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR="/run/user/${UID}"
else
	echo "XDG_RUNTIME_DIR is already set to ${XDG_RUNTIME_DIR}"
fi

if test ! -d "${XDG_RUNTIME_DIR}"; then
	sudo mkdir --parents ${XDG_RUNTIME_DIR}
	sudo chown carlos ${XDG_RUNTIME_DIR}
	sudo chmod 0700 ${XDG_RUNTIME_DIR}
else
	echo "'${XDG_RUNTIME_DIR}' already exists"
fi

if test "$1" = "sway"; then
	echo "dbus-launch sway"
elif test "$1" = "dwl"; then
	#dbus-launch dwl -s ~/repos/dwl/startup.sh <&-

	# '--exit-with-session' kills all processes and unsets all environment
	# variables that were created by dbus to launch this program when the
	# session/window manager instance terminates. This is sort of a
	# 'cleanup' procedure. If '--exit-with-session' isn't used, then this
	# script would have to check for DBUS_* enviroment variables before
	# commiting to launch the program with 'dbus-launch'.
	# WARNING: this option isn't recommended to be used like this. Read
	# 'man dbus-launch' for more info on that.
	dbus-launch --exit-with-session dwl -s ~/repos/dwl/startup.sh &> ~/log/init0.log
else
	echo "Unknown window manager!"
	echo "run: $0 sway/dwl"
fi
