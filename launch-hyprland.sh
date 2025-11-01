#!/bin/bash
# launch-hyprland.sh - Launch Hyprland and Waybar (SDDM + dry-run)

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

# --- Set Wayland session environment ---
if ! $DRY_RUN; then
    export XDG_SESSION_TYPE=wayland
    export WAYLAND_DISPLAY=wayland-0
else
    echo "[DRY-RUN] Would set XDG_SESSION_TYPE=wayland and WAYLAND_DISPLAY=wayland-0"
fi

# --- Launch Waybar ---
if ! $DRY_RUN; then
    WAYBAR_LOG_LEVEL=debug WAYBAR_VERBOSE=1 waybar >"$WAYBAR_LOG" 2>&1 &
    WAYBAR_PID=$!
    echo "Waybar logging to: $WAYBAR_LOG"
else
    echo "[DRY-RUN] Would launch Waybar with debug logging, logs to $WAYBAR_LOG"
    WAYBAR_PID=0
fi

# --- Launch Hyprland ---
if ! $DRY_RUN; then
    exec HYPRLAND_LOG_LEVEL=debug hyprland >"$HYPRLAND_LOG" 2>&1
else
    echo "[DRY-RUN] Would launch Hyprland with debug logging, logs to $HYPRLAND_LOG"
fi
