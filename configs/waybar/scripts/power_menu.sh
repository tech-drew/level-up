#!/bin/bash

# Show menu using wofi. This makes a basic power button to use on the waybar.
chosen=$(printf "🔒 Lock\n↩ Logout\n🔁 Reboot\n⏻ Shutdown" | wofi --dmenu --width 250 --height 300 --prompt "Power Menu")

case "$chosen" in
    "🔒 Lock")
        if command -v gdmflexiserver >/dev/null 2>&1; then
            gdmflexiserver --lock
        elif command -v loginctl >/dev/null 2>&1; then
            loginctl lock-session
        else
            notify-send "Power Menu" "No lock command found"
        fi
        ;;
    "↩ Logout")
        if command -v gdmflexiserver >/dev/null 2>&1; then
            gdmflexiserver
        elif command -v hyprctl >/dev/null 2>&1; then
            hyprctl dispatch exit
        else
            notify-send "Power Menu" "No logout command found"
        fi
        ;;
    "🔁 Reboot")
        systemctl reboot
        ;;
    "⏻ Shutdown")
        systemctl poweroff
        ;;
    *)
        # User exited or clicked outside the menu
        exit 0
        ;;
esac
