#!/bin/bash

# Power menu for Waybar on Hyprland using wofi

chosen=$( | wofi --dmenu --width 250 --height 300 --prompt "Power Menu")

case "$chosen" in

    "Lock")
        if command -v hyprlock >/dev/null 2>&1; then
            hyprlock
        else
            notify-send "Power Menu" "hyprlock not found"
        fi
        ;;

    "Logout")
        if command -v hyprctl >/dev/null 2>&1; then
            hyprctl dispatch exit
        else
            notify-send "Power Menu" "Logout not supported on this WM"
        fi
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

