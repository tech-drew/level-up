#!/bin/bash

# Source the logging script
source /usr/local/bin/logging.sh

# Initialize logging for this script
initialize_logging "$0"  # "$0" gives the script name

# Set environment variables for Wayland
export XDG_SESSION_TYPE=wayland
export WAYLAND_DISPLAY=wayland-1
export LANG=en_US.UTF-8

# Log Hyprland startup
log_message "Launching Hyprland..." "INFO"

# Start Hyprland and log output
hyprland &>> "$LOG_FILE" &
HYPRLAND_PID=$!

# Log the PID of Hyprland
log_message "Hyprland started with PID: $HYPRLAND_PID" "INFO"

# Wait for Hyprland to finish
wait $HYPRLAND_PID

# Log that the script has finished
log_message "Hyprland has exited." "INFO"
