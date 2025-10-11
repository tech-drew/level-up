#!/bin/bash

# Get script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
    if dnf list --available "$pkg" &> /dev/null; then
        echo "    Installing $pkg..."
        sudo dnf install -y "$pkg"
    else
        echo "    Package '$pkg' not found in repos. Skipping."
    fi
done

# 3. Create config directories
echo "--> Creating config directories..."
mkdir -p "${HOME}/.config/alacritty"
mkdir -p "${HOME}/.config/fastfetch"
mkdir -p "${HOME}/.config/hypr"
mkdir -p "${HOME}/.config/waybar"
mkdir -p "${HOME}/.config/wofi"
mkdir -p "${HOME}/.config/timeshift"
mkdir -p "${HOME}/Pictures"

# 4. Copy config files
echo "--> Copying configuration files..."
cp -r "${SCRIPT_DIR}/configs/alacritty/"* "${HOME}/.config/alacritty/" 2>/dev/null || true
cp -r "${SCRIPT_DIR}/configs/fastfetch/"* "${HOME}/.config/fastfetch/" 2>/dev/null || true
cp -r "${SCRIPT_DIR}/configs/waybar/"* "${HOME}/.config/waybar/" 2>/dev/null || true
cp -r "${SCRIPT_DIR}/configs/wofi/"* "${HOME}/.config/wofi/" 2>/dev/null || true
cp -r "${SCRIPT_DIR}/configs/timeshift/"* "${HOME}/.config/timeshift/" 2>/dev/null || true

# 5. Copy Hyprland/Hyprlock configs
echo "--> Copying Hyprland and Hyprlock configs..."
HYPRLAND_CONF_SOURCE="${SCRIPT_DIR}/configs/hypr/hyprland.conf"
HYPRLOCK_CONF_SOURCE="${SCRIPT_DIR}/configs/hypr/hyprlock.conf"

if [ -f "$HYPRLAND_CONF_SOURCE" ]; then
    cp "$HYPRLAND_CONF_SOURCE" "${HOME}/.config/hypr/hyprland.conf"
    echo "    hyprland.conf copied."
else
    echo "    [!] hyprland.conf not found. Skipping."
fi

if [ -f "$HYPRLOCK_CONF_SOURCE" ]; then
    cp "$HYPRLOCK_CONF_SOURCE" "${HOME}/.config/hypr/hyprlock.conf"
    echo "    hyprlock.conf copied."
else
    echo "    [!] hyprlock.conf not found. Skipping."
fi

# 6. Copy wallpaper
echo "--> Copying default wallpaper..."
WALLPAPER_SOURCE="${SCRIPT_DIR}/wallpapers/end_4HyprlandWallpaper.png"
if [ -f "$WALLPAPER_SOURCE" ]; then
    cp "$WALLPAPER_SOURCE" "${HOME}/Pictures/"
    echo "    Wallpaper copied."
else
    echo "    [!] Wallpaper not found. Skipping."
fi

# 7. Generate Fastfetch config
echo "--> Generating Fastfetch config..."
fastfetch --gen-config || echo "    [!] Fastfetch not found or failed to generate config."

# 8. Optional terminal prompt customization
read -p "Do you want to customize your terminal prompt with a green username? (y/N): " -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "--> Updating .bashrc with a custom green prompt..."
    if ! grep -q "Custom green prompt" "${HOME}/.bashrc"; then
        {
            echo -e "\n# Custom green prompt"
            echo 'GREEN="\[\e[38;5;38m\]"'
            echo 'RESET="\[\e[0m\]"'
            echo 'PS1="${GREEN}\u@\h${RESET}:\w\$ "'
        } >> "${HOME}/.bashrc"
        echo "    Custom prompt added."
    else
        echo "    Custom prompt already exists."
    fi
else
    echo "    Skipping terminal prompt customization."
fi

# Done
echo "==> Installation complete!"
echo "==> Welcome to Level-Up!"
echo "==> You can now log into Hyprland from your display manager, or type 'Hyprland' in a TTY."
