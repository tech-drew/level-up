#!/bin/bash

echo "==> Starting Fedora Level-Up Hyprland installation..."

# 1. Install necessary packages
echo "--> Installing packages..."
# Testing without the below repo to cut bloat
# sudo dnf copr enable solopasha/hyprland -y

echo "--> Installing packages..."
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
    libreoffice-writer \
    lxqt-policykit \
    nm-connection-editor \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    timeshift \
    virt-manager \
    waybar \
    wireplumber \
    wofi \
    xdg-utils \
    xorg-x11-font-utils


# Install packages not in main repo.
#Explicitly block weak dependencies to cut down on bloat
sudo dnf copr enable solopasha/hyprland -y
sudo dnf install --setopt=install_weak_deps=False -y \
  fastfetch \
  hyprlock \
  swww


# 2. Set default file associations
echo "--> Setting default file associations..."

MIME_FILE="$HOME/.config/mimeapps.list"

mkdir -p "$(dirname "$MIME_FILE")"

# Write default apps using proper [Default Applications] section
cat > "$MIME_FILE" <<EOF
[Default Applications]
text/plain=org.kde.kate.desktop
application/pdf=org.gnome.Evince.desktop
application/vnd.oasis.opendocument.text=libreoffice-writer.desktop
application/msword=libreoffice-writer.desktop
application/vnd.openxmlformats-officedocument.wordprocessingml.document=libreoffice-writer.desktop
EOF


# 3. Install Microsoft Core Fonts (without RPM Fusion)
echo "--> Installing Microsoft Core Fonts (arial, etc)..."

# Download and install fonts from SourceForge
FONT_TEMP_DIR="/tmp/msfonts"
mkdir -p "$FONT_TEMP_DIR"
cd "$FONT_TEMP_DIR" || exit

echo "--> Downloading Arial32.exe..."
curl -LO "https://downloads.sourceforge.net/project/corefonts/the%20fonts/final/arial32.exe"

echo "--> Extracting and installing fonts..."
cabextract arial32.exe

# Create fonts directory if needed
mkdir -p ~/.local/share/fonts

# Move extracted TTF fonts to user's font directory
mv *.ttf ~/.local/share/fonts/

# Refresh font cache
fc-cache -fv

# Clean up
cd ~
rm -rf "$FONT_TEMP_DIR"

echo " Microsoft Core Fonts installed successfully."

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

echo "--> Copying hyprlock.conf..."

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

# 8. Bash prompt customization
echo "--> Updating .bashrc prompt..."
if ! grep -q "Custom green prompt" "${HOME}/.bashrc"; then
    echo -e "\n# Custom green prompt" >> "${HOME}/.bashrc"
    echo 'GREEN="\[\e[38;5;38m\]"' >> "${HOME}/.bashrc"
    echo 'RESET="\[\e[0m\]"' >> "${HOME}/.bashrc"
    echo 'PS1="${GREEN}\u@\h${RESET}:\w\$ "' >> "${HOME}/.bashrc"
fi

# 9. Pipewire Audio Service
if systemctl --user --quiet; then
    echo "--> Enabling Pipewire Audio Service..."
    SYSTEMD_PAGER= systemctl --user enable --now pipewire-pulse.service
else
    echo "[!] systemctl --user not available. Skipping PipeWire PulseAudio service enable."
fi

# 10. Done!
echo "==> Installation complete!"
echo "==> Welcome to Level-Up!"
echo "==> To get started, type 'Hyprland' in the terminal and press Enter."
