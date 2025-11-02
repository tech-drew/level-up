#!/bin/bash
set -euo pipefail

# Determine the home directory dynamically
HOME_DIR=$(eval echo "~$USER")

# Ensure LOG_DIR is set before use
LOG_DIR="$HOME_DIR/.local/share/level-up"
mkdir -p "$LOG_DIR"

# Log the start of the script
echo "Launching Hyprland session for user $USER..."
echo "HOME_DIR: $HOME_DIR"
echo "LOG_DIR: $LOG_DIR"

# Set default environment variables if they are not set already
export XDG_SESSION_TYPE="${XDG_SESSION_TYPE:-wayland}"
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-0}"
export LANG="${LANG:-en_US.UTF-8}"

# Log environment variables
echo "XDG_SESSION_TYPE: $XDG_SESSION_TYPE"
echo "WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
echo "LANG: $LANG"

# --- Hyprland Logging ---
HYPRLAND_LOG="$LOG_DIR/hyprland.log"
export HYPRLAND_LOG_LEVEL=debug
hyprland >"$HYPRLAND_LOG" 2>&1 &
HYPRLAND_PID=$!
echo "Hyprland logging to: $HYPRLAND_LOG"
echo "Hyprland PID: $HYPRLAND_PID"

# Wait for Hyprland to finish
wait $HYPRLAND_PID
