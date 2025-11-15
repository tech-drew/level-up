# Compatibility and Security Disclaimer

## Supported Systems

**Level-Up has only been tested to work on a clean installation of Fedora 42 KDE Plasma Desktop Edition.**

**Recommended:**
- Fedora 42 KDE Plasma Desktop Edition (clean install only)

**Note**
The `install.sh` script does not currently work on Fedora 43 KDE Plasma. During Section 2, the installation of the `hyprland-qtutils` package fails. This issue occurs because Fedora 43 uses different dependency versions than those provided by the Hyprland packages in the COPR repository [`solopasha/hyprland`](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/).

It is expected that the `solopasha/hyprland` repository will be updated to support Fedora 43 in the future. Until then, it is recommended to use Fedora 42 for full compatibility with this project.

As a temporary workaround, you may either:

* **Manually compile** the necessary packages for Fedora 43, or
* **Remove the `hyprland-qtutils` installation step** from Section 2 of `install.sh` (not recommended).

## Recommendations for creating a bootable Fedora usb.

To create a reliable bootable USB, it is strongly recommended to use Fedora Media Writer. While other tools such as Rufus, Etcher, or UNetbootin may work in some cases, they can improperly write Fedora’s hybrid ISO format, potentially causing boot or installation failures. Fedora Media Writer is the officially recommended tool and ensures proper image verification and compatibility.

**Virtual Machines:**  
Hyprland is not optimized for virtual machines and may not function correctly without direct access to a physical GPU. Virtualized graphics typically lack the performance and compatibility required by Wayland compositors like Hyprland. Although running Hyprland in a VM with GPU passthrough is technically possible, it is an advanced setup and not recommended for general use. For optimal performance, Level-Up should be installed on real hardware with direct GPU access.

This project uses Alacritty for terminal sessions within Hyprland. However, Alacritty has known compatibility issues when used in a Hyprland VM session. If you're running this project in a VM, you will need to use a different terminal emulator. Konsole is a known working option for VM environments.

The default keybinding to open a terminal in the hyprland.conf uses Alacritty you will need to change line 16 in the hyprland.conf from '$terminal = alacritty' to '$terminal = konsole'. This will work but fastfetch is not configured to start automatically using Konsole. Therefore the fastfetch settings would need to be adjusted as well. 

There may be other issues running this project within a virtual machine. The issues mentioned above are the ones I am aware of.

---

## Security Disclaimer

All configurations and scripts included in Level-Up have been tested only on a clean installation of Fedora 42 KDE Plasma Desktop Edition. There is **no guarantee** that they will function correctly on existing systems or on installations missing required dependencies.

Level-Up and its included scripts are provided **as-is**, without support. By using this project, you accept full responsibility for any changes made to your system. Please carefully review all scripts and configuration files before applying them.

**Recommendations:**
- Back up important data before installation or making system changes.  
- Understand the modifications being applied to your system.  
- Use Level-Up at your own risk.
