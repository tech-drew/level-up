#!/bin/bash
set -euo pipefail

# Define the home directory dynamically
HOME_DIR=$(eval echo "~$USER")

# Ensure LOG_DIR is set before use
LOG_DIR="$HOME_DIR/.local/share/level-up"
mkdir -p "$LOG_DIR"

# --- Dry-run support ---
DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "==> Dry-run mode enabled. No processes will be launched."
    # Redirect all output to dry-run log + terminal
    exec > >(tee -a "$LOG_DIR/launch-hyprland-dryrun.log") 2>&1
else
    # Redirect all output to normal log + terminal
    exec > >(tee -a "$LOG_DIR/launch-hyprland.log") 2>&1
fi

# Log the start of the script
echo "Launching Level-Up session for user $USER..."
echo "HOME_DIR: $HOME_DIR"
echo "LOG_DIR: $LOG_DIR"
echo "XDG_SESSION_TYPE: $XDG_SESSION_TYPE"
echo "WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
echo "LANG: $LANG"

# Set environment variables for Wayland
export XDG_SESSION_TYPE=wayland
export WAYLAND_DISPLAY=wayland-0
export LANG=en_US.UTF-8

# --- Waybar Logging ---
WAYBAR_LOG="$LOG_DIR/waybar.log"
if ! $DRY_RUN; then
    WAYBAR_LOG_LEVEL=debug WAYBAR_VERBOSE=1 waybar >"$WAYBAR_LOG" 2>&1 &
    WAYBAR_PID=$!
    echo "Waybar logging to: $WAYBAR_LOG"
    echo "Waybar PID: $WAYBAR_PID"
else
    echo "[DRY-RUN] Would launch Waybar with debug logging to $WAYBAR_LOG"
    WAYBAR_PID=0
fi

# --- Hyprland Logging ---
HYPRLAND_LOG="$LOG_DIR/hyprland.log"
if ! $DRY_RUN; then
    export HYPRLAND_LOG_LEVEL=debug
    hyprland >"$HYPRLAND_LOG" 2>&1 &
    HYPRLAND_PID=$!
    echo "Hyprland logging to: $HYPRLAND_LOG"
    echo "Hyprland PID: $HYPRLAND_PID"
else
    echo "[DRY-RUN] Would launch Hyprland with debug logging to $HYPRLAND_LOG"
fi

# Wait for Hyprland to finish (if not in dry-run mode)
if ! $DRY_RUN; then
    wait $HYPRLAND_PID
fi
