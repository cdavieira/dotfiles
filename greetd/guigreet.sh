#!/bin/sh

if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=$(mktemp -d "/tmp/${UID}-runtime-dir.XXX")
fi

echo "guigreet.sh: XDG_RUNTIME_DIR set to ${XDG_RUNTIME_DIR}"
# exec dbus-launch --exit-with-session dwl -s /etc/greetd/dwl.sh
dbus-launch --exit-with-session dwl -s /etc/greetd/dwl.sh
