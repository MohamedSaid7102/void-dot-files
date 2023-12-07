#!/bin/bash

# Define mount point
mnt="/mnt/flashdrive"

# Check if mount point exists
if [[ ! -d "$mnt" ]]; then
  echo "Mount point $mnt does not exist"
  exit 1
fi

# Get list of mounted devices and their mount points
devices=$(lsblk -rno NAME,MOUNTPOINT | awk '$2 != "" {print $1, $2}')

# Check if any devices are mounted to the mount point
if [[ -z "$devices" ]]; then
  echo "No devices are currently mounted to $mnt"
  exit 1
fi

# Use dmenu to select a device to unmount
device=$(echo "$devices" | dmenu -i -p "Select a device to unmount:" | awk '{print $1}')

if [[ -z "$device" ]]; then
  echo "No device selected"
  exit 1
fi

# Unmount the selected device
x-terminal-emulator -e sudo umount -l "/dev/$device"

# Check if unmount was successful
if [[ $? -eq 0 ]]; then
  echo "Device /dev/$device unmounted successfully"
else
  echo "Failed to unmount device /dev/$device"
fi
