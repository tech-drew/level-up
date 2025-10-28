# Level-Up

**Level-Up** is a customizable desktop environment built on **Fedora 42 KDE Plasma Desktop Edition**, featuring **Hyprland** as the dynamic window manager. It comes preconfigured with a curated set of tools and aesthetic customizations, including **Waybar**, **Alacritty**, **Fastfetch**, **Dolphin**, and more.

> Linux is about making your computer work for you.  
> This configuration is meant to be a starting point, not a final product. Feel free to try it out, tweak it, and make Level-Up your own.

---

## Project Status: Work in Progress

---

I started learning Linux in June 2024, and this project has been my hands-on way to deepen that knowledge while studying for the RHCSA. With no prior experience in GitHub, scripting, or programming, this project has been a fun experiment in learning outside my comfort zone. The project is constantly evolving as I learn new things, and I’m always open to feedback and suggestions!

---

## Project Screenshots

Below are some screenshots showcasing **Level-Up** in action:

![screenshot 1](project-screenshots/screenshot1.png)  
_An example of the main user interface._

![screenshot 2](project-screenshots/screenshot2.png)  
_The Fastfetch and Alacritty customizations in action._

![screenshot 3](project-screenshots/screenshot3.png)  
_A view of the Wofi application launcher on this system._

![screenshot 4](project-screenshots/screenshot4.png)  
_A layout with a few applications open in a tiled setup. Dolphin is using the Breeze Dark theme, configured through the KDE Settings.

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
**Note:** The install.sh script copies configuration files into the home directory of the user who runs it.
If you run the script with sudo or as root, those files will be placed in the root user’s home directory (/root) instead of your normal user’s profile.

To ensure the configuration is applied to your user account, run the "./install.sh" command as your regular user (without sudo):

---

## Compatibility & Disclaimer

For important system requirements, compatibility notes, and disclaimers, please see the [Compatibility and Disclaimer](documentation/compatibility-and-disclaimer.md).


---

## Documentation

Optional guides and resources are available in the [Documentation](documentation/) folder, including:

- [Acknowledgments](documentation/acknowledgments.md) – Credits for referenced open-source projects.
- [CHANGELOG](documentation/CHANGELOG.md) – Project version history and updates.
- [Fedora KDE Plasma SSH Setup](documentation/fedora-kde-plasma-ssh-setup.md) – Optional SSH configuration tips.
- [Github Private Repo Access Setup](documentation/github-private-repo-access-setup.md) – Optional setup guide for private repo access.
- [Linux Boot Time Optimizations](documentation/linux-boot-time-optimizations.md) – Tips for faster boot times.
- [Post-Install Resources](documentation/post-install-resources.md) – Optional tools, drivers, and tweaks.
- [VPN Private Internet Access Setup](documentation/vpn-private-internet-access-setup.md) – Optional VPN configuration guide.


## Licensing

---

**Level-Up** is licensed under the **Level-Up License**, which grants you the freedom to use, modify, and distribute the project. However, certain conditions must be met for redistribution and modification. Please refer to the full **Level-Up License** in the [Level-Up License.txt](level-up-license.txt) file for the complete terms.

This project also incorporates third-party software with their respective licenses. Please refer to the [LICENSES/](lICENSES/) directory for the licenses of third-party software used in this project.

For more details on the Level-Up License, please see the full [Level-Up License.txt](level-up-license.txt) file.

---

If you believe any licensing is missed or not properly acknowledged in this project, please reach out to me directly so I can update the licensing to remedy any issues. Your help in ensuring proper licensing is greatly appreciated.

---
