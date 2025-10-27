
# Setting Up SSH on Fedora KDE Plasma
# ============================================================
# These steps install, enable, and configure the SSH server
# so you can connect securely to your Fedora system.
# ============================================================

# 1. Install the OpenSSH server package
```bash
sudo dnf install openssh-server
```

# (This installs the sshd service that allows remote connections.)

# 2. Enable the SSH service to start automatically at boot
```bash
sudo systemctl enable sshd
```

# 3. Start the SSH service immediately
```bash
sudo systemctl start sshd
```

# 4. Verify that the SSH service is running
```bash
sudo systemctl status sshd
```
# (You should see "active (running)". Press q to exit.)

# 5. Allow SSH through the firewall
```bash
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
```
# (The --permanent flag makes the rule persistent, and --reload applies it.)

# 6. Confirm the firewall settings
```bash
sudo firewall-cmd --list-all
```

# (Check that "ssh" appears under the services list.)

# ============================================================
# Your Fedora system is now ready to accept SSH connections.
# Test it from another device using:
#   ssh username@your-fedora-ip
#
# Replace "username" with your Fedora account name and
# "your-fedora-ip" with the system's IP address.
# (Find it with: ip a)
# ============================================================
