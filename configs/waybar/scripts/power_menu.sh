#!/bin/bash

# Define the power options in the desired alphabetical order
options="Lock\nLog Out\nReboot\nShutdown"

# Get the x and y coordinates from the Waybar click event
x_pos=$1
y_pos=$2

# Use wofi to present the options, anchored by the click coordinates
# We are no longer using the 'sort' command since it is not working as expected
chosen=$(echo -e "$options" | wofi --dmenu --x "$x_pos" --y "$y_pos" --width 250 --height 210 --prompt "Power Menu")

# Act based on the user's choice
case "$chosen" in
    "Lock")
        hyprlock
        ;;
    "Log Out")
        # For Hyprland, a common way to log out is to exit the session
        hyprctl dispatch exit
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac
