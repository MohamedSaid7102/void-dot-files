#!/bin/bash

# Define the directory where screenshots will be saved
save_dir="$HOME/Pictures"

# Find the next available filename
next_filename=$(ls "$save_dir"/screen*.png 2>/dev/null | wc -l)
screenshot_filename="$save_dir/screen$next_filename.png"

# Take the screenshot using maim and save it with the next filename
maim -s "$screenshot_filename"

# Notify the user about the saved screenshot
notify-send "Screenshot Saved" "Screenshot saved as $screenshot_filename"
