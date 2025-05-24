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
	echo "exec dbus-launch --exit-with-session sway"
elif test "$1" = "labwc"; then
	echo "exec dbus-launch --exit-with-session labwc"
elif test "$1" = "dwl"; then
	# 'dbus-launch'/'dbus-run-session' sets $DBUS_SESSION_BUS_ADDRESS,
	# which references a dbus session to be used by all processes
	# started from herein.
	#
	# The GentooWiki page for DBUS recommends 'dbus-launch
	# --exit-with-session' for this purpose.
	#
	# The manpage of dbus-launch recommends using 'dbus-run-session'
	# instead for sessions within a text-mode session (such as shells,
	# agetty/elogind/TTY, greetd in text/terminal mode)
	#
	# Since the dwl session is a graphical one, i suppose we should use
	# dbus-launch.
	#
	# OBS: Beware that systems using systemd/elogind might not need the use
	# of dbus-launch, because those usually set a dbus session
	# automatically on user-login through PAM. On the other hand, this
	# might be necessary in systems that use OpenRC, runit and other
	# initsystems (if they don't use elogind or another PAM-aware
	# mechanism, of course)
	#
	# '--exit-with-session' kills all processes and unsets all DBUS_*
	# environment variables that were created by dbus to launch this
	# program when the session/window manager instance terminates. This is
	# sort of a 'cleanup' procedure.
	exec dbus-launch --exit-with-session dwl -s ~/repos/dwl/startup.sh &> ~/log/dwl-$(date +%Y-%m-%d-%H-%M).log
else
	echo "Unknown window manager!"
	echo "run: $0 sway/dwl/labwc"
fi
