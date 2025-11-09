#!/bin/bash

# Function to initialize log directory and file
initialize_logging() {
    # Create the log directory and set the log file path based on the script name
    LOG_DIR="$HOME/.local/share/level-up/logs/$(basename "$1" .sh)"  # $1 removes the .sh from the dir name
    mkdir -p "$LOG_DIR"
    LOG_FILE="$LOG_DIR/$(basename "$1" .sh)-session-$(date --utc +"%Y-%m-%d_%H-%M-%S").log"
}

# Function to log messages with different log levels
log_message() {
    # Ensure LOG_FILE is set before proceeding
    if [[ -z "${LOG_FILE:-}" ]]; then
        echo "ERROR: LOG_FILE not set. Please call initialize_logging first." >&2
        exit 1
    fi

    local message=$1
    local log_level=${2:-INFO}  # Default to INFO if no log level provided
    local timestamp=$(date --utc +"%Y-%m-%dT%H:%M:%S.%3NZ")
    local component="script"
    echo "[$timestamp] [$log_level] [$component] $message" >> "$LOG_FILE"
}

# Function to redirect stdout to the log with INFO level
log_stdout() {
    while IFS= read -r line; do
        log_message "$line" "INFO"
    done
}

# Function to redirect stderr to the log with ERROR level
log_stderr() {
    while IFS= read -r line; do
        log_message "$line" "ERROR"
    done
}

# Function to capture stdout and stderr and redirect them to the appropriate log level
capture_output() {
    # Ensure that LOG_FILE is set before capturing output
    if [[ -z "${LOG_FILE:-}" ]]; then
        echo "ERROR: LOG_FILE not set. Please call initialize_logging first." >&2
        exit 1
    fi

    # Redirect stdout (file descriptor 1) to log_stdout (INFO level)
    exec 1> >(log_stdout)
    
    # Redirect stderr (file descriptor 2) to log_stderr (ERROR level)
    exec 2> >(log_stderr)
}
