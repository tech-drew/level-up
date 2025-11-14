# Changelog
## Last Updated: 2025-11-12 07:00 PST

### Notes:
- All timestamps are in Pacific Standard Time (PST).
- Changes made before 2025-09-02 12:00 were grouped into the initial setup entry.
- Initial development began around July 2025.
- I'm new to GitHub, Linux, scripting and programming, so this changelog format may evolve as I learn.


## 2025-11-12 07:00 - Updated logging and level-up-icon-theme 

### Added:

- level-up/documentation/post-install-resources added the Arch wiki as a resource.

### Changed:

- Updated level-up/configs/hyprland.conf with better logging support and added two environmental variables to help with theme import (dbus, systemctl line). Additionally a comment was left on hyprland-qtutils line as it prevents the installer from successfully completing on Fedora 43
- Updated level-up/documentation/logging-locations-and-troubleshooting with more details regarding hyprland logs
- Updated level-up/documentation/compatibility-and-security-disclaimer with notes on why this project is not compatible with Fedora 43 and added some information on a known issue with using Alacritty within a virtual machines.

### Removed:

- level-up/documentation/post-install-resources Removed the Noble resource as it is not needed now that the project is on Fedora 42 KDE Plasma


## 2025-11-11 12:00 - Updated logging and level-up-icon-theme 

### Added:

- level-up/themes/.gitkeep

### Changed:

- updated README.md to fix typos
- updated level-up/scripts/logging.sh to be consistent with log formatting in the install.sh
- updated level-up/documentation/lessons-learned.md to fix typos
- updated level-up/themes/level-up-icon-theme to fix errors and improve hyprland compatibility


## 2025-11-10 00:00 - Updated documentation 

### Added:

- level-up/scripts/logging.sh
- level-up/themes/level-up-icon-theme.tar.gz
- level-up/themes/level-up-icon-theme-old-backup.tar.gz
- level-up/licenses/level-up-icon-theme.txt

### Changed:

- updated README.md to include a note about the level-up-icon-theme licensing.
- level-up/scripts/launch-hyprland-with-logging adjusted to include a more robust logging solution
- level-up/scripts/launch-waybar-with-logging adjusted to include a more robust logging solution
- level-up/install.sh adjusted to include a more robust logging solution, Section 11 Install Level-Up Icon Theme, Echo Output for each section


## 2025-11-05 22:00 - Updated documentation 

### Changed:

- updated README.md for consistent writting.
- updated level-up/documentation/compatibility-and-security-disclaimer for consistent writting.
- updated level-up/documentation/lessons-learned.md with updated future plans
- updated level-up/documentation/branches added a new issue to v2.2.0-beta-fedora-kde-hyprland-and-waybar-with-logging


## 2025-11-02 22:30 - Updated documentation and fixed launch-hyprland-wth-logging.sh

### Added:

- level-up/scripts
- level-up/scripts/launch-hyprland-wth-logging.sh
- level-up/scripts/launch-waybar-wth-logging.sh

### Changed:

- updated level-up/README.md to fix a broken CHANGEME.ms
- updated level-up/install.sh to create level-up.desktop which is used as an SDDM login option to start the project with logging.
- updated level-up/documentation/logging-locations-and-troubleshooting.md to include newly created logs
- updated level-up/documentation/lessons-learned.md with updated future plans
- updated level-up/documentation/awknowledgements.md to fix broken links


## 2025-10-28 22:30 - Created branches.md documentation for branch changes.

### Added:

- branches.md documenation

### Changed:

- updated README.md to include a link to the branches.md documentation


## 2025-10-28 21:30 - Added Logging for Hyprland, Waybar, and Documentation Update

### Added:

- Logging enabled for Hyprland: Configured verbose logging in hyprland.conf to capture detailed debug information.

- Logging enabled for Waybar: Configured Waybar’s built-in logging functionality to capture detailed logs with the highest verbosity for troubleshooting.

- logging-and-troubleshooting.md: Created a new documentation file explaining where to find logs for the installation process, hyprland.conf, and Waybar for easier debugging and troubleshooting.

### Changed:

- Logging configuration: Updated install.sh, hyprland.conf, and waybar configurations to ensure logs are correctly captured for key system components.



## 2025-10-28 21:00 - Move CHANGELOG.md to Root & Create Separate install.sh

### Added:

- CHANGELOG.md moved to the root directory for better visibility and alignment with best practices.

- INSTALL.md created as a separate file the installation process.

### Changed:

- CHANGELOG.md moved to the root directory for better visibility and alignment with best practices.



