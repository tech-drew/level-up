#!/bin/bash

set -euo pipefail

# --- Setup logging ---
LOG_DIR="$HOME/.local/share/level-up/logs/install"
mkdir -p "$LOG_DIR"

LOG_DIR_DRY="$HOME/.local/share/level-up/logs/install-dry-run"
mkdir -p "$LOG_DIR_DRY"

# Dry-run or normal mode log file setup
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    LOG_FILE="$LOG_DIR_DRY/install-dry-run-session-$(date --utc +"%Y-%m-%d_%H-%M-%S").log"
    echo "==> Dry-run mode enabled. No changes will be made." | tee -a "$LOG_FILE"
else
    DRY_RUN=false
    LOG_FILE="$LOG_DIR/install-session-$(date --utc +"%Y-%m-%d_%H-%M-%S").log"
    echo "==> Running installation in normal mode." | tee -a "$LOG_FILE"
fi

# Redirect all output to log file and terminal
exec > >(tee -a "$LOG_FILE") 2>&1

# --- Basic Logging ---
log_message() {
    local message=$1
    local level=${2:-INFO}
    local timestamp=$(date --utc +"%Y-%m-%dT%H:%M:%S.%3NZ")
    local script_name=$(basename "$0")
    # Log to the log file
    echo "[$timestamp] [$level] [$script_name] $message" >> "$LOG_FILE"
}

log_message "Starting installation script (logging initialized)"

# --- Redirect stdout to INFO and stderr to ERROR ---
log_stdout() {
    local message=$1
    log_message "$message" "INFO"
}

log_stderr() {
    local message=$1
    log_message "$message" "ERROR"
}

# --- Function to handle errors ---
error_handler() {
    local exit_code="$?"
    local last_command="${BASH_COMMAND}"
    log_stderr "Error in command: '$last_command' with exit code: $exit_code"
    exit "$exit_code"
}

trap error_handler ERR

# --- Security disclaimer ---
log_message "==> SECURITY DISCLAIMER" "INFO"
echo "==> SECURITY DISCLAIMER"
echo "The Level-Up install script requires sudo permissions to install packages, configure system services, and modify system-wide configurations."
echo "By running this script, you acknowledge that you are responsible for any changes made to your system."
echo "Although this script does not modify user accounts or sensitive data, it will install software, adjust configurations, and modify system settings."
echo "It is recommended that you back up important data and configurations before proceeding."
echo "Some changes, such as enabling services or modifying system files, may require a logout or reboot to take effect."
read -r -p "Do you want to continue with these changes? (y/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    log_message "Installation aborted by user" "ERROR"
    echo "Exiting installation. No changes have been made."
    exit 1
fi

# --- Cache sudo credentials ---
log_message "Caching sudo credentials" "INFO"
if ! $DRY_RUN; then
    sudo -v
    # Keep-alive: update sudo timestamp until script finishes
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

# --- Script directory ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
log_message "Script directory: $SCRIPT_DIR" "INFO"

log_message "Starting Level-Up installation..." "INFO"

echo "1. Install required packages"
# --- 1. Install required packages ---
log_message "Installing required packages..." "INFO"
PACKAGES=(
    alacritty
    fastfetch
    gimp
    network-manager-applet
    pavucontrol
    waybar
    wofi
    wl-clipboard
    timeshift
    virt-manager
)

if ! $DRY_RUN; then
    sudo dnf clean all
    sudo dnf install -y "${PACKAGES[@]}"
else
    log_message "[DRY-RUN] Would install packages: ${PACKAGES[*]}" "INFO"
fi

# --- 2. Enable COPR and install extra packages ---
echo "2. Enable COPR and install extra packages"
log_message "Enabling solopasha/hyprland COPR repo..." "INFO"
if ! $DRY_RUN; then
    sudo dnf copr enable solopasha/hyprland -y || true
else
    log_message "[DRY-RUN] Would enable COPR repo: solopasha/hyprland" "INFO"
fi

COPR_PACKAGES=(
    hyprland
    hyprlock
    hyprland-qtutils
    swww
)

log_message "Installing COPR packages..." "INFO"
if ! $DRY_RUN; then
    sudo dnf install -y "${COPR_PACKAGES[@]}" --enablerepo=copr:copr.fedorainfracloud.org:solopasha:hyprland
else
    log_message "[DRY-RUN] Would install COPR packages: ${COPR_PACKAGES[*]}" "INFO"
fi

