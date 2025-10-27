# Private Internet Access Fedora 42 Hyprland Setup
This guide explains how to install and configure Private Internet Access (PIA) on Fedora 42 with Hyprland, ensuring the VPN service starts automatically and integrates with your workflow.

## Part 1: Download the VPN Installer

Download the Private Internet Access Linux installer from the official website:  
https://www.privateinternetaccess.com/download/linux-vpn  

The downloaded file should look similar to:  
pia-linux-3.6.2-08398.run

## Part 2: Make the Installer Executable

Open a terminal and navigate to your Downloads folder. Or navigate to the directory where you saved the file you just downloaded.:  
```bash
cd ~/Downloads  
```

Make the installer executable:  
```bash
chmod +x pia-linux-3.6.2-08398.run  
```

> Replace `pia-linux-3.6.2-08398.run` with the actual name of your downloaded file.

## Part 3: Run the Installer

Run the installer:  
```bash
./pia-linux-3.6.2-08398.run
```

## Part 4: Verify the PIA Service

Check the name of the PIA systemd service:  
```bash
systemctl list-unit-files | grep pia  
```

On most systems, the service is named `piavpn.service`.

## Part 5: Enable the PIA Service on Boot

Enable the PIA service to start automatically at boot:  
```bash
sudo systemctl enable --now piavpn.service  
```

> Note: Enabling this service may slightly increase boot time. The VPN service requires root privileges to run and must be active for the VPN to function properly.

## Part 6: (Optional) Auto-start the VPN Client on Hyprland Login

To automatically launch the PIA client frontend when logging into Hyprland:  

1. Edit your Hyprland configuration:  
```bash
vi $HOME/.config/hypr/hyprland.conf  
```

2. Add the following line:  
```bash
exec-once = sleep 1 && /opt/piavpn/bin/pia-client  
```
> **Note:** The `sleep 1` delays the start of the PIA client until after the Waybar loads. Without this, the PIA tray icon may not appear correctly in Waybar.
> **Note:** The `sleep 1` delays the start of the PIA client until after the Waybar loads. Without this, the PIA tray icon may not appear correctly in Waybar.
