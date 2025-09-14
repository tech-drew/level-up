#!/bin/bash

echo "==> Starting Fedora Level-Up Hyprland installation..."

# 1. Install necessary packages
echo "--> Adding COPR repo and installing packages..."
sudo dnf copr enable solopasha/hyprland -y

echo "--> Installing packages..."
sudo dnf install -y \
    hyprland \
    alacritty \
    fastfetch \
    swww \
    waybar \
    dolphin \
    timeshift \
    lxqt-policykit \
    wofi \
    firefox \
    gnome-calendar \
    galculator \
    gimp \
    virt-manager \
    nm-connection-editor \
    libreoffice-writer \
    cabextract \
    curl \
    fontconfig \
    xorg-x11-font-utils

# 2. Install Microsoft Core Fonts manually
echo "--> Installing Microsoft fonts..."
mkdir -p /tmp/msttfonts
cd /tmp/msttfonts || exit
curl -LO https://downloads.sourceforge.net/corefonts/msttcorefonts.tar.gz
sudo tar -C /usr/share/fonts -xzf msttcorefonts.tar.gz
sudo fc-cache -fv
cd ~ || exit
rm -rf /tmp/msttfonts

# 3. Set up power menu script
echo "[+] Setting up power menu script..."
POWER_MENU_SOURCE="${HOME}/Level-Up/configs/waybar/scripts/power_menu.sh"
POWER_MENU_DEST="${HOME}/.config/hypr/waybar/scripts"

if [ -f "$POWER_MENU_SOURCE" ]; then
    mkdir -p "$POWER_MENU_DEST"
    cp "$POWER_MENU_SOURCE" "$POWER_MENU_DEST/"
    chmod +x "$POWER_MENU_DEST/power_menu.sh"
else
    echo "[!] Warning: power_menu.sh not found at $POWER_MENU_SOURCE. Skipping power menu setup."
fi

# 4. Create config directories
echo "--> Creating config directories..."
mkdir -p "${HOME}/.config/alacritty"
mkdir -p "${HOME}/.config/fastfetch"
mkdir -p "${HOME}/.config/waybar"
mkdir -p "${HOME}/.config/hypr"
mkdir -p "${HOME}/Pictures"

# 5. Copy config files
echo "--> Copying configuration files..."

cp -r "${HOME}/Level-Up/configs/alacritty/"* "${HOME}/.config/alacritty/"
cp -r "${HOME}/Level-Up/configs/fastfetch/"* "${HOME}/.config/fastfetch/"
cp -r "${HOME}/Level-Up/configs/waybar/"* "${HOME}/.config/waybar/"

echo "--> Copying hyprland.conf..."

HYPRLAND_CONF_SOURCE="${HOME}/Level-Up/configs/hypr/hyprland.conf"
HYPRLAND_CONF_DEST="${HOME}/.config/hypr/hyprland.conf"

if [ -f "$HYPRLAND_CONF_SOURCE" ]; then
    cp "$HYPRLAND_CONF_SOURCE" "$HYPRLAND_CONF_DEST"
    echo "    ✓ hyprland.conf copied to ~/.config/hypr/"
else
    echo "    [!] hyprland.conf not found at $HYPRLAND_CONF_SOURCE. Skipping."
fi

# 6. Set wallpaper
echo "--> Copying default wallpaper..."
cp "${HOME}/Level-Up/wallpapers/end_4HyprlandWallpaper.png" "${HOME}/Pictures/"

# 7. Generate Fastfetch default config
echo "--> Generating Fastfetch config..."
fastfetch --gen-config

# 8. Bash prompt customization
echo "--> Updating .bashrc prompt..."
if ! grep -q "Custom green prompt" "${HOME}/.bashrc"; then
    echo -e "\n# Custom green prompt" >> "${HOME}/.bashrc"
    echo 'GREEN="\[\e[38;5;38m\]"' >> "${HOME}/.bashrc"
    echo 'RESET="\[\e[0m\]"' >> "${HOME}/.bashrc"
    echo 'PS1="${GREEN}\u@\h${RESET}:\w\$ "' >> "${HOME}/.bashrc"
fi

# 9. Done!
echo "==> Installation complete!"
echo "==> Welcome to Level-Up!"
echo "==> To get started, type 'Hyprland' in the terminal and press Enter."