## 2025-10-28 20:30 - Added logging, dry-run support, and security disclaimer to install.sh

### Added:

- Logging of install.sh actions to $HOME/.local/share/level-up/level-up-install.log following best practices.

- Dry-run mode for install.sh using the --dry-run flag, allowing users to preview actions without making changes.

- Security disclaimer and explicit user confirmation before installation requiring sudo.

### Changed:
- Level-Up/install.sh updated to support logging, dry-run mode, and security confirmation.


## 2025-10-27 23:00 - Renamed all files and directories to lowercase to follow programming best practices and replaced spaces with hyphens in file and folder names.

### Changed:
- /Level-Up/ was renamed to /level-up/


## 2025-10-27 19:30 - Adjusted the formatting of documentation to use consistent formatting.

### Changed:
- Level-Up/Fedora Kde Plasma SSH Setup.md
- Level-Up/Github Private Repo Access Setup.md
- Level-Up/Linux Boot Time Optimizations.md
- Level-Up/VPN Private Internet Access Setup.md

### Removed:
- Fedora Server Install documentation
  

## 2025-10-22 22:30 - Added a Project Screenshots folder with some example screenshots of the project

### Added:
- Level-Up\Project Screenshots


## 2025-10-22 12:30 - Renamed named branches to use Semantic Versioning for the naming.

### Changed:
- Renamed main branch to v1.0.0-alpha-fedora-server-deprecated
- Renamed fedora-kde-plasma-rebuild branch to v2.0.0-beta-fedora-kde
- Changed the main branch from v1.0.0-alpha-fedora-server-deprecated to v2.0.0-beta-fedora-kde


## 2025-10-21 21:30 - Added the floating keybinding from main to this branch to enable floating on some windows. Added virtual machine manager to install.sh

### Added:
- Keybinding to enable floating on windows
- virt-manager added to install.sh and a section was created to enable the correct service.

### Changed:
- Level-Up/configs/hypr/hyprland.conf


## 2025-10-21 21:00 - Fixed broken install.sh for Fedora KDE Plasma

### Changed:
- Level-Up/install.sh 


## 2025-10-12 21:30 - Adjusted Waybar Widget Tray Background Color

### Changed:
- Level-Up/config/waybar/style.css changed the waybar tray background color to purple to match the waybar.


## 2025-10-11 21:30 - Removed a bunch of stuff from install.sh not needed on Fedora KDE Plasma. 

### Added:
- Level-Up/install.sh Pavucontrol was added back in to use with hyprland

### Changed:
- Level-Up/install.sh removed a bunch of stuff from the installer that does not work with Fedora KDE Plasma

### Removed:
- Level-Up/install.sh removed cabextract. Cabextract is needed for ms fonts but the rebuild is using the KDE Plasma fonts


## 2025-10-05 21:30 - Removed a bunch of stuff from install.sh not needed on Fedora KDE Plasma

### Changed:
- Level-Up/install.sh


## 2025-09-29 22:30 - Added a keybinding to enable floating on some windows

### Changed:
- Level-Up/install.sh

### Removed:
- Pipewire configuration in install.sh. I believe it breaks installing this config ontop of Fedora KDE Plasma.


## 2025-09-28 14:30 - Added a Licenses folder and created Licensing information for this project. The licensing information in this project is best effort. If anything is missing or incorrect please message me and I will work to fix the errors.

### Added:
- Level-Up/Licenses
- Level-Up/Level-Up License.txt

### Changed:
- Level-Up/README.md
  

## 2025-09-19 23:00 - Updated install.sh to create user wofi directory and copy over the wofi configurations

### Changed:
- Level-Up/install.sh
  

## 2025-09-19 22:30 - Updated Waybar and Power Menu.sh. Power menu now attached to waybar button.

### Changed:
- Level-Up/configs/waybar/config
- Level-Up/configs/waybar/style.css
- Level-Up/configs/waybar/scripts/power_menu.sh
  

## 2025-09-18 22:00 - Added Wofi folder and style.css

### Added:
- Wofi folder and wofi style.css

### Changed:
- Added a keybinding for kate in Level-Up/configs/hypr/hyprland.conf
  

## 2025-09-17 23:00 - Main Branch - Modified README to fix technical inaccuracies and to add an explicit warning to only install this configuration on a fresh Fedora Server install. 

### Changed:
- Modified Level-Up/README.md to have a more clear and technically accurate reason for why you should avoid running this configuration in a virtual machine.
- Modified Level-Up/README.md to have an explicit warning do not install this on anything other than a fresh install of Fedora Server
  

## 2025-09-16 22:30 - Main Branch - Modified Level-Up/configs/waybar/conf removing bad icons.

