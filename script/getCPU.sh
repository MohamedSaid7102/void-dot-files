#!/bin/sh

case $BLOCK_BUTTON in
	1) notify-send "🖥 CPU hogs" "$(ps axch -o cmd:15,%cpu --sort=-%cpu | head)\\n(100% per core)" ;;
	2) setsid -f "$TERMINAL" -e htop ;;
	3) notify-send "🖥 CPU module " "\- Shows CPU temperature.
- Click to show intensive processes.
- Middle click to open htop." ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

sensors | awk '/Core 0/ {print "🌡 " $3}'
