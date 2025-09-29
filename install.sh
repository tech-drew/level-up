#!/bin/bash

echo "==> Starting Fedora Level-Up Hyprland installation..."

# 1. Install necessary packages
echo "--> Installing packages..."

sudo dnf clean all
sudo dnf install -y \
    alacritty \
    cabextract \
    curl \
    dolphin \
    evince \
    firefox \
    fontconfig \
    galculator \
    gimp \
    gnome-calendar \
    hyprland \
    kate \
    kde-cli-tools \
    kde-runtime \
    libreoffice-writer \
    lxqt-policykit \
    nm-connection-editor \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    virt-manager \
    wayland-utils wl-clipboard \
    wireplumber \
    xdg-utils \
    xorg-x11-font-utils \
    timeshift  # Added Timeshift here

# Install Waybar/Wofi (important for Wayland setups)
echo "--> Installing Waybar and Wofi for Wayland..."
sudo dnf install -y waybar wofi

# Install packages not in main repo.
echo "--> Adding solopasha/hyprland repo for packages not in main repo..."
sudo dnf copr enable solopasha/hyprland -y
sudo dnf install --setopt=install_weak_deps=False -y \
  fastfetch \
  hyprlock \
  hyprland-qtutils \
  swww

# 2. Microsoft Fonts installation
echo "--> Installing Microsoft Core Fonts (arial, etc.)..."
FONT_TEMP_DIR="/tmp/msfonts"
mkdir -p "$FONT_TEMP_DIR"
cd "$FONT_TEMP_DIR" || exit
curl -LO "https://downloads.sourceforge.net/project/corefonts/the%20fonts/final/arial32.exe"
cabextract arial32.exe
mkdir -p ~/.local/share/fonts
mv *.ttf ~/.local/share/fonts/
fc-cache -fv
cd ~
rm -rf "$FONT_TEMP_DIR"
echo " Microsoft Core Fonts installed successfully."

# 3. Create config directories
echo "--> Creating config directories..."
mkdir -p "${HOME}/.config/alacritty"
mkdir -p "${HOME}/.config/fastfetch"
mkdir -p "${HOME}/.config/hypr"
mkdir -p "${HOME}/Pictures"
mkdir -p "${HOME}/.config/waybar"
mkdir -p "${HOME}/.config/wofi"
mkdir -p "${HOME}/.config/timeshift"  # Added Timeshift config directory

# 4. Copy config files
echo "--> Copying configuration files..."
cp -r "${HOME}/Level-Up/configs/alacritty/"* "${HOME}/.config/alacritty/"
cp -r "${HOME}/Level-Up/configs/fastfetch/"* "${HOME}/.config/fastfetch/"
cp -r "${HOME}/Level-Up/configs/waybar/"* "${HOME}/.config/waybar/"
cp -r "${HOME}/Level-Up/configs/wofi/"* "${HOME}/.config/wofi/"
cp -r "${HOME}/Level-Up/configs/timeshift/"* "${HOME}/.config/timeshift/"  # Copy Timeshift configs

# 5. Copy hyprland configuration files
echo "--> Copying hyprland and hyprlock config..."
HYPRLAND_CONF_SOURCE="${HOME}/Level-Up/configs/hypr/hyprland.conf"
HYPRLAND_CONF_DEST="${HOME}/.config/hypr/hyprland.conf"
if [ -f "$HYPRLAND_CONF_SOURCE" ]; then
    cp "$HYPRLAND_CONF_SOURCE" "$HYPRLAND_CONF_DEST"
    echo "    ✓ hyprland.conf copied to ~/.config/hypr/"
else
    echo "    [!] hyprland.conf not found at $HYPRLAND_CONF_SOURCE. Skipping."
fi

HYPRLOCK_CONF_SOURCE="${HOME}/Level-Up/configs/hypr/hyprlock.conf"
HYPRLOCK_CONF_DEST="${HOME}/.config/hypr/hyprlock.conf"
if [ -f "$HYPRLOCK_CONF_SOURCE" ]; then
    cp "$HYPRLOCK_CONF_SOURCE" "$HYPRLOCK_CONF_DEST"
    echo "    ✓ hyprlock.conf copied to ~/.config/hypr/"
else
    echo "    [!] hyprlock.conf not found at $HYPRLOCK_CONF_SOURCE. Skipping."
fi

# 6. Set wallpaper
echo "--> Copying default wallpaper..."
cp "${HOME}/Level-Up/wallpapers/end_4HyprlandWallpaper.png" "${HOME}/Pictures/"

# 7. Generate Fastfetch default config
echo "--> Generating Fastfetch config..."
fastfetch --gen-config

# 8. Optional: Bash prompt customization
echo "Do you want to customize your terminal prompt? (y/n)"
read change_prompt
if [ "$change_prompt" == "y" ]; then
    echo "--> Updating .bashrc with a custom green prompt..."
    if ! grep -q "Custom green prompt" "${HOME}/.bashrc"; then
        echo -e "\n# Custom green prompt" >> "${HOME}/.bashrc"
        echo 'GREEN="\[\e[38;5;38m\]"' >> "${HOME}/.bashrc"
        echo 'RESET="\[\e[0m\]"' >> "${HOME}/.bashrc"
        echo 'PS1="${GREEN}\u@\h${RESET}:\w\$ "' >> "${HOME}/.bashrc"
    fi
fi

# 9. Pipewire Audio Service (skip if already present)
if systemctl --user --quiet; then
    echo "--> Enabling Pipewire Audio Service..."
    SYSTEMD_PAGER=cat systemctl --user --no-pager enable --now pipewire-pulse.service
else
    echo "[!] systemctl --user not available. Skipping PipeWire PulseAudio service enable."
fi

# 10. Done!
echo "==> Installation complete!"
echo "==> Welcome to Level-Up!"
echo "==> To get started, type 'Hyprland' in the terminal and press Enter."
