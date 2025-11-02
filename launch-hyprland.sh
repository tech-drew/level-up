#!/bin/bash

# Set log directory
LOG_DIR="$HOME/.local/share/level-up"
mkdir -p "$LOG_DIR"

# Set environment variables for Wayland
export XDG_SESSION_TYPE=wayland
export WAYLAND_DISPLAY=wayland-1
export LANG=en_US.UTF-8

# Log Hyprland startup
HYPRLAND_LOG="$LOG_DIR/hyprland.log"
echo "Launching Hyprland..." > "$HYPRLAND_LOG"

# Start Hyprland and log output
hyprland >> "$HYPRLAND_LOG" 2>&1
