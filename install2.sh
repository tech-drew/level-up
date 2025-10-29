#!/bin/bash

set -euo pipefail

# --- Setup logging ---
LOG_DIR="$HOME/.local/share/level-up"
LOG_FILE="$LOG_DIR/level-up-install.log"
mkdir -p "$LOG_DIR"
exec > >(tee -a "$LOG_FILE") 2>&1

# --- Security disclaimer ---
echo "==> SECURITY DISCLAIMER"
echo "This script requires sudo permissions to install packages and configure system services."
echo "Please review and understand the script before running it."
read -r -p "Do you want to continue? (y/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Exiting installation."
    exit 1
fi

# --- Dry-run support ---
DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "==> Dry-run mode enabled. No changes will be made."
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
)
echo "--> Creating config directories..."
for dir in "${CONFIG_DIRS[@]}"; do
    if ! $DRY_RUN; then
        mkdir -p "$dir"
    else
        echo "[DRY-RUN] Would create directory: $dir"
    fi
done

# --- 4. Copy config files ---
echo "--> Copying configuration files..."
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

# --- 5. Copy Hyprland/Hyprlock configs ---
echo "--> Copying Hyprland and Hyprlock configs..."
HYPRLAND_CONF="$SCRIPT_DIR/configs/hypr/hyprland.conf"
HYPRLOCK_CONF="$SCRIPT_DIR/configs/hypr/hyprlock.conf"

if [[ -f "$HYPRLAND_CONF" ]]; then
    if ! $DRY_RUN; then
        cp -v "$HYPRLAND_CONF" "$HOME/.config/hypr/hyprland.conf"
    else
        echo "[DRY-RUN] Would copy hyprland.conf to $HOME/.config/hypr/"
    fi
else
    echo "    [!] hyprland.conf not found. Skipping."
fi

if [[ -f "$HYPRLOCK_CONF" ]]; then
    if ! $DRY_RUN; then
        cp -v "$HYPRLOCK_CONF" "$HOME/.config/hypr/hyprlock.conf"
    else
        echo "[DRY-RUN] Would copy hyprlock.conf to $HOME/.config/hypr/"
    fi
else
    echo "    [!] hyprlock.conf not found. Skipping."
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

echo "    [!] You may need to log out and log back in for group changes to take effect."

echo "==> Installation complete!"
echo "==> Welcome to Level-Up!"
echo "==> You can now log into Hyprland from your display manager, or type 'Hyprland' in a TTY."
