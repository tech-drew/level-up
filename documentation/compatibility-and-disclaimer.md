# Compatibility and Security Disclaimer

## Supported Systems

**Level-Up is officially supported only on a clean installation of Fedora 42 KDE Plasma Desktop Edition.**

**Recommended:**
- Fedora 42 KDE Plasma Desktop Edition (clean install only)

To create a reliable bootable USB, it is strongly recommended to use **Fedora Media Writer**. While other tools such as Rufus, Etcher, or UNetbootin may work in some cases, they can improperly write Fedora’s hybrid ISO format, potentially causing boot or installation failures. Fedora Media Writer is the officially supported tool and ensures proper image verification and compatibility.

**Virtual Machines:**  
Hyprland is not optimized for virtual machines and may not function correctly without direct access to a physical GPU. Virtualized graphics typically lack the performance and compatibility required by Wayland compositors like Hyprland. Although running Hyprland in a VM with GPU passthrough is technically possible, it is an advanced setup and not recommended for general use. For optimal performance, Level-Up should be installed on real hardware with direct GPU access.

This project uses Alacritty for terminal sessions within Hyprland. However, both Alacritty and Kitty have known compatibility issues when used in a Hyprland VM session. If you're running this project in a VM, you will need to use a different terminal emulator. Konsole is a known working option for VM environments.

---

## Security Disclaimer

All configurations and scripts included in Level-Up have been tested only on a clean installation of Fedora 42 KDE Plasma Desktop Edition. There is **no guarantee** that they will function correctly on existing systems or on installations missing required dependencies.

Level-Up and its included scripts are provided **as-is**, without support. By using this project, you accept full responsibility for any changes made to your system. Please carefully review all scripts and configuration files before applying them.

**Recommendations:**
- Back up important data before installation or making system changes.  
- Understand the modifications being applied to your system.  
- Use Level-Up at your own risk.
