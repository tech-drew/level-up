Changelog
Last Updated: 2025-10-28 21:30 PST

Notes:
- All timestamps are in Pacific Standard Time (PST).
- Changes made before 2025-09-02 12:00 were grouped into the initial setup entry.
- Initial development began around July 2025.
- I'm new to GitHub, Linux, scripting and programming, so this changelog format may evolve as I learn.

------------------------------------------------------------

2025-10-28 22:30 - Created branches.md documentation for branch changes.

Added:

- branches.md documenation

Modified:

- updated README.md to include a link to the branches.md documentation

Removed:

- None

------------------------------------------------------------

2025-10-28 21:30 - Added Logging for Hyprland, Waybar, and Documentation Update

Added:

- Logging enabled for Hyprland: Configured verbose logging in hyprland.conf to capture detailed debug information.

- Logging enabled for Waybar: Configured Waybar’s built-in logging functionality to capture detailed logs with the highest verbosity for troubleshooting.

- logging-and-troubleshooting.md: Created a new documentation file explaining where to find logs for the installation process, hyprland.conf, and Waybar for easier debugging and troubleshooting.

Modified:

- Logging configuration: Updated install.sh, hyprland.conf, and waybar configurations to ensure logs are correctly captured for key system components.

Removed:

- None

------------------------------------------------------------

2025-10-28 21:00 - Move CHANGELOG.md to Root & Create Separate install.sh

Added:

- CHANGELOG.md moved to the root directory for better visibility and alignment with best practices.

- INSTALL.md created as a separate file the installation process.

Modified:

- CHANGELOG.md moved to the root directory for better visibility and alignment with best practices.

Removed:

- None

------------------------------------------------------------

2025-10-28 20:30 - Added logging, dry-run support, and security disclaimer to install.sh

Added:

- Logging of install.sh actions to $HOME/.local/share/level-up/level-up-install.log following best practices.

- Dry-run mode for install.sh using the --dry-run flag, allowing users to preview actions without making changes.

- Security disclaimer and explicit user confirmation before installation requiring sudo.

Modified:
- Level-Up/install.sh updated to support logging, dry-run mode, and security confirmation.

Removed:
-None

------------------------------------------------------------

2025-10-27 23:00 - Renamed all files and directories to lowercase to follow programming best practices and replaced spaces with hyphens in file and folder names.

Added:
- None

Modified:
- /Level-Up/ was renamed to /level-up/

Removed:
- None
  
------------------------------------------------------------

2025-10-27 19:30 - Adjusted the formatting of documentation to use consistent formatting.

Added:
- None

Modified:
- Level-Up/Fedora Kde Plasma SSH Setup.md
- Level-Up/Github Private Repo Access Setup.md
- Level-Up/Linux Boot Time Optimizations.md
- Level-Up/VPN Private Internet Access Setup.md

Removed:
- Fedora Server Install documentation
  
------------------------------------------------------------

2025-10-22 22:30 - Added a Project Screenshots folder with some example screenshots of the project

Added:
- Level-Up\Project Screenshots

Modified:
- None

Removed:
- None
------------------------------------------------------------

2025-10-22 12:30 - Renamed named branches to use Semantic Versioning for the naming.

Added:
- None

Modified:
- Renamed main branch to v1.0.0-alpha-fedora-server-deprecated
- Renamed fedora-kde-plasma-rebuild branch to v2.0.0-beta-fedora-kde
- Changed the main branch from v1.0.0-alpha-fedora-server-deprecated to v2.0.0-beta-fedora-kde

Removed:
- None
------------------------------------------------------------

2025-10-21 21:30 - Added the floating keybinding from main to this branch to enable floating on some windows. Added virtual machine manager to install.sh

Added:
- Keybinding to enable floating on windows
- virt-manager added to install.sh and a section was created to enable the correct service.

Modified:
- Level-Up/configs/hypr/hyprland.conf

Removed:
- None
------------------------------------------------------------

2025-10-21 21:00 - Fixed broken install.sh for Fedora KDE Plasma

Added:
- None

Modified:
- Level-Up/install.sh 

Removed:
- None
------------------------------------------------------------

2025-10-12 21:30 - Adjusted Waybar Widget Tray Background Color

Added:
- None

Modified:
- Level-Up/config/waybar/style.css changed the waybar tray background color to purple to match the waybar.

Removed:
- None

------------------------------------------------------------

2025-10-11 21:30 - Removed a bunch of stuff from install.sh not needed on Fedora KDE Plasma. 

Added:
- Level-Up/install.sh Pavucontrol was added back in to use with hyprland

Modified:
- Level-Up/install.sh removed a bunch of stuff from the installer that does not work with Fedora KDE Plasma

Removed:
- Level-Up/install.sh removed cabextract. Cabextract is needed for ms fonts but the rebuild is using the KDE Plasma fonts

------------------------------------------------------------

2025-10-05 21:30 - Removed a bunch of stuff from install.sh not needed on Fedora KDE Plasma

Added:
- None

Modified:
- Level-Up/install.sh

Removed:
- None

------------------------------------------------------------

2025-09-29 22:30 - Added a keybinding to enable floating on some windows

Added:
- None

Modified:
- Level-Up/install.sh

Removed:
- Pipewire configuration in install.sh. I believe it breaks installing this config ontop of Fedora KDE Plasma.

------------------------------------------------------------

2025-09-28 14:30 - Added a Licenses folder and created Licensing information for this project. The licensing information in this project is best effort. If anything is missing or incorrect please message me and I will work to fix the errors.

Added:
- Level-Up/Licenses
- Level-Up/Level-Up License.txt

