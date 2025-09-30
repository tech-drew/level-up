#!/bin/bash

# Exit on error
set -e

# Get script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Starting Fedora Level-Up Hyprland installation..."

# 0. Check for sudo
if ! command -v sudo &>/dev/null; then
  echo "[!] sudo is not installed. Please install sudo first."
  exit 1
fi

# 1. Install Hyprland-related and other needed packages (no KDE defaults)
echo "--> Installing required packages..."

sudo dnf clean all
sudo dnf install -y \
    alacritty \
    cabextract \
    curl \
    fastfetch \
    galculator \
    gimp \
    hyprland \
    hyprlock \
    hyprland-qtutils \
    korganizer \
    libreoffice-writer \
    swww \
    waybar \
    wofi \
    wl-clipboard \
    timeshift

# 2. Add Hyprland Copr repo (to ensure up-to-date packages)
echo "--> Enabling Hyprland Copr repo..."
sudo dnf copr enable solopasha/hyprland -y

# 3. Install Microsoft Fonts
echo "--> Installing Microsoft Core Fonts..."
FONT_TEMP_DIR="/tmp/msfonts"
FONT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
mkdir -p "$FONT_TEMP_DIR"
cd "$FONT_TEMP_DIR"
curl -LO "https://downloads.sourceforge.net/project/corefonts/the%20fonts/final/arial32.exe"
cabextract arial32.exe
mkdir -p "$FONT_DIR"
mv *.ttf "$FONT_DIR"
fc-cache -fv
cd ~
rm -rf "$FONT_TEMP_DIR"
echo "    ✓ Microsoft Core Fonts installed."

# 4. Create config directories
echo "--> Creating config directories..."
mkdir -p "${HOME}/.config/alacritty"
mkdir -p "${HOME}/.config/fastfetch"
mkdir -p "${HOME}/.config/hypr"
mkdir -p "${HOME}/.config/waybar"
mkdir -p "${HOME}/.config/wofi"
mkdir -p "${HOME}/.config/timeshift"
mkdir -p "${HOME}/Pictures"

# 5. Copy configs
echo "--> Copying configuration files..."
cp -r "${SCRIPT_DIR}/configs/alacritty/"* "${HOME}/.config/alacritty/" 2>/dev/null || true
cp -r "${SCRIPT_DIR}/configs/fastfetch/"* "${HOME}/.config/fastfetch/" 2>/dev/null || true
cp -r "${SCRIPT_DIR}/configs/waybar/"* "${HOME}/.config/waybar/" 2>/dev/null || true
cp -r "${SCRIPT_DIR}/configs/wofi/"* "${HOME}/.config/wofi/" 2>/dev/null || true
cp -r "${SCRIPT_DIR}/configs/timeshift/"* "${HOME}/.config/timeshift/" 2>/dev/null || true

# 6. Copy Hyprland/Hyprlock configs
echo "--> Copying Hyprland and Hyprlock configs..."
HYPRLAND_CONF_SOURCE="${SCRIPT_DIR}/configs/hypr/hyprland.conf"
HYPRLOCK_CONF_SOURCE="${SCRIPT_DIR}/configs/hypr/hyprlock.conf"

if [ -f "$HYPRLAND_CONF_SOURCE" ]; then
    cp "$HYPRLAND_CONF_SOURCE" "${HOME}/.config/hypr/hyprland.conf"
    echo "    ✓ hyprland.conf copied."
else
    echo "    [!] hyprland.conf not found. Skipping."
fi

if [ -f "$HYPRLOCK_CONF_SOURCE" ]; then
    cp "$HYPRLOCK_CONF_SOURCE" "${HOME}/.config/hypr/hyprlock.conf"
    echo "    ✓ hyprlock.conf copied."
else
    echo "    [!] hyprlock.conf not found. Skipping."
fi

# 7. Set wallpaper
echo "--> Copying default wallpaper..."
WALLPAPER_SOURCE="${SCRIPT_DIR}/wallpapers/end_4HyprlandWallpaper.png"
if [ -f "$WALLPAPER_SOURCE" ]; then
    cp "$WALLPAPER_SOURCE" "${HOME}/Pictures/"
    echo "    ✓ Wallpaper copied."
else
    echo "    [!] Wallpaper not found. Skipping."
fi

# 8. Generate Fastfetch config
echo "--> Generating Fastfetch config..."
fastfetch --gen-config || echo "    [!] Fastfetch not found or failed to generate config."

# 9. Optional terminal prompt customization
echo "Do you want to customize your terminal prompt? (y/n)"
read -r change_prompt
if [ "$change_prompt" == "y" ]; then
    echo "--> Updating .bashrc with a custom green prompt..."
    if ! grep -q "Custom green prompt" "${HOME}/.bashrc"; then
        {
            echo -e "\n# Custom green prompt"
            echo 'GREEN="\[\e[38;5;38m\]"'
            echo 'RESET="\[\e[0m\]"'
            echo 'PS1="${GREEN}\u@\h${RESET}:\w\$ "'
        } >> "${HOME}/.bashrc"
        echo "    ✓ Custom prompt added."
    else
        echo "    ✓ Custom prompt already exists."
    fi
fi

# 10. Create Hyprland session file (only if it doesn't exist)
SESSION_FILE="/usr/share/wayland-sessions/hyprland.desktop"
echo "--> Ensuring Hyprland session file exists..."
if [ ! -f "$SESSION_FILE" ]; then
    echo "    Creating Hyprland session file..."
    sudo mkdir -p /usr/share/wayland-sessions
    sudo tee "$SESSION_FILE" > /dev/null <<EOF
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
DesktopNames=Hyprland
EOF
    echo "    ✓ Hyprland session file created."
else
    echo "    ✓ Session file already exists. Skipping."
fi

# Done
echo "==> Installation complete!"
echo "==> Welcome to Level-Up!"
echo "==> You can now log into Hyprland from your display manager, or type 'Hyprland' in a TTY."