# --- 3. Create config directories ---
echo "3. Create config directories"
log_message "Creating config directories..." "INFO"
CONFIG_DIRS=(
    "$HOME/.config/alacritty"
    "$HOME/.config/fastfetch"
    "$HOME/.config/hypr"
    "$HOME/.config/waybar"
    "$HOME/.config/wofi"
    "$HOME/.config/timeshift"
    "$HOME/Pictures"
    "$HOME/level-up/scripts"  # Create scripts directory
)
for dir in "${CONFIG_DIRS[@]}"; do
    if ! $DRY_RUN; then
        mkdir -p "$dir"
    else
        log_message "[DRY-RUN] Would create directory: $dir" "INFO"
    fi
done

# --- 4. Copy config and script files ---
echo "4. Copy config and script files"
log_message "Copying configuration and script files..." "INFO"
CONFIG_MAP=(
    "alacritty"
    "fastfetch"
    "waybar"
    "wofi"
    "timeshift"
)
for cfg in "${CONFIG_MAP[@]}"; do
    SRC="$SCRIPT_DIR/configs/$cfg/"
    DEST="$HOME/.config/$cfg/"
    if ! $DRY_RUN; then
        cp -rv "$SRC"* "$DEST" || log_message "[!] No $cfg config files to copy" "ERROR"
    else
        log_message "[DRY-RUN] Would copy $cfg configs from $SRC to $DEST" "INFO"
    fi
done

# Copy scripts (including launch scripts)
log_message "Copying scripts..." "INFO"
SCRIPTS_DIR="$SCRIPT_DIR/scripts/"
if ! $DRY_RUN; then
    cp -rv "$SCRIPTS_DIR"* "$HOME/level-up/scripts/" || log_message "[!] No scripts to copy" "ERROR"
else
    log_message "[DRY-RUN] Would copy scripts from $SCRIPTS_DIR to $HOME/level-up/scripts/" "INFO"
fi

# --- 5. Copy Hyprland/Hyprlock configs and make Waybar, Hyprland launch script, and logging script system-accessible ---
echo "5. Copy Hyprland/Hyprlock configs and make Waybar, Hyprland launch script, and logging script system-accessible"
log_message "Copying Hyprland and Hyprlock configs..." "INFO"
HYPRLAND_CONF="$SCRIPT_DIR/configs/hypr/hyprland.conf"
HYPRLOCK_CONF="$SCRIPT_DIR/configs/hypr/hyprlock.conf"

# Define system-wide paths for the Waybar launch script
WAYBAR_SRC_PATH="$SCRIPT_DIR/scripts/launch-waybar-with-logging.sh"
WAYBAR_DEST_PATH="/usr/local/bin/launch-waybar-with-logging.sh" # System-wide location

# Define system-wide paths for the Hyprland launch script
HYPRLAND_LAUNCH_SRC_PATH="$SCRIPT_DIR/scripts/launch-hyprland-with-logging.sh"
HYPRLAND_LAUNCH_DEST_PATH="/usr/local/bin/launch-hyprland-with-logging.sh" # System-wide location

# Define path for the logging script
LOGGING_SCRIPT_SRC_PATH="$SCRIPT_DIR/scripts/logging.sh"
LOGGING_SCRIPT_DEST_PATH="/usr/local/bin/logging.sh" # System-wide location

