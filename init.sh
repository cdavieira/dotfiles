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
# convenient, specially if this script gets used by a display manager to start
# the graphical session of another user
create_xdgruntimedir_mkdir(){
	export XDG_RUNTIME_DIR="/run/user/${UID}"

	if test -d "${XDG_RUNTIME_DIR}"; then
		logmsg "'${XDG_RUNTIME_DIR}' already exists"
		return
	fi

	sudo mkdir --parents ${XDG_RUNTIME_DIR}
	sudo chown ${USER} ${XDG_RUNTIME_DIR}
	sudo chmod 0700 ${XDG_RUNTIME_DIR}
}

# More on $XDG_RUNTIME_DIR: https://specifications.freedesktop.org/basedir-spec/latest/
create_xdgruntimedir(){
	if test -z "${XDG_RUNTIME_DIR}"; then
		create_xdgruntimedir_mktemp
	else
		logmsg "XDG_RUNTIME_DIR is already set to ${XDG_RUNTIME_DIR}"
	fi
}

run_dwl(){
	dwlcmd=""

	for dwlscript in "$HOME/repos/dwl/startup.sh"; do
		if test -e "${dwlscript}" && test -x "${dwlscript}"; then
			dwlcmd="-s ${dwlscript}"
			break
		fi
	done

	logmsg "dwl command: ${dwlcmd}"

	run_wl_compositor dwl ${dwlcmd}
}

run_wl_compositor(){
	logfile="wl-$(date +%Y-%m-%d-%H-%M).log"

	for logdir in "$HOME/log" "$HOME/tmp" "$HOME" '/tmp' '.'; do
		if test -d "${logdir}" && test -w "${logdir}"; then
			logfile="${logdir}/${logfile}"
			break
		fi
	done

	logmsg "log file: ${logfile}"

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
	exec dbus-launch --exit-with-session $@ >${logfile} 2>&1
}






###############################################################################
###############################################################################
###############################################################################

create_xdgruntimedir

logmsg "XDG_RUNTIME_DIR set to ${XDG_RUNTIME_DIR}"

case "$1" in
	'dwl')
		run_dwl
	;;
	'labwc'|'sway'|'cwcwm')
		run_wl_compositor "$1"
	;;
	*)
		logmsg "Unknown window manager!"
		echo "run: $0 dwl/sway/labwc/cwcwm"
	;;
esac
