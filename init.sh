#!/bin/sh

logmsg(){
	echo "init.sh:" $@ >> /tmp/myinit.log
}

# TODO: 'mktemp' is probably better than these two consecutive conditionals.
# 'export XDG_RUNTIME_DIR=$(sudo mktemp -d "/tmp/${UID}-runtime-dir.XXX")', but
# some applications might still expect XDG_RUNTIME_DIR to be /run/user/${UID}

# TODO: $XDG_RUNTIME_DIR should be deleted upon user logout according to the 
# xdg base directory specification (https://specifications.freedesktop.org/basedir-spec/latest/)
if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR="/run/user/${UID}"
else
	logmsg "XDG_RUNTIME_DIR is already set to ${XDG_RUNTIME_DIR}"
fi

if test ! -d "${XDG_RUNTIME_DIR}"; then
	sudo mkdir --parents ${XDG_RUNTIME_DIR}
	sudo chown carlos ${XDG_RUNTIME_DIR}
	sudo chmod 0700 ${XDG_RUNTIME_DIR}
else
	logmsg "'${XDG_RUNTIME_DIR}' already exists"
fi

if test "$1" = "dwl"; then
	startupcmd=~/repos/dwl/startup.sh
	if test -e ${startupcmd} && test -x ${startupcmd}; then
		startupcmd="-s ${startupcmd}"
	else
		startupcmd=""
	fi
	logmsg "startup command: ${startupcmd}"

	dwllogfile="dwl-$(date +%Y-%m-%d-%H-%M).log"
	if test -d ~/log; then
		dwllogfile=~/log/${dwllogfile}
	else
		dwllogfile=~/${dwllogfile}
	fi
	logmsg "log file: ${dwllogfile}"

	# 'dbus-launch'/'dbus-run-session' sets $DBUS_SESSION_BUS_ADDRESS,
	# which refers to a dbus session to be used by all processes
	# started from herein.
	#
	# The GentooWiki page for DBUS recommends 'dbus-launch
	# --exit-with-session' for this purpose.
	#
	# The manpage of dbus-launch recommends using 'dbus-run-session'
	# instead for sessions running within a text-mode session (such as
	# shells, agetty/elogind/TTY, greetd in text/terminal mode)
	#
	# 'https://wiki.gentoo.org/wiki/Greetd' recommends running
	# 'dbus-run-session' to run a compositor (such as Hyprland) from
	# within a greetd frontend
	#
	# https://dbus.freedesktop.org/doc/dbus-run-session.1.html
	#
	# https://dbus.freedesktop.org/doc/dbus-launch.1.html
	#
	# OBS: Beware that systems using systemd/elogind might not need to
	# use dbus-launch, because those usually set a dbus session
	# automatically on user-login through PAM. On the other hand, this
	# might be necessary in systems that use OpenRC, runit and other
	# initsystems (if they don't use elogind or another PAM-aware
	# mechanism, of course)
	#
	# '--exit-with-session' kills all processes and unsets all DBUS_*
	# environment variables that were created by dbus to launch this
	# program when the session/window manager instance terminates. This is
	# sort of a 'cleanup' procedure.
	exec dbus-launch --exit-with-session dwl ${startupcmd} &> ${dwllogfile}
elif test "$1" = "sway"; then
	logmsg "exec dbus-launch --exit-with-session sway"
elif test "$1" = "labwc"; then
	logmsg "exec dbus-launch --exit-with-session labwc"
else
	logmsg "Unknown window manager!"
	echo "run: $0 dwl/sway/labwc"
fi
