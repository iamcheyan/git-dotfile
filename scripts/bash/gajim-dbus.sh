#!/bin/bash
# @Name: gajim-dbus.sh

if [ $# -gt 2 -o $# -eq 0 ]; then
  echo "give me your status and an optinal message"
  exit 1
fi

status=$1
text=$2
service=org.gajim.dbus
path=org/gajim/dbus/RemoteObject

dbus-send --print-reply --dest=$service /$path org.gajim.dbus.RemoteInterface.change_status string:"$status" string:"$text" string:"" 1>/dev/null
