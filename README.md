# Level-Up

**Level-Up** is a customizable desktop environment built on **Fedora 42 KDE Plasma Desktop Edition**, featuring **Hyprland** as the dynamic window manager. It comes preconfigured with a curated set of tools and aesthetic customizations, including **Waybar**, **Alacritty**, **Fastfetch**, **Dolphin**, and more.

> Linux is about making your computer work for you.  
> This configuration is meant to be a starting point, not a final product. Feel free to try it out, tweak it, and make Level-Up your own.

---

## Work in Progress

---

I'm still new to Linux and learning as I go. This setup is the result of tinkering, curiosity, and a desire to build something that feels right.  
Expect updates and improvements over time as I continue to explore and grow. Feedback and suggestions are always welcome.

---

## Install Instructions

---

If Git is not already installed, install it using the following command:

```bash
sudo dnf install git -y
```
Next, clone the repository and run the installation script:

```bash
git clone https://github.com/Always-Growing/Level-Up.git
cd Level-Up
chmod +x install.sh
./install.sh
```
---

## Compatibility Notice

---

**Level-Up is only supported on a clean installation of Fedora 42 KDE Plasma Desktop Edition.**

### Supported:
- Fedora 42 KDE Plasma Desktop Edition (clean install only)

**Note:** Hyprland is not optimized for use in virtual machines and may not function properly without direct access to a physical GPU. Virtual machines typically use virtualized graphics, which do not provide the same performance or compatibility required by Wayland compositors like Hyprland. While it may be possible to run Hyprland in a VM with GPU passthrough, this is an advanced configuration and is not recommended for general use. For optimal performance, this setup should only be installed on real hardware with direct access to a physical GPU.

---

## Post-Install Resources

---

After installing Level-Up, you may want to enhance your system with additional drivers, codecs, and tools. Below are some trusted resources to help you improve and personalize your Fedora + Hyprland setup:

---

These resources are optional but recommended if you want to get the most out of your Fedora + Hyprland environment.

---

- Hyprland Wiki  
  https://wiki.hypr.land/  
  The official Hyprland documentation. Highly recommended for learning about configuration options, environment variables, animation settings, and troubleshooting.

- NVIDIA Driver Installation Guide for Fedora  
  https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/#11-check-is-your-nvidia-card-supported  
  A well-maintained guide for installing proprietary NVIDIA drivers on Fedora. Use this if you're running an NVIDIA GPU and need reliable Wayland support.

- Fedora Noble Setup Guide (by wz790)  
  https://github.com/wz790/Fedora-Noble-Setup?tab=readme-ov-file#terra-repository-if-youre-feeling-adventurous  
  A community guide with post-install tips for Fedora users, including multimedia codecs, RPM Fusion setup, and other useful tweaks.

  Note: Some of the recommendations in the linked guide involve installing proprietary multimedia codecs (such as MP3, AAC, and H.264) that may be restricted by software patents in certain countries, including the United States. These steps are not included in this configuration by default. Please research the software laws in your region before installing third-party codecs.

These resources are optional but recommended if you want to get the most out of your Fedora + Hyprland environment.

---

## Security and Compatibility Disclaimer

---

All configurations and scripts in this project have been tested on a clean install of Fedora 42 Server.  

...

There are no guarantees that these configurations will work correctly on existing installations or on systems missing required dependencies.

This configuration and included scripts are provided as-is, without any support.  
By using Level-Up, you accept full responsibility for any changes made to your system.  
Please review all scripts and configurations carefully before applying them, and use at your own risk.

It is recommended to back up your data and understand the changes before proceeding.  
If you are unsure about any part of the setup, seek assistance or more information.

---

## Licensing

---

**Level-Up** is licensed under the **Level-Up License**, which grants you the freedom to use, modify, and distribute the project. However, certain conditions must be met for redistribution and modification. Please refer to the full **Level-Up License** in the [Level-Up License.txt](Level-Up%20License.txt) file for the complete terms.

This project also incorporates third-party software with their respective licenses. Please refer to the [LICENSES/](LICENSES/) directory for the licenses of third-party software used in this project.

For more details on the Level-Up License, please see the full [Level-Up License.txt](Level-Up%20License.txt) file.

---

If you believe any licensing is missed or not properly acknowledged in this project, please reach out to me directly so I can update the licensing to remedy any issues. Your help in ensuring proper licensing is greatly appreciated.

---

## Acknowledgments

---

Please give full credit to the original creators and maintainers of the tools, scripts, themes, and documentation referenced or recommended in this project. There are too many contributors across the various packages and resources used here for me to list them all individually, but I want to express sincere thanks to the entire open source community. Your hard work made this project possible.
