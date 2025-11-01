#!/bin/bash
# launch-hyprland.sh- Launch Hyprland and Waybar with debug logging (supports --dry-run)

set -euo pipefail

# --- Dry-run support ---
DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "==> Dry-run mode enabled. No processes will be launched."
fi

# --- Directories ---
LOG_DIR="$HOME/.local/share/level-up"
HYPRLAND_LOG="$LOG_DIR/hyprland.log"
WAYBAR_LOG="$LOG_DIR/waybar.log"

if ! $DRY_RUN; then
    mkdir -p "$LOG_DIR"
else
    echo "[DRY-RUN] Would create log directory: $LOG_DIR"
fi

# --- Launch Waybar ---
echo "Launching Waybar with debug logging..."
if ! $DRY_RUN; then
    WAYBAR_LOG_LEVEL=debug WAYBAR_VERBOSE=1 waybar >"$WAYBAR_LOG" 2>&1 &
    WAYBAR_PID=$!
    echo "Waybar logging to: $WAYBAR_LOG"
else
    echo "[DRY-RUN] Would launch Waybar with debug logging, logs to $WAYBAR_LOG"
    WAYBAR_PID=0
fi

# --- Launch Hyprland ---
echo "Launching Hyprland with debug logging..."
if ! $DRY_RUN; then
    HYPRLAND_LOG_LEVEL=debug hyprland >"$HYPRLAND_LOG" 2>&1
    echo "Hyprland logging to: $HYPRLAND_LOG"
else
    echo "[DRY-RUN] Would launch Hyprland with debug logging, logs to $HYPRLAND_LOG"
fi

# --- Wait for Waybar if running ---
if ! $DRY_RUN && [[ $WAYBAR_PID -ne 0 ]]; then
    wait $WAYBAR_PID
fi
