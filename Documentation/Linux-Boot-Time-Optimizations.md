# Linux Boot Time Optimization Guide for Fedora 42
This guide provides useful commands and tips to help reduce your Linux boot time on Fedora 42.

---

## Part 1: Key Commands to Analyze Boot Performance

### 1. Check Total Boot Time
```bash
systemd-analyze  
```

Displays the total time your system took to boot after the last startup.

### 2. Identify Slow Services
```bash
systemd-analyze blame  
```

Lists all services and processes sorted by how long they took during boot.  
This helps identify which services are slowing down your startup.

### 3. View Critical Boot Chain
```bash
systemd-analyze critical-chain  
```

Displays the most time-consuming services and their dependencies.  
Start by disabling unnecessary services shown here to improve boot speed.

---

## Part 2: Improving Boot Time

The main way to reduce boot time is to disable unnecessary services.

### Methods to Disable Services

1. Disable a service  
   Prevents the service from starting automatically at boot.  
   Other services can still start it if needed.

2. Disable and mask a service  
   Prevents the service from running at all and blocks other services from starting it.  
   Use masking carefully — masking critical services can cause system issues.

Note: Only disable or mask services if you understand their purpose and have tested your system afterward.

### Example: Disabling Unneeded Services
```bash
sudo systemctl disable remote-fs.target  
sudo systemctl disable remote-fs-pre.target  
sudo systemctl disable nfs-client.target  
```

After disabling, reboot and verify that everything still works correctly.

To check for failed services after boot:  
```bash
systemctl --failed
```

## Part 3: Reducing GRUB Menu Timeout

By default, GRUB waits a few seconds before booting. You can reduce this delay.

### 1. Edit the GRUB Configuration
```bash
sudo vi /etc/default/grub
```

### 2. Change the Timeout Value
```bash
Set GRUB_TIMEOUT to a lower number (for example, 3 seconds):  
GRUB_TIMEOUT=3
```

### 3. (Optional) Add Kernel Parameters
Example: Disable unused serial ports on Lenovo Legion systems:  
```bash
GRUB_CMDLINE_LINUX="quiet splash 8250.nr_uarts=0"
```

### 4. Regenerate the GRUB Configuration
```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

## Part 4: Disable Unnecessary Services at Boot
```bash
sudo systemctl disable bluetooth.service  
sudo systemctl disable ModemManager.service        # Only if no SIM card modem is used  
sudo systemctl disable iscsi-onboot.service iscsi-starter.service  # For network storage  
```

## Part 5: Other Useful Optimization Tips

### 1. Rebuild Initramfs with Only Necessary Drivers
```bash
sudo dracut --force --hostonly  
```

This reduces boot time by loading only the drivers required for your system hardware.

### 2. Remove the Splash Screen
```bash
sudo systemctl mask plymouth-quit.service plymouth-quit-wait.service plymouth-start.service  
```

Warning: Do NOT do this if you use full disk encryption with Plymouth, as it may cause boot issues.

### 3. Optimize Printing Services
```bash
sudo systemctl enable cups.socket  
sudo systemctl disable cups.service  
Enables on-demand printing using socket activation and disables the printing daemon from starting at boot.
```


---

## Part 6: Final Notes

- Always test your system after disabling or masking services.  
- Use systemd-analyze blame and systemd-analyze critical-chain regularly to monitor improvements.  
- Prefer disabling services instead of masking, unless you’re certain masking is safe.  
- Small, cautious adjustments can significantly reduce boot time without risking system stability.

For more details, see the official Red Hat documentation:  
https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/using_systemd_unit_files_to_customize_and_optimize_your_system/optimizing-systemd-to-shorten-the-boot-time_working-with-systemd
