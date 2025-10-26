Private Internet Access Fedora 42 Hyprland Setup

1. Download the VPN Installer
Download the Private Internet Access (PIA) Linux installer from the official website:
https://www.privateinternetaccess.com/download/linux-vpn
The downloaded file should look similar to:
pia-linux-3.6.2-08398.run

2. Make the Installer Executable
Open a terminal and navigate to your Downloads folder:
cd ~/Downloads
Make the installer executable by running:
chmod +x pia-linux-3.6.2-08398.run
(Replace pia-linux-3.6.2-08398.run with your actual downloaded file name.)

3. Run the Installer
Run the installer with:
./pia-linux-3.6.2-08398.run

4. Verify the PIA Service
Check the name of the PIA service by running:
systemctl list-unit-files | grep pia
On my system, the service is named piavpn.service.

5. Enable the PIA Service on Boot
Enable the PIA service to start automatically at boot:
sudo systemctl enable --now piavpn.service
Note: Enabling this service may slightly increase boot time. The VPN service requires root privileges to run and must be active for the VPN to function.

6. (Optional) Auto-start the VPN Client on Hyprland Login
To automatically launch the PIA client frontend when logging into Hyprland:
Edit your Hyprland config:
vi $HOME/.config/hypr/hyprland.conf
Add the following line:
exec-once = sleep 1 && /opt/piavpn/bin/pia-client  # Autostart VPN client on login. Sleep 1 delays the start of the pia application until after the waybar is loaded. Without this the pia application may start before waybar and the waybar tray icon for pia will be missing.
