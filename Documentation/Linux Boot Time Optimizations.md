Linux Boot Time Optimization Guide for Fedora 42

This guide provides useful commands and tips to help reduce your Linux boot time on Fedora 42.

Key Commands to Analyze Boot Performance:

- systemd-analyze
  Shows the total boot time of your system after the last startup.

- systemd-analyze blame
  Lists all services and processes sorted by how long they took during boot.
  Useful to identify what is slowing down your boot.

- systemd-analyze critical-chain
  Displays the most time-consuming services and their dependencies.
  Start by disabling unnecessary services shown here to improve boot speed.

How to Improve Boot Time:

The main way to speed up boot is to disable unnecessary services.

Two methods to disable services:

1. Disable a service:
   Prevents the service from starting automatically at boot.
   Other services can still start it if needed.

2. Disable and mask a service:
   Prevents the service from running at all and blocks other services from starting it.
   Use masking carefully; it can cause system issues.

Note: Only disable or mask services if you understand their purpose and have tested your system afterward.

Example: Disabling Unneeded Services

sudo systemctl disable remote-fs.target
sudo systemctl disable remote-fs-pre.target
sudo systemctl disable nfs-client.target

After disabling, reboot and verify that everything works correctly.

To check for failed services after boot:

systemctl --failed

Reducing GRUB Menu Timeout:

By default, GRUB waits a few seconds before booting. You can reduce this:

1. Edit GRUB config:

   sudo vi /etc/default/grub

2. Change the timeout (set GRUB_TIMEOUT to a lower number):

   GRUB_TIMEOUT=3

3. (Optional) Add kernel parameters for hardware tweaks (example disables serial ports on Lenovo Legion):

   GRUB_CMDLINE_LINUX="quiet splash 8250.nr_uarts=0"

4. Save and regenerate GRUB config:

   sudo grub2-mkconfig -o /boot/grub2/grub.cfg

Disable Unnecessary Services at Boot:

sudo systemctl disable bluetooth.service
sudo systemctl disable ModemManager.service        # Only if no SIM card modem is used
sudo systemctl disable iscsi-onboot.service iscsi-starter.service  # For network storage

Other Useful Tips:

- Rebuild initramfs with only necessary drivers to reduce boot time:

  sudo dracut --force --hostonly

- Remove the splash screen (Fedora logo during boot):

  WARNING: Do NOT do this if using full disk encryption with Plymouth, as it may cause boot issues.

  sudo systemctl mask plymouth-quit.service plymouth-quit-wait.service plymouth-start.service

- Optimize printing services by enabling socket activation and disabling the daemon at boot:

  sudo systemctl enable cups.socket
  sudo systemctl disable cups.service

Final Notes:

- Always test your system after disabling services or making changes.
- Use systemd-analyze blame and systemd-analyze critical-chain regularly to monitor boot times.
- Mask services only if you understand the risks; prefer disabling over masking.

For more details, see:
https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/using_systemd_unit_files_to_customize_and_optimize_your_system/optimizing-systemd-to-shorten-the-boot-time_working-with-systemd
