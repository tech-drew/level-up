Changelog
Last Updated: 2025-09-13 12:00 PST

Note: All timestamps are in Pacific Standard Time (PST).
Note: Changes made before 2025-09-02 12:00 were grouped into the initial setup entry.
I'm still learning GitHub and programming, so this changelog is evolving as I go.


------------------------------------------------------------

2025-09-13 13:30 - Install Script Fixes and Improvements (v1.0.2)

Added:
- Added Microsoft Core Fonts installation using tar.gz method instead of broken RPM.
- Added fallback check to skip power_menu.sh setup if the script is missing.
- Added logic to rebuild font cache after installing Microsoft Fonts.

Modified:
- Replaced RPM-based Microsoft Fonts install with a reliable tar.gz-based method.
- Fixed .bashrc prompt customization to prevent grep warnings and ensure correct escaping.
- Improved output messages for clarity during installation.
- Ensured config directories and wallpaper paths are handled more robustly.

Removed:
- Removed broken msttcore-fonts-installer RPM installation method.

------------------------------------------------------------
2025-09-13 12:00 Added missing software to the installation

Added:
- Installed Firefox, GNOME Calendar, Galculator, GIMP, Virt-Manager, NetworkManager Connection Editor, LibreOffice, and Microsoft Fonts in install.sh.

Modified:
- Updated install.sh to group all package installations together for better readability.
- Improved install completion messages for clarity.

Removed:
- None

------------------------------------------------------------

2025-09-02 20:30 - Power Menu Integration (v1.0.1)

Added:
- Installed wofi as a dependency for the power menu.
- Added power_menu.sh to ~/.config/hypr/waybar/scripts/
- Made power_menu.sh executable.
- Created a Changelog to track changes
- Added Post Install Resources to the README.md
- Added Security and Compatibility Disclaimer to the README.md
- Added Acknowledgments to the README.md

Modified:
- Updated install.sh to include power menu setup steps.

Removed:
- None

------------------------------------------------------------

2025-09-02 12:00 - Initial Fedora 42 Hyprland Setup (v1.0.0)

Added:
- Installed Hyprland using the COPR repository.
- Installed core applications: Alacritty, Fastfetch, Waybar, etc.
- Added configuration files for Alacritty, Fastfetch, Waybar, and Hyprland.
- Set up a custom bash prompt in .bashrc.
- Added default wallpaper and created required directories.

Modified:
- None

Removed:
- None
