#!/bin/bash

unset PINENTRY_USER_CACHE

# Function to check if a directory is already mounted
is_mounted() {
    mountpoint -q "$1"
}

# Function to mount a flash drive
mount_flashdrive() {
    device="/dev/$1"
    mount_point="/mnt/$1"
    echo "Mounting $device at $mount_point"
    sudo mkdir -p "$mount_point"
    sudo mount -t auto "$device" "$mount_point"
}

# Function to unmount a flash drive
unmount_flashdrive() {
    device="/dev/$1"
    mount_point="/mnt/$1"
    echo "Unmounting $device from $mount_point"
    sudo umount "$mount_point"
    sudo rmdir "$mount_point"
}

# Function to show a menu of available flash drives and mount or unmount them
flashdrive_menu() {
    choices=()
    while IFS= read -r line; do
        device=$(echo "$line" | awk '{print $1}' | sed 's|/dev/||')
        size=$(echo "$line" | awk '{print $4}')
        mount_point=$(echo "$line" | awk '{print $7}')
        if ! is_mounted "$mount_point"; then
            choices+=("$device $size on $mount_point")
        fi
    done < <(lsblk -p | grep -e 'part /media/' -e 'part $')
    
    if [ ${#choices[@]} -eq 0 ]; then
        notify-send "No Flash Drives" "No available flash drives found"
        exit 0
    fi

    choice=$(printf '%s\n' "${choices[@]}" | dmenu -i -l 10 -p "Flash Drive:")
    if [ -z "$choice" ]; then
        exit 0
    fi

    device=$(echo "$choice" | awk '{print $1}')
    size=$(echo "$choice" | awk '{print $2}')
    mount_point=$(echo "$choice" | awk '{print $4}')

    # Check if the chosen device is already mounted
    if is_mounted "$mount_point"; then
        # Device is already mounted, prompt to unmount
        echo "Unmount $device from $mount_point?"
        answer=$(echo -e "Yes\nNo" | dmenu -i -p "Unmount $device from $mount_point?")
        if [ "$answer" = "Yes" ]; then
            unmount_flashdrive "$device"
            notify-send "Flash Drive Unmounted" "$device ($size) has been unmounted from $mount_point"
        fi
    else
        # Device is not mounted, prompt to mount
        echo "Mount $device at $mount_point?"
        answer=$(echo -e "Yes\nNo" | dmenu -i -p "Mount $device at $mount_point?")
        if [ "$answer" = "Yes" ]; then
            mount_flashdrive "$device"
            notify-send "Flash Drive Mounted" "$device ($size) has been mounted at $mount_point"
            xdg-open "$mount_point"
        fi
    fi
}

# Prompt for password
PASSWORD=$(dmenu -p "Enter password:" -f <<< "")
if [ -z "$PASSWORD" ]; then
    exit 1
fi

# Run the flashdrive_menu function
flashdrive_menu