if [[ -f "$HYPRLAND_CONF" ]]; then
    if ! $DRY_RUN; then
        cp -v "$HYPRLAND_CONF" "$HOME/.config/hypr/hyprland.conf"
        log_message "hyprland.conf copied to $HOME/.config/hypr/" "INFO"

        # --- BLOCK: Copy Waybar launch script to system-wide location and make executable ---
        if [[ -f "$WAYBAR_SRC_PATH" ]]; then
            sudo cp "$WAYBAR_SRC_PATH" "$WAYBAR_DEST_PATH"
            sudo chown root:root "$WAYBAR_DEST_PATH"  # Ensure root ownership
            sudo chmod 755 "$WAYBAR_DEST_PATH"        # Set permissions: rwx for root, r-x for others
            log_message "Waybar launch script copied and made executable: $WAYBAR_DEST_PATH" "INFO"
        else
            log_message "[!] launch-waybar-with-logging.sh not found. Cannot set up automatic launch." "ERROR"
        fi
        # ---------------------------------------------------------------------------------------

        # --- BLOCK: Copy Hyprland launch script to system-wide location and make executable ---
        if [[ -f "$HYPRLAND_LAUNCH_SRC_PATH" ]]; then
            sudo cp "$HYPRLAND_LAUNCH_SRC_PATH" "$HYPRLAND_LAUNCH_DEST_PATH"
            sudo chown root:root "$HYPRLAND_LAUNCH_DEST_PATH"  # Ensure root ownership
            sudo chmod 755 "$HYPRLAND_LAUNCH_DEST_PATH"        # Set permissions: rwx for root, r-x for others
            log_message "Hyprland launch script copied and made executable: $HYPRLAND_LAUNCH_DEST_PATH" "INFO"
        else
            log_message "[!] launch-hyprland-with-logging.sh not found. Cannot set up automatic launch." "ERROR"
        fi
        # ---------------------------------------------------------------------------------------

        # --- BLOCK: Copy logging script to system-wide location and make executable ---
        if [[ -f "$LOGGING_SCRIPT_SRC_PATH" ]]; then
            sudo cp "$LOGGING_SCRIPT_SRC_PATH" "$LOGGING_SCRIPT_DEST_PATH"
            sudo chown root:root "$LOGGING_SCRIPT_DEST_PATH"  # Ensure root ownership
            sudo chmod 755 "$LOGGING_SCRIPT_DEST_PATH"        # Set permissions: rwx for root, r-x for others
            log_message "logging.sh script copied and made executable: $LOGGING_SCRIPT_DEST_PATH" "INFO"
        else
            log_message "[!] logging.sh script not found. Skipping." "ERROR"
        fi
        # ---------------------------------------------------------------------------------------

        # --- Append the exec-once line to hyprland.conf (pointing to the new system path) ---
        # --- hyprland.conf can't use $PATH variables. This adds and the explicit user path to the hyprland.conf ---
        sed -i "25i exec-once = $WAYBAR_DEST_PATH" "$HOME/.config/hypr/hyprland.conf"
        log_message "Added exec-once line to hyprland.conf, pointing to $WAYBAR_DEST_PATH" "INFO"
    else
        log_message "[DRY-RUN] Would copy hyprland.conf to $HOME/.config/hypr/" "INFO"
        log_message "[DRY-RUN] Would copy and chmod +x Waybar launch script to $WAYBAR_DEST_PATH" "INFO"
        log_message "[DRY-RUN] Would copy and chmod +x Hyprland launch script to $HYPRLAND_LAUNCH_DEST_PATH" "INFO"
        log_message "[DRY-RUN] Would copy and chmod +x logging.sh to $LOGGING_SCRIPT_DEST_PATH" "INFO"
    fi
else
    log_message "[!] hyprland.conf not found. Skipping." "ERROR"
fi

if [[ -f "$HYPRLOCK_CONF" ]]; then
    if ! $DRY_RUN; then
        cp -v "$HYPRLOCK_CONF" "$HOME/.config/hypr/hyprlock.conf"
    else
        log_message "[DRY-RUN] Would copy hyprlock.conf to $HOME/.config/hypr/" "INFO"
    fi
else
    log_message "[!] hyprlock.conf not found. Skipping." "ERROR"
fi


# --- 6. Copy wallpaper ---
echo "6. Copy wallpaper"
log_message "Copying wallpaper..." "INFO"
WALLPAPER="$SCRIPT_DIR/wallpapers/end_4HyprlandWallpaper.png"
if [[ -f "$WALLPAPER" ]]; then
    if ! $DRY_RUN; then
        cp -v "$WALLPAPER" "$HOME/Pictures/"
    else
        log_message "[DRY-RUN] Would copy wallpaper to $HOME/Pictures/" "INFO"
    fi
else
    log_message "[!] Wallpaper not found. Skipping." "ERROR"
fi

# --- 7. Generate Fastfetch config ---
echo "7. Generate Fastfetch config"
log_message "Generating Fastfetch config..." "INFO"
if command -v fastfetch &> /dev/null; then
    if ! $DRY_RUN; then
        fastfetch --gen-config || log_message "[!] Fastfetch failed to generate config." "ERROR"
    else
        log_message "[DRY-RUN] Would run 'fastfetch --gen-config'" "INFO"
    fi
else
    log_message "[!] Fastfetch not found. Skipping." "ERROR"
fi

