#!/bin/sh

logfile='/tmp/guigreet.log'

logmsg(){
	echo "guigreet.sh:" $@ >> "${logfile}"
}

if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=$(mktemp -d "/tmp/${UID}-runtime-dir.XXX")
fi

logmsg "XDG_RUNTIME_DIR set to ${XDG_RUNTIME_DIR}"

# exec dbus-launch --exit-with-session dwl -s /etc/greetd/dwl.sh
dbus-launch --exit-with-session dwl -s /etc/greetd/dwl.sh &> "${logfile}"