Modified:
- Level-Up/README.md

Removed:
- None

------------------------------------------------------------

2025-09-19 23:00 - Updated install.sh to create user wofi directory and copy over the wofi configurations

Added:
- None

Modified:
- Level-Up/install.sh

Removed:
- None

------------------------------------------------------------

2025-09-19 22:30 - Updated Waybar and Power Menu.sh. Power menu now attached to waybar button.

Added:
- None

Modified:
- Level-Up/configs/waybar/config
- Level-Up/configs/waybar/style.css
- Level-Up/configs/waybar/scripts/power_menu.sh

Removed:
- None

------------------------------------------------------------

2025-09-18 22:00 - Added Wofi folder and style.css

Added:
- Wofi folder and wofi style.css

Modified:
- Added a keybinding for kate in Level-Up/configs/hypr/hyprland.conf 

Removed:
- None

------------------------------------------------------------

2025-09-17 23:00 - Main Branch - Modified README to fix technical inaccuracies and to add an explicit warning to only install this configuration on a fresh Fedora Server install. 

Added:
- None

Modified:
- Modified Level-Up/README.md to have a more clear and technically accurate reason for why you should avoid running this configuration in a virtual machine.
- Modified Level-Up/README.md to have an explicit warning do not install this on anything other than a fresh install of Fedora Server

Removed:
- None

------------------------------------------------------------

2025-09-16 22:30 - Main Branch - Modified Level-Up/configs/waybar/conf removing bad icons.

Added:
- None

Modified:
- Modified Level-Up/configs/waybar/config. Removed two bad icons. Changed sound percentage to remain while the device is muted.

Removed:
- None

------------------------------------------------------------

2025-09-16 22:00 - Main Branch - Added wayland-utils wl-clipboard to install.sh

Added:
- None

Modified:
- Modified install.sh to add wayland-utils wl-clipboard. This package is needed to save clip art when you select some of the screen top copy for screenshots.

Removed:
- None

------------------------------------------------------------

2025-09-16 07:00 - Main Branch - Modified install.sh to fix a typo

Added:
- None

Modified:
- Modified install.sh to add a missing backslash after the kde packages.

Removed:
- None

------------------------------------------------------------

2025-09-15 12:30 - Fixed inconsistent syntax in hyprland.conf

Added:
- None

Modified:
- hyprland.conf fixed inconsistent variable declarations.
- created a hyprlock.conf keybinding

Removed:
- None

------------------------------------------------------------

2025-09-14 23:30 - Main Branch - Added Documentation folder to repo

Added:
- Documentation/ folder containing VPN setup, GitHub SSH access, and boot optimization guides

Modified:
- None

Removed:
- None

------------------------------------------------------------

2025-09-14 23:00 - Test Branch - Merged hyprlock_test with hyprlock

Added:
- kde-cli-tools kde-runtime to install.sh fix Dolphin issues

Modified:
- install.sh 
- kde-cli-tools kde-runtime

Removed:
- None

------------------------------------------------------------

2025-09-14 21:00 - Test Branch - Worked on broken fonts install.sh.

Added:
- None

Modified:
- install.sh 
- hyprland.conf added hyprlock keybinding

Removed:
- None

------------------------------------------------------------

2025-09-14 15:00 - Test Branch - Enhanced install.sh with Pipewire audio setup and improved dolphin file associations

Added:
- Hyprlock
- Installed Pipewire packages (pipewire, pipewire-pulse, pipewire-alsa, wireplumber) during installation.

Modified:
- Added a check to see if xdg-mime is available before setting file associations.
- Added copying of hyprlock.conf along with hyprland.conf to the config directory.
- Improved messages and flow in install.sh.
- Added file associations for basic file types to dolphin
- Updated README.md to give a more accurate description of the project.

Removed:
- None

------------------------------------------------------------

2025-09-13 20:00 - Fixed install.sh hyprland.conf installation issue.

Added:
- None

Modified:
- Updated install.sh and hyprland.conf. The last update stopped the install.sh from correctly copying over the hyprland.conf to the new system.
- Updated README.md to indicate testing was done with Fedora 42 Server.

Removed:
- Removed some of LibreOffice files. The intention was to only install LibreOffice Writer.

------------------------------------------------------------

2025-09-13 17:00 - Merged feature/installed-apps into main

Added:
- Finalized install.sh script with improved app installation and setup.

Modified:
- CHANGELOG.md
- hyprland.conf
- power_menu.sh
- install.sh

Removed:
- None

Note:
- Deleted feature/installed-apps branch after successful merge.

------------------------------------------------------------

2025-09-13 13:30 - Install Script Fixes and Improvements 

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

2025-09-13 12:00 - Added missing software to the installation

Added:
- Installed Firefox, GNOME Calendar, Galculator, GIMP, Virt-Manager, NetworkManager Connection Editor, LibreOffice, and Microsoft Fonts in install.sh.

Modified:
- Updated install.sh to group all package installations together for better readability.
- Improved install completion messages for clarity.

Removed:
- None

------------------------------------------------------------

2025-09-02 20:30 - Power Menu Integration 

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

2025-09-02 12:00 - Fedora 42 Hyprland Setup

Added:
- Installed Hyprland using the COPR repository.
- Installed core applications: Alacritty, Fastfetch, Waybar, etc.
- Added configuration files for Alacritty, Fastfetch, Waybar, and Hyprland.
- Set up a custom bash prompt in .bashrc.
- Added default wallpaper and created required directories.

Modified:
- None

------------------------------------------------------------

- Initial development began around July 2025.

Removed:
- None
