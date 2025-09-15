#!/bin/sh

logmsg(){
	echo "init.sh:" $@ >> /tmp/myinit.log
}

# The only problem with using 'mktemp' to set XDG_RUNTIME_DIR like this is that
# some applications might still expect XDG_RUNTIME_DIR to be /run/user/${UID}
create_xdgruntimedir_mktemp(){
	export XDG_RUNTIME_DIR=$(mktemp -d "/tmp/${UID}-runtime-dir.XXX")
}

# The following method requires 'sudo' and for that reason it's not really
# convenient, specially if this script get's used by a display manager to start
# the graphical session of another user
create_xdgruntimedir_mkdir(){
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
}

# More on $XDG_RUNTIME_DIR: https://specifications.freedesktop.org/basedir-spec/latest/
create_xdgruntimedir(){
	create_xdgruntimedir_mktemp
}

# $1: name of the wayland compositor executable
run_default_wl_compositor(){
	logmsg "exec dbus-launch --exit-with-session $1"
	# exec dbus-launch --exit-with-session $1
}

create_xdgruntimedir
logmsg "XDG_RUNTIME_DIR set to ${XDG_RUNTIME_DIR}"

case "$1" in
	'dwl')
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

		# 'dbus-launch'/'dbus-run-session' sets the $DBUS_SESSION_BUS_ADDRESS
		# variable, which refers to a dbus session (used by all processes
		# started from herein)
		#
		# '--exit-with-session' kills all processes and unsets all DBUS_*
		# environment variables that were created by dbus to launch this
		# program when the session/window manager instance terminates. This is
		# sort of a 'cleanup' procedure.
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
		exec dbus-launch --exit-with-session dwl ${startupcmd} &> ${dwllogfile}
	;;
	'labwc'|'sway'|'cwcwm')
		run_default_wl_compositor "$1"
	;;
	*)
		logmsg "Unknown window manager!"
		echo "run: $0 dwl/sway/labwc/cwcwm"
	;;
esac
