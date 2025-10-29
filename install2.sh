#!/bin/bash

set -euo pipefail

# Get script's directory reliably
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Logging setup ---
LOG_DIR="$HOME/.local/share/level-up-hyprland/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/level-up-hyprland-$(date +%Y%m%d-%H%M%S).log"

# Redirect stdout/stderr to tee with timestamps (log + terminal)
exec > >(awk '{ print strftime("[%Y-%m-%d %H:%M:%S]"), $0; fflush(); }' | tee -a "$LOG_FILE") 2>&1

echo "Script directory: $SCRIPT_DIR"
echo "Logging all output to: $LOG_FILE"

# --- Security Disclaimer ---
cat <<'EOF'

=========================================================
SECURITY DISCLAIMER:
This script runs as your regular user but will request
sudo (administrator) permissions during execution to
install packages and modify system settings.

You should **review and understand this script** before
running it to ensure you trust its actions.

Running scripts with sudo can impact system security.
=========================================================

EOF

# Prompt user to continue
read -r -p "Do you understand and want to continue? (y/n): " CONTINUE
if [[ ! "$CONTINUE" =~ ^[Yy]$ ]]; then
    echo "Installation aborted by user."
    exit 1
fi

echo "==> Starting Fedora Level-Up Hyprland installation..."

# 1. Install Hyprland-related and other needed packages
echo "--> Installing required packages..."
sudo dnf clean all
sudo dnf install -y \
    alacritty \
    fastfetch \
    gimp \
    pavucontrol \
    waybar \
    wofi \
    wl-clipboard \
    timeshift \
    virt-manager

# 2. Enable COPR and install extra packages
echo "--> Enabling solopasha/hyprland COPR repo..."
sudo dnf copr enable solopasha/hyprland -y || true  # harmless if already enabled

echo "--> Installing COPR packages (if available)..."
sudo dnf install -y \
    hyprland \
    hyprlock \
    hyprland-qtutils \
    swww \
    --enablerepo=copr:copr.fedorainfracloud.org:solopasha:hyprland

# 3. Create config directories (safe with -p)
echo "--> Creating config directories..."
mkdir -p "$HOME/.config/alacritty" \
         "$HOME/.config/fastfetch" \
         "$HOME/.config/hypr" \
         "$HOME/.config/waybar" \
         "$HOME/.config/wofi" \
         "$HOME/.config/timeshift" \
         "$HOME/Pictures"

# 4. Copy config files
echo "--> Copying configuration files..."
cp -rv "$SCRIPT_DIR/configs/alacritty/"* "$HOME/.config/alacritty/" || echo "[!] No alacritty config files to copy"
cp -rv "$SCRIPT_DIR/configs/fastfetch/"* "$HOME/.config/fastfetch/" || echo "[!] No fastfetch config files to copy"
cp -rv "$SCRIPT_DIR/configs/waybar/"* "$HOME/.config/waybar/" || echo "[!] No waybar config files to copy"
cp -rv "$SCRIPT_DIR/configs/wofi/"* "$HOME/.config/wofi/" || echo "[!] No wofi config files to copy"
cp -rv "$SCRIPT_DIR/configs/timeshift/"* "$HOME/.config/timeshift/" || echo "[!] No timeshift config files to copy"

# 5. Copy Hyprland/Hyprlock configs
echo "--> Copying Hyprland and Hyprlock configs..."
HYPRLAND_CONF_SOURCE="$SCRIPT_DIR/configs/hypr/hyprland.conf"
HYPRLOCK_CONF_SOURCE="$SCRIPT_DIR/configs/hypr/hyprlock.conf"

[[ -f "$HYPRLAND_CONF_SOURCE" ]] && cp -v "$HYPRLAND_CONF_SOURCE" "$HOME/.config/hypr/hyprland.conf" || echo "    [!] hyprland.conf not found. Skipping."
[[ -f "$HYPRLOCK_CONF_SOURCE" ]] && cp -v "$HYPRLOCK_CONF_SOURCE" "$HOME/.config/hypr/hyprlock.conf" || echo "    [!] hyprlock.conf not found. Skipping."

# 6. Copy wallpaper
echo "--> Copying default wallpaper..."
WALLPAPER_SOURCE="$SCRIPT_DIR/wallpapers/end_4HyprlandWallpaper.png"
[[ -f "$WALLPAPER_SOURCE" ]] && cp -v "$WALLPAPER_SOURCE" "$HOME/Pictures/" || echo "    [!] Wallpaper not found. Skipping."

# 7. Generate Fastfetch config
echo "--> Generating Fastfetch config..."
if command -v fastfetch &> /dev/null; then
    fastfetch --gen-config || echo "    [!] Fastfetch failed to generate config."
else
    echo "    [!] Fastfetch not found. Skipping."
fi

# 8. Optional terminal prompt customization
read -r -p "Do you want to customize your terminal prompt with a green username? (y/n): " REPLY
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo "--> Updating .bashrc with a custom green prompt..."
    touch "$HOME/.bashrc"  # ensure .bashrc exists
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
    echo "    Skipping terminal prompt customization."
fi

# 9. Set up libvirt for virt-manager
echo "--> Setting up libvirt and virtualization support..."

echo "    Starting and enabling libvirtd..."
sudo systemctl enable --now libvirtd || true  # harmless if already enabled

echo "    Adding user '$USER' to libvirt group..."
if id -nG "$USER" | grep -qw libvirt; then
    echo "    User already in libvirt group. Skipping."
else
    sudo usermod -aG libvirt "$USER"
fi

echo "    [!] You may need to log out and log back in for group changes to take effect."

echo "==> Installation complete!"
echo "==> Welcome to Level-Up!"
echo "==> You can now log into Hyprland from your display manager, or type 'Hyprland' in a TTY."
