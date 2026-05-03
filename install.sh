#!/bin/bash

set -euo pipefail

# --- Setup logging ---
LOG_DIR="$HOME/.local/share/level-up/logs/install"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/install-session-$(date --utc +"%Y-%m-%d_%H-%M-%S").log"
exec > >(tee -a "$LOG_FILE") 2>&1

log_message() {
    local timestamp=$(date --utc +"%Y-%m-%dT%H:%M:%S.%3NZ")
    echo "[$timestamp] [$2] [$(basename "$0")] $1"
}

log_message "Starting Resilient Installation (v8 - SWWW & GUI-Utils Patch)" "INFO"

error_handler() {
    log_message "Error in command: '${BASH_COMMAND}' with exit code: $?" "ERROR"
    exit 1
}
trap error_handler ERR

# --- Security disclaimer ---
echo "==> SECURITY DISCLAIMER"
echo "The Level-Up install script requires sudo permissions..."
read -r -p "Do you want to continue with these changes? (y/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then exit 1; fi

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

###############################################################################
# --- 1. Repository & Mirror Cleanup ---
###############################################################################

echo "==> 1. Cleaning up mirrors and setting up repos"
sudo dnf clean metadata || true
# Using solopasha for reliable swww and hyprland-guiutils on Fedora 44
sudo dnf copr enable solopasha/hyprland -y

###############################################################################
# --- 2. Install Packages (Resilient Mode) ---
###############################################################################

echo "==> 2. Installing Packages"
PACKAGES=(
    hyprland hyprlock hypridle swww hyprland-qt-support
    hyprland-guiutils
    alacritty btop fastfetch gimp network-manager-applet
    pavucontrol waybar wofi wl-clipboard timeshift virt-manager
    libdisplay-info seatd libseat-devel
    grim slurp qt5ct qt6ct
)

sudo dnf install -y "${PACKAGES[@]}" --allowerasing --skip-broken --skip-unavailable

###############################################################################
# --- 3. Create Config & Icon Directories ---
###############################################################################

echo "==> 3. Creating directories"
CONFIG_DIRS=(
    "$HOME/.config/alacritty" "$HOME/.config/fastfetch"
    "$HOME/.config/hypr" "$HOME/.config/waybar"
    "$HOME/.config/wofi" "$HOME/.config/qt5ct" "$HOME/.config/qt6ct"
    "$HOME/.local/share/icons/level-up-icon-theme"
    "$HOME/Pictures" "$HOME/level-up/scripts"
)
for dir in "${CONFIG_DIRS[@]}"; do
    mkdir -p "$dir"
done

###############################################################################
# --- 4. Install Level-Up Theme (Icons) ---
###############################################################################

echo "==> 4. Extracting Level-Up Icon Theme"
ICON_TAR="$HOME/level-up/themes/level-up-icon-theme.tar.gz"
ICON_DEST="$HOME/.local/share/icons/level-up-icon-theme"

if [[ -f "$ICON_TAR" ]]; then
    tar -xzf "$ICON_TAR" -C "$ICON_DEST"
    echo "    [+] Icons extracted successfully."
else
    echo "    [!] Warning: Icon theme tarball not found at $ICON_TAR"
fi

###############################################################################
# --- 5. Copy Config and Patch Logic ---
###############################################################################

echo "==> 5. Copying configurations and patching files"
CONFIG_MAP=("alacritty" "fastfetch" "waybar" "wofi")
for cfg in "${CONFIG_MAP[@]}"; do
    SRC="$SCRIPT_DIR/configs/$cfg/"
    DEST="$HOME/.config/$cfg/"
    if [[ -d "$SRC" ]]; then
        cp -rv "$SRC"* "$DEST"
    fi
done

cp -rv "$SCRIPT_DIR/scripts/"* "$HOME/level-up/scripts/" || true

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
if [[ -f "$HYPR_CONF" ]]; then
    # Patch 1: windowrulev2 syntax fix
    sed -i 's/windowrule = nofocus/windowrulev2 = nofocus/g' "$HYPR_CONF"

    # Patch 2: Inject Dark Mode Env Variables for Qt Apps (Dolphin fix)
    if ! grep -q "QT_QPA_PLATFORMTHEME" "$HYPR_CONF"; then
        sed -i '1i env = QT_QPA_PLATFORMTHEME,qt5ct' "$HYPR_CONF"
        sed -i '2i env = QT_QPA_PLATFORMTHEME,qt6ct' "$HYPR_CONF"
    fi

    # Patch 3: Force GTK Dark Theme and Icon Theme via gsettings
    if ! grep -q "prefer-dark" "$HYPR_CONF"; then
        echo "exec-once = gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'" >> "$HYPR_CONF"
        echo "exec-once = gsettings set org.gnome.desktop.interface icon-theme 'level-up-icon-theme'" >> "$HYPR_CONF"
    fi

    # Patch 4: Screenshot Bind (Super+Shift+S)
    if ! grep -q "grim -g" "$HYPR_CONF"; then
        echo -e '\n# Screenshot Bind\nbind = SUPER SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy' >> "$HYPR_CONF"
    fi

    # Patch 5: SWWW Autostart (Replacing hyprpaper logic)[cite: 1]
    if ! grep -q "swww-daemon" "$HYPR_CONF"; then
        echo "exec-once = swww-daemon" >> "$HYPR_CONF"
        echo "exec-once = swww img $HOME/Pictures/level-up.png --transition-type simple" >> "$HYPR_CONF"
    fi
fi

###############################################################################
# --- 6. System Binary and Session Setup ---
###############################################################################

echo "==> 6. Setting up system binaries"
WAYBAR_DEST="/usr/local/bin/launch-waybar-with-logging.sh"
LOGGING_DEST="/usr/local/bin/logging.sh"

cp -v "$SCRIPT_DIR/configs/hypr/"* "$HOME/.config/hypr/" || true
sudo cp "$SCRIPT_DIR/scripts/launch-waybar-with-logging.sh" "$WAYBAR_DEST" || true
sudo cp "$SCRIPT_DIR/scripts/logging.sh" "$LOGGING_DEST" || true
sudo chmod 755 "$WAYBAR_DEST" "$LOGGING_DEST" 2>/dev/null || true

echo "==> 7. Finalizing Login Session Entry"
DESKTOP_ENTRY="/usr/share/wayland-sessions/level-up.desktop"
sudo bash -c "cat > '$DESKTOP_ENTRY'" <<EOF
[Desktop Entry]
Name=Level-Up
Comment=Launch Level-Up Hyprland session
Exec=start-hyprland
Type=Application
DesktopNames=Hyprland
EOF

if ! grep -q "Custom green prompt" "$HOME/.bashrc"; then
    {
        echo -e '\n# Custom green prompt'
        echo 'GREEN="\[\e[38;5;38m\]"'
        echo 'RESET="\[\e[0m\]"'
        echo 'PS1="${GREEN}\u@\h${RESET}:\w\$ "'
    } >> "$HOME/.bashrc"
fi

echo "----------------------------------------------------------------"
echo "    [!] Installation Complete!"
echo "    [!] Wallpaper Engine: swww (Installed & Configured)"
echo "    [!] GUI Utils: Added (Warnings cleared)"
echo "    [!] Icons: level-up-icon-theme (Applied via gsettings)"
echo "----------------------------------------------------------------"
log_message "Installation complete!" "INFO"
