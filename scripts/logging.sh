#!/bin/bash

# Function to initialize log directory and file
initialize_logging() {
    local script_path="$1"
    SCRIPT_NAME=$(basename "$script_path")  # e.g., install.sh or logging.sh

    # Create log directory based on script name (without .sh)
    LOG_DIR="$HOME/.local/share/level-up/logs/${SCRIPT_NAME%.sh}"
    mkdir -p "$LOG_DIR"

    # Create a new session log file
    LOG_FILE="$LOG_DIR/${SCRIPT_NAME%.sh}-session-$(date --utc +"%Y-%m-%d_%H-%M-%S").log"
}

# Function to log messages with timestamp, level, and script name
log_message() {
    if [[ -z "${LOG_FILE:-}" ]]; then
        echo "ERROR: LOG_FILE not set. Please call initialize_logging first." >&2
        exit 1
    fi

    local message=$1
    local log_level=${2:-INFO}
    local timestamp
    timestamp=$(date --utc +"%Y-%m-%dT%H:%M:%S.%3NZ")

    # Use the script name captured during initialization
    echo "[$timestamp] [$log_level] [$SCRIPT_NAME] $message" >> "$LOG_FILE"
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

# Function to capture stdout and stderr
capture_output() {
    if [[ -z "${LOG_FILE:-}" ]]; then
        echo "ERROR: LOG_FILE not set. Please call initialize_logging first." >&2
        exit 1
    fi

    exec 1> >(log_stdout)
    exec 2> >(log_stderr)
}
