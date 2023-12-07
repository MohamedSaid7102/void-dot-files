#!/bin/sh

# Set the emoji file path
EMOJI_FILE='/home/shelf/.config/emojis.txt'

# Use dmenu to search for an emoji by name
CHOSEN=$(cat "$EMOJI_FILE" | awk -F '\t' '{print $3, $2}' | dmenu -fn 'Hack:size=13' -l 10 -p "Search Emoji:" | awk '{print $1}')

# If an emoji is chosen, copy it to the clipboard
if [ -n "$CHOSEN" ]; then
    echo "$CHOSEN" | tr -d '\n' | xclip -selection clipboard
    notify-send "Copied $CHOSEN to clipboard!"
fi
