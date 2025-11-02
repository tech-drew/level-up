#!/bin/bash

set -euo pipefail

# --- Setup logging ---
LOG_DIR="$HOME/.local/share/level-up"
mkdir -p "$LOG_DIR"

# Log files
LOG_FILE="$LOG_DIR/level-up-install.log"
DRY_RUN_LOG_FILE="$LOG_DIR/level-up-install-dryrun.log"

# --- Dry-run support ---
DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "==> Dry-run mode enabled. No changes will be made."
    # Redirect all output to dry-run log + terminal
    exec > >(tee -a "$DRY_RUN_LOG_FILE") 2>&1
else
    # Redirect all output to normal log + terminal
    exec > >(tee -a "$LOG_FILE") 2>&1
fi

# --- Security disclaimer ---
echo "==> SECURITY DISCLAIMER"
echo "This script requires sudo permissions to install packages, configure system services, and modify system-wide configurations."
echo "By running this script, you acknowledge that you are responsible for any changes made to your system."
echo "Although this script does not modify user accounts or sensitive data, it will install software, adjust configurations, and modify system settings."
echo "It is recommended that you back up important data and configurations before proceeding."
echo "Some changes, such as enabling services or modifying system files, may require a logout or reboot to take effect."
read -r -p "Do you want to continue with these changes? (y/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Exiting installation. No changes have been made."
    exit 1
fi

# --- Cache sudo credentials ---
if ! $DRY_RUN; then
    sudo -v
    # Keep-alive: update sudo timestamp until script finishes
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

# --- Script directory ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Script directory: $SCRIPT_DIR"

echo "==> Starting Fedora Level-Up Hyprland installation..."