### Changed:
- Modified Level-Up/configs/waybar/config. Removed two bad icons. Changed sound percentage to remain while the device is muted.


## 2025-09-16 22:00 - Main Branch - Added wayland-utils wl-clipboard to install.sh

### Changed:
- Modified install.sh to add wayland-utils wl-clipboard. This package is needed to save clip art when you select some of the screen top copy for screenshots.


## 2025-09-16 07:00 - Main Branch - Modified install.sh to fix a typo

### Changed:
- Modified install.sh to add a missing backslash after the kde packages.


## 2025-09-15 12:30 - Fixed inconsistent syntax in hyprland.conf

### Changed:
- hyprland.conf fixed inconsistent variable declarations.
- created a hyprlock.conf keybinding


## 2025-09-14 23:30 - Main Branch - Added Documentation folder to repo

### Added:
- Documentation/ folder containing VPN setup, GitHub SSH access, and boot optimization guides
  

## 2025-09-14 23:00 - Test Branch - Merged hyprlock_test with hyprlock

### Added:
- kde-cli-tools kde-runtime to install.sh fix Dolphin issues
  
### Changed:
- install.sh 
- kde-cli-tools kde-runtime


## 2025-09-14 21:00 - Test Branch - Worked on broken fonts install.sh.

### Changed:
- install.sh 
- hyprland.conf added hyprlock keybinding


## 2025-09-14 15:00 - Test Branch - Enhanced install.sh with Pipewire audio setup and improved dolphin file associations

### Added:
- Hyprlock
- Installed Pipewire packages (pipewire, pipewire-pulse, pipewire-alsa, wireplumber) during installation.

### Changed:
- Added a check to see if xdg-mime is available before setting file associations.
- Added copying of hyprlock.conf along with hyprland.conf to the config directory.
- Improved messages and flow in install.sh.
- Added file associations for basic file types to dolphin
- Updated README.md to give a more accurate description of the project.


## 2025-09-13 20:00 - Fixed install.sh hyprland.conf installation issue.

### Changed:
- Updated install.sh and hyprland.conf. The last update stopped the install.sh from correctly copying over the hyprland.conf to the new system.
- Updated README.md to indicate testing was done with Fedora 42 Server.

### Removed:
- Removed some of LibreOffice files. The intention was to only install LibreOffice Writer.


## 2025-09-13 17:00 - Merged feature/installed-apps into main

### Added:
- Finalized install.sh script with improved app installation and setup.

### Changed:
- CHANGELOG.md
- hyprland.conf
- power_menu.sh
- install.sh

### Removed:
- Deleted feature/installed-apps branch after successful merge.


## 2025-09-13 13:30 - Install Script Fixes and Improvements 

### Added:
- Added Microsoft Core Fonts installation using tar.gz method instead of broken RPM.
- Added fallback check to skip power_menu.sh setup if the script is missing.
- Added logic to rebuild font cache after installing Microsoft Fonts.

### Changed:
- Replaced RPM-based Microsoft Fonts install with a reliable tar.gz-based method.
- Fixed .bashrc prompt customization to prevent grep warnings and ensure correct escaping.
- Improved output messages for clarity during installation.
- Ensured config directories and wallpaper paths are handled more robustly.

### Removed:
- Removed broken msttcore-fonts-installer RPM installation method.


## 2025-09-13 12:00 - Added missing software to the installation

### Added:
- Installed Firefox, GNOME Calendar, Galculator, GIMP, Virt-Manager, NetworkManager Connection Editor, LibreOffice, and Microsoft Fonts in install.sh.

### Changed:
- Updated install.sh to group all package installations together for better readability.
- Improved install completion messages for clarity.
- 


## 2025-09-02 20:30 - Power Menu Integration 

### Added:
- Installed wofi as a dependency for the power menu.
- Added power_menu.sh to ~/.config/hypr/waybar/scripts/
- Made power_menu.sh executable.
- Created a Changelog to track changes
- Added Post Install Resources to the README.md
- Added Security and Compatibility Disclaimer to the README.md
- Added Acknowledgments to the README.md

### Changed:
- Updated install.sh to include power menu setup steps.


## 2025-09-02 12:00 - Fedora 42 Hyprland Setup

### Added:
- Installed Hyprland using the COPR repository.
- Installed core applications: Alacritty, Fastfetch, Waybar, etc.
- Added configuration files for Alacritty, Fastfetch, Waybar, and Hyprland.
- Set up a custom bash prompt in .bashrc.
- Added default wallpaper and created required directories.

## Initial development began around July 2025.
