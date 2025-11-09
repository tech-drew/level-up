#!/bin/bash

# Source the logging script
source /usr/local/bin/logging.sh

# Initialize logging for this script
initialize_logging "$0"  # "$0" gives the script name

# Set environment variables for Waybar (using info level for logging)
export WAYBAR_LOG_LEVEL=info

# Log the start of Waybar
log_message "Launching Waybar with logging..." "INFO"

# Start Waybar and redirect output to the log file
waybar &>> "$LOG_FILE" &
WAYBAR_PID=$!

# Log the PID of Waybar
log_message "Waybar started with PID: $WAYBAR_PID" "INFO"

# Wait for Waybar to finish
wait $WAYBAR_PID

# Log that Waybar has exited
log_message "Waybar has exited." "INFO"
