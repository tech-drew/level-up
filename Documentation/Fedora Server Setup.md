Basic Installation Guide for Fedora Server

1. Create a bootable Fedora Server ISO using Fedora Media Writer
   Warning: Do NOT use Rufus or other tools—Fedora does NOT work well with them.
   It is recommended to use Fedora Media Writer to create a Fedora bootable USB.

2. During installation, select the Fedora Server Edition.

3. Select the following software options:
   - Container Management
   - Headless Management

4. Connect to the network via Ethernet or Wi-Fi.

5. Note: The root account is disabled by default.

6. Create a user with administrative (sudo) privileges.

7. Complete the installation.

8. Install Simple Calendar for easy integration with Waybar:
   sudo dnf install gsimplecal

