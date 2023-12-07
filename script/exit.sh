#!/bin/bash

# Define function to display menu options
show_menu() {
  echo "Sleep"
  echo "Hibernate"
  echo "Shutdown"
  echo "Reboot"
}

# Display menu options using dmenu and store user choice
choice=$(show_menu | dmenu -i -p "I will miss you 😞:")

# Handle user choice
case $choice in
  Sleep)
    doas zzz
    ;;
  Hibernate)
    doas ZZZ
    ;;
  Shutdown)
    doas shutdown -h now
    ;;
  Reboot)
    doas reboot
    ;;
  *)
    echo "Invalid choice. Please try again."
    ;;
esac
