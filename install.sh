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
    libreoffice \
    cabextract  # for MS fonts installer

# Install Microsoft core fonts
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# [+] Setting up power menu script
echo "[+] Setting up power menu script..."
mkdir -p ~/.config/hypr/waybar/scripts
cp ./scripts/power_menu.sh ~/.config/hypr/waybar/scripts/
chmod +x ~/.config/hypr/waybar/scripts/power_menu.sh

# 2. Create config directories
echo "--> Creating config directories..."
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/fastfetch
mkdir -p ~/.config/waybar
mkdir -p ~/.config/hypr
mkdir -p ~/Pictures

# 3. Copy config files
echo "--> Copying configuration files..."
cp -r ./configs/alacritty/* ~/.config/alacritty/
cp -r ./configs/fastfetch/* ~/.config/fastfetch/
cp -r ./configs/waybar/* ~/.config/waybar/
cp -r ./configs/hypr/* ~/.config/hypr/

# 4. Wallpaper
echo "--> Copying default wallpaper..."
cp ./wallpapers/end_4HyprlandWallpaper.png ~/Pictures/

# 5. Fastfetch default config
echo "--> Generating Fastfetch config..."
fastfetch --gen-config

# 6. Bash prompt customization
echo "--> Updating .bashrc prompt..."
GREEN='\[\e[38;5;38m\]'
RESET='\[\e[0m\]'
PROMPT='PS1="${GREEN}\u@\h${RESET}:\w\$ "'

if ! grep -q "$PROMPT" ~/.bashrc; then
    echo -e "\n# Custom green prompt" >> ~/.bashrc
    echo "$PROMPT" >> ~/.bashrc
fi

echo "==> Installation complete!"
echo "==> Welcome to Level-Up!"
echo "==> To get started, type 'hyprland' in the terminal and press Enter."