# --- 8. Optional terminal prompt customization ---
echo "8. Optional terminal prompt customization"
read -r -p "Do you want to customize your terminal prompt with a green username? (y/n): " REPLY
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    log_message "Updating .bashrc with a custom green prompt..." "INFO"
    if ! $DRY_RUN; then
        touch "$HOME/.bashrc"
        if ! grep -q "Custom green prompt" "$HOME/.bashrc"; then
            {
                echo ""
                echo "# Custom green prompt"
                echo 'GREEN="\[\e[38;5;38m\]"'
                echo 'RESET="\[\e[0m\]"'
                echo 'PS1="${GREEN}\u@\h${RESET}:\w\$ "'
            } >> "$HOME/.bashrc"
            log_message "Custom prompt added." "INFO"
        else
            log_message "Custom prompt already exists." "INFO"
        fi
    else
        log_message "[DRY-RUN] Would add custom green prompt to .bashrc" "INFO"
    fi
else
    log_message "Skipping terminal prompt customization." "INFO"
fi

# --- 9. Set up libvirt for virt-manager ---
echo "9. Set up libvirt for virt-manager"
log_message "Setting up libvirt and virtualization support..." "INFO"
if ! $DRY_RUN; then
    sudo systemctl enable --now libvirtd || true
else
    log_message "[DRY-RUN] Would enable and start libvirtd service" "INFO"
fi

if id -nG "$USER" | grep -qw libvirt; then
    log_message "User already in libvirt group. Skipping." "INFO"
else
    if ! $DRY_RUN; then
        sudo usermod -aG libvirt "$USER"
    else
        log_message "[DRY-RUN] Would add user $USER to libvirt group" "INFO"
    fi
fi

# --- 10. Create a Level-Up session for SDDM ---
echo "10. Create a Level-Up session for SDDM"
log_message "Creating Level-Up session for SDDM/KDE..." "INFO"
WRAPPER_SRC_PATH="$SCRIPT_DIR/scripts/launch-hyprland-with-logging.sh"
WRAPPER_DEST_PATH="/usr/local/bin/launch-hyprland-with-logging.sh"
DESKTOP_ENTRY_FILE="/usr/share/wayland-sessions/level-up.desktop"

if ! $DRY_RUN; then
    if [[ ! -f "$WRAPPER_SRC_PATH" ]]; then
        log_message "[!] Wrapper script $WRAPPER_SRC_PATH not found. Cannot create login session." "ERROR"
    else
        sudo cp "$WRAPPER_SRC_PATH" "$WRAPPER_DEST_PATH"
        sudo chmod +x "$WRAPPER_DEST_PATH"
        log_message "Wrapper script copied and made executable: $WRAPPER_DEST_PATH" "INFO"

        sudo bash -c "cat > '$DESKTOP_ENTRY_FILE'" <<EOF
[Desktop Entry]
Name=Level-Up
Comment=Launch Level-Up Hyprland session with logging
Exec=env XDG_CURRENT_DESKTOP=Hyprland $WRAPPER_DEST_PATH  # Set it to Hyprland
TryExec=$WRAPPER_DEST_PATH
Type=Application
DesktopNames=Level-Up
EOF
        sudo chmod 644 "$DESKTOP_ENTRY_FILE"
        log_message "Desktop entry created at: $DESKTOP_ENTRY_FILE" "INFO"
    fi
else
    log_message "[DRY-RUN] Would copy wrapper to $WRAPPER_DEST_PATH and make executable" "INFO"
    log_message "[DRY-RUN] Would create system-wide desktop entry at $DESKTOP_ENTRY_FILE" "INFO"
fi

# --- 11. Install Level-Up Icon Theme ---
echo "11. Install Level-Up Icon Theme"
log_message "Installing level-up-icon-theme..." "INFO"
ICON_THEME_ARCHIVE="$SCRIPT_DIR/themes/level-up-icon-theme.tar.gz"
ICON_THEME_DEST="$HOME/.local/share/icons/level-up-icon-theme"

if [[ -f "$ICON_THEME_ARCHIVE" ]]; then
    if ! $DRY_RUN; then
        mkdir -p "$ICON_THEME_DEST"
        tar -xzf "$ICON_THEME_ARCHIVE" -C "$ICON_THEME_DEST"
        log_message "Icon theme extracted and installed to $ICON_THEME_DEST" "INFO"
    else
        log_message "[DRY-RUN] Would extract and install icon theme to $ICON_THEME_DEST" "INFO"
    fi
else
    log_message "[!] Icon theme archive not found at $ICON_THEME_ARCHIVE. Skipping." "ERROR"
fi

echo "    [!] Installation complete! You can log in to Level-Up from the login screen by selecting the 'Level-Up' session option."
echo "    [!] To use the Level-Up icons, it's recommended that you update the theme while logged into a Plasma session."
echo "    [!] You may need to log out and log back in for group membership changes to take effect."

log_message "Installation complete!" "INFO"
log_message "Welcome to Level-Up!" "INFO"
