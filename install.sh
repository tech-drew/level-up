#!/bin/bash

set -euo pipefail

# Get script's directory reliably
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Script directory: $SCRIPT_DIR"

echo "==> Starting Fedora Level-Up Hyprland installation..."

# 1. Install Hyprland-related and other needed packages (no KDE defaults)
echo "--> Installing required packages..."

sudo dnf clean all
sudo dnf install -y \
    alacritty \
    fastfetch \
    gimp \
    hyprland \
    hyprlock \
    hyprland-qtutils \
    swww \
    waybar \
    wofi \
    wl-clipboard \
    timeshift

# 2. Enable COPR and install extra packages
echo "--> Enabling solopasha/hyprland COPR repo..."
sudo dnf copr enable solopasha/hyprland -y

echo "--> Installing COPR packages (if available)..."
for pkg in hyprlock hyprland-qtutils swww; do
    if sudo dnf list --available "$pkg" &> /dev/null; then
        echo "    Installing $pkg..."
        sudo dnf install -y "$pkg"
    else
        echo "    Package '$pkg' not found in repos. Skipping."
    fi
done

# 3. Create config directories
echo "--> Creating config directories..."
mkdir -p "$HOME/.config/alacritty"
mkdir -p "$HOME/.config/fastfetch"
mkdir -p "$HOME/.config/hypr"
mkdir -p "$HOME/.config/waybar"
mkdir -p "$HOME/.config/wofi"
mkdir -p "$HOME/.config/timeshift"
mkdir -p "$HOME/Pictures"

# 4. Copy config files with verbose output (remove error hiding)
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

if [[ -f "$HYPRLAND_CONF_SOURCE" ]]; then
    cp -v "$HYPRLAND_CONF_SOURCE" "$HOME/.config/hypr/hyprland.conf"
else
    echo "    [!] hyprland.conf not found. Skipping."
fi

if [[ -f "$HYPRLOCK_CONF_SOURCE" ]]; then
    cp -v "$HYPRLOCK_CONF_SOURCE" "$HOME/.config/hypr/hyprlock.conf"
else
    echo "    [!] hyprlock.conf not found. Skipping."
fi

# 6. Copy wallpaper
echo "--> Copying default wallpaper..."
WALLPAPER_SOURCE="$SCRIPT_DIR/wallpapers/end_4HyprlandWallpaper.png"
if [[ -f "$WALLPAPER_SOURCE" ]]; then
    cp -v "$WALLPAPER_SOURCE" "$HOME/Pictures/"
else
    echo "    [!] Wallpaper not found. Skipping."
fi

# 7. Generate Fastfetch config
echo "--> Generating Fastfetch config..."
if command -v fastfetch &> /dev/null; then
    fastfetch --gen-config
else
    echo "    [!] Fastfetch not found or failed to generate config."
fi

# 8. Optional terminal prompt customization
read -r -p "Do you want to customize your terminal prompt with a green username? (y/N): " REPLY
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo "--> Updating .bashrc with a custom green prompt..."
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

echo "==> Installation complete!"
echo "==> Welcome to Level-Up!"
echo "==> You can now log into Hyprland from your display manager, or type 'Hyprland' in a TTY."