# --- 1. Install required packages ---
echo "--> Installing required packages..."
PACKAGES=(
    alacritty
    fastfetch
    gimp
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
    echo "[DRY-RUN] Would install packages: ${PACKAGES[*]}"
fi

# --- 2. Enable COPR and install extra packages ---
echo "--> Enabling solopasha/hyprland COPR repo..."
if ! $DRY_RUN; then
    sudo dnf copr enable solopasha/hyprland -y || true
else
    echo "[DRY-RUN] Would enable COPR repo: solopasha/hyprland"
fi

COPR_PACKAGES=(
    hyprland
    hyprlock
    hyprland-qtutils
    swww
)

echo "--> Installing COPR packages..."
if ! $DRY_RUN; then
    sudo dnf install -y "${COPR_PACKAGES[@]}" --enablerepo=copr:copr.fedorainfracloud.org:solopasha:hyprland
else
    echo "[DRY-RUN] Would install COPR packages: ${COPR_PACKAGES[*]}"
fi

# --- 3. Create config directories ---
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
echo "--> Creating config directories..."
for dir in "${CONFIG_DIRS[@]}"; do
    if ! $DRY_RUN; then
        mkdir -p "$dir"
    else
        echo "[DRY-RUN] Would create directory: $dir"
    fi
done

# --- 4. Copy config and script files ---
echo "--> Copying configuration and script files..."
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
        cp -rv "$SRC"* "$DEST" || echo "[!] No $cfg config files to copy"
    else
        echo "[DRY-RUN] Would copy $cfg configs from $SRC to $DEST"
    fi
done

# Copy scripts (including launch scripts)
echo "--> Copying scripts..."
SCRIPTS_DIR="$SCRIPT_DIR/scripts/"
if ! $DRY_RUN; then
    cp -rv "$SCRIPTS_DIR"* "$HOME/level-up/scripts/" || echo "[!] No scripts to copy"
else
    echo "[DRY-RUN] Would copy scripts from $SCRIPTS_DIR to $HOME/level-up/scripts/"
fi

# --- 5. Copy Hyprland/Hyprlock configs ---
echo "--> Copying Hyprland and Hyprlock configs..."
HYPRLAND_CONF="$SCRIPT_DIR/configs/hypr/hyprland.conf"
HYPRLOCK_CONF="$SCRIPT_DIR/configs/hypr/hyprlock.conf"
# Define the path to the script needing execution permission
WAYBAR_LAUNCH_SCRIPT="$SCRIPT_DIR/scripts/launch-waybar-with-logging.sh" 

if [[ -f "$HYPRLAND_CONF" ]]; then
    if ! $DRY_RUN; then
        cp -v "$HYPRLAND_CONF" "$HOME/.config/hypr/hyprland.conf"
        echo "    hyprland.conf copied to $HOME/.config/hypr/"
        
        # --- NEW CODE BLOCK: Give the script execute permissions ---
        if [[ -f "$WAYBAR_LAUNCH_SCRIPT" ]]; then
            chmod +x "$WAYBAR_LAUNCH_SCRIPT"
            echo "    Execute permission added to launch-waybar-with-logging.sh"
        else
            echo "    [!] launch-waybar-with-logging.sh not found. Cannot set execute permission."
        fi
        # --------------------------------------------------------

        # --- Append the exec-once line to hyprland.conf ---
        USER_NAME=$(whoami)
        # Note: Ensure $SCRIPT_DIR is resolved to the absolute path of the project root
        WAYBAR_EXEC_PATH="/home/$USER_NAME/level-up/scripts/launch-waybar-with-logging.sh"
        sed -i "25i exec-once = $WAYBAR_EXEC_PATH" "$HOME/.config/hypr/hyprland.conf"
        echo "    Added exec-once line to hyprland.conf"
    else
        echo "[DRY-RUN] Would copy hyprland.conf to $HOME/.config/hypr/"
    fi
else
    echo "    [!] hyprland.conf not found. Skipping."
fi

# --- 6. Copy wallpaper ---
WALLPAPER="$SCRIPT_DIR/wallpapers/end_4HyprlandWallpaper.png"
if [[ -f "$WALLPAPER" ]]; then
    if ! $DRY_RUN; then
        cp -v "$WALLPAPER" "$HOME/Pictures/"
    else
        echo "[DRY-RUN] Would copy wallpaper to $HOME/Pictures/"
    fi
else
    echo "    [!] Wallpaper not found. Skipping."
fi

# --- 7. Generate Fastfetch config ---
echo "--> Generating Fastfetch config..."
if command -v fastfetch &> /dev/null; then
    if ! $DRY_RUN; then
        fastfetch --gen-config || echo "    [!] Fastfetch failed to generate config."
    else
        echo "[DRY-RUN] Would run 'fastfetch --gen-config'"
    fi
else
    echo "    [!] Fastfetch not found. Skipping."
fi

# --- 8. Optional terminal prompt customization ---
read -r -p "Do you want to customize your terminal prompt with a green username? (y/n): " REPLY
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo "--> Updating .bashrc with a custom green prompt..."
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
            echo "    Custom prompt added."
        else
            echo "    Custom prompt already exists."
        fi
    else
        echo "[DRY-RUN] Would add custom green prompt to .bashrc"
    fi
else
    echo "    Skipping terminal prompt customization."
fi

# --- 9. Set up libvirt for virt-manager ---
echo "--> Setting up libvirt and virtualization support..."
if ! $DRY_RUN; then
    sudo systemctl enable --now libvirtd || true
else
    echo "[DRY-RUN] Would enable and start libvirtd service"
fi

if id -nG "$USER" | grep -qw libvirt; then
    echo "    User already in libvirt group. Skipping."
else
    if ! $DRY_RUN; then
        sudo usermod -aG libvirt "$USER"
    else
        echo "[DRY-RUN] Would add user $USER to libvirt group"
    fi
fi

# --- 10. Create a Level-Up session for SDDM ---
echo "--> Creating Level-Up session for SDDM/KDE..."

# Define wrapper paths
WRAPPER_SRC_PATH="$SCRIPT_DIR/scripts/launch-hyprland-with-logging.sh"
WRAPPER_DEST_PATH="/usr/local/bin/launch-hyprland-with-logging.sh"
DESKTOP_ENTRY_FILE="/usr/share/wayland-sessions/level-up.desktop"

if ! $DRY_RUN; then
    # Check if wrapper exists
    if [[ ! -f "$WRAPPER_SRC_PATH" ]]; then
        echo "    [!] Wrapper script $WRAPPER_SRC_PATH not found. Cannot create login session."
    else
        # Copy wrapper to system-wide location
        sudo cp "$WRAPPER_SRC_PATH" "$WRAPPER_DEST_PATH"
        sudo chmod +x "$WRAPPER_DEST_PATH"
        echo "    Wrapper script copied and made executable: $WRAPPER_DEST_PATH"

        # Create a system-wide desktop entry pointing to the wrapper script
        sudo bash -c "cat > '$DESKTOP_ENTRY_FILE'" <<EOF
[Desktop Entry]
Name=Level-Up
Comment=Launch Level-Up Hyprland session with logging
Exec=env XDG_CURRENT_DESKTOP=Hyprland $WRAPPER_DEST_PATH  # Set it to Hyprland
TryExec=$WRAPPER_DEST_PATH
Type=Application
DesktopNames=Level-Up
EOF
       
        # Ensure desktop entry is readable
        sudo chmod 644 "$DESKTOP_ENTRY_FILE"

        echo "    Desktop entry created at: $DESKTOP_ENTRY_FILE"
        echo "    You should now see 'Level-Up' as a login option in SDDM after logging out."
    fi
else
    echo "[DRY-RUN] Would copy wrapper to $WRAPPER_DEST_PATH and make executable"
    echo "[DRY-RUN] Would create system-wide desktop entry at $DESKTOP_ENTRY_FILE"
fi


echo "    [!] You may need to log out and log back in for group changes to take effect."

echo "==> Installation complete!"
echo "==> Welcome to Level-Up!"
echo "==> You can now log into Level-Up from your display manager, or type 'Hyprland' in a TTY."
