#!/bin/bash

# Set the log directory (make sure the parent directory exists)
LOG_DIR="$HOME/.local/share/level-up"
mkdir -p "$LOG_DIR"

# Set the log file path for waybar
WAYBAR_LOG="$LOG_DIR/waybar.log"

# Log the start of Waybar
echo "Launching Waybar with logging..." > "$WAYBAR_LOG"

# Set debug logging and start Waybar, redirecting output to log file
WAYBAR_LOG_LEVEL=debug waybar >> "$WAYBAR_LOG" 2>&1 &
WAYBAR_PID=$!

# Log the PID
echo "Waybar started with PID: $WAYBAR_PID" >> "$WAYBAR_LOG"

# Wait for Waybar to finish
wait $WAYBAR_PID
