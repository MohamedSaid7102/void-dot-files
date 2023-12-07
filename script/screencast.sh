
#!/bin/bash

# Define the recording directory and filename
recording_dir="$HOME/Videos"
date_stamp=$(date +%Y%m%d%H%M%S)
output_file="$recording_dir/screencast_$date_stamp.mp4"

# Use dmenu to prompt the user for recording options
options=("Record Full Screen" "Record Selected Area")
choice=$(echo -e "${options[@]}" | dmenu -i -p "Select Recording Mode:")

case "$choice" in
    "Record Full Screen")
        # Record the full screen
        ffmpeg -f x11grab -s "$(xrandr | awk '/\*/ {print $1; exit}' | sed 's/x/\ /')" -i :0.0 -preset ultrafast "$output_file"
        ;;
    "Record Selected Area")
        # Record a selected area using slop
        slop=$(slop -f "%x %y %w %h %g %i" -b 2 -c 0.8,0.2,0.2,0.7 -t 0)
        if [ $? -eq 0 ]; then
            read -r X Y W H G I <<< $slop
            ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+"$X","$Y" -preset ultrafast "$output_file"
        fi
        ;;
esac

# Notify the user that the recording has finished
notify-send "Screen Recording" "Recording saved as:\n$output_file"

exit 0
