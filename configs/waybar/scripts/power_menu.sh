#!/bin/bash

# Power menu for Waybar on Hyprland using wofi

chosen=$(printf "Lock\nLogout\nReboot\nShutdown" | wofi --dmenu --width 250 --height 300 --prompt "Power Menu")

case "$chosen" in

    "Lock")
        if command -v loginctl >/dev/null 2>&1; then
            loginctl lock-session
        else
            notify-send "Power Menu" "Lock not supported"
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

