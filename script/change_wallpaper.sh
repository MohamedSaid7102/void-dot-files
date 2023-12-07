#!/bin/bash


if ! pgrep -f "notification-daemon" >/dev/null ; then
   /usr/lib/notification-daemon/notification-daemon &
fi


if [ -z "$1" ]; then
    notify-send 'Usage: ~/change_wallpaper.sh <number>'
    exit 1
fi

if ! [[ "$1" =~ ^[0-9]$ ]]; then
    notify-send 'Invalid number'
    exit 1
fi

filepath=~/wallpapers/"$1.jpg"

if [ ! -f "$filepath" ]; then
    notify-send "File not found: $filepath"
    exit 1
fi

xwallpaper --zoom "$filepath" > /dev/null 2>&1
