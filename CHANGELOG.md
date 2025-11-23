# Changelog
## Last Updated: 2025-11-23 14:00 PST

### Notes:
- All timestamps are in Pacific Standard Time (PST).
- Changes made before 2025-09-02 12:00 were grouped into the initial setup entry.
- Initial development began around July 2025. Early changes from the first couple of months were not consistently documented, as the project was not yet being actively tracked.
- I'm new to GitHub, Linux, scripting and programming, so this changelog format may evolve as I learn.

## 2025-11-23 14:00 - Merged v2.0.0-beta-fedora-kde and v2.1.0-fedora-kde-installer-logs into the main branch, preserving history.

### Added:
- `level-up/install.sh` btop was added to the installed packages
- Added a btop keybinding `$mainmod + ESC` to `level-up/configs/hypr/hyprland.conf`

### Removed:
- Deprecated `v2.0.0-beta-fedora-kde` and `v2.1.0-fedora-kde-installer-logs` branches. The deprecated branches were removed after successful integration into `v2.2.0-fedora-kde-hyprland-and-waybar-logs`.

### Added:
- Added `level-up/docs/keybindings` as a resource.

## 2025-11-17 19:00 - Created Keybindings documentation. Updated level-up-icon-theme.tar.gz

### Added:
- Added `level-up/docs/keybindings` as a resource.

### Changed:
- Updated `level-up/themes/level-up-icon-theme` to contain the correct folder structure


## 2025-11-14 23:30 - Updated CHANGELOG.md formatting and Project Screenshots

### Changed:
- Renamed `level-up/documentation` folder to `level-up/docs` to match best practices


## 2025-11-14 13:30 - Updated CHANGELOG.md formatting and Project Screenshots

### Changed:
- Updated `level-up/CHANGELOG.md` with updated formatting to match best practices
- Updated `level-up/install.sh` to use the `level-up/wallpapers/level-up.png`
- Updated `level-up/configs/hypr/hyprland.conf` exec-once swww line to use the `level-up/wallpapers/level-up.png` wallpaper.
- Updated `level-up/configs/hypr/hyprlock.conf` to use the `level-up/wallpapers/level-up.png` wallpaper.
- Updated `level-up/project-screenshots/screenshot1.png` to use the `level-up/wallpapers/level-up.png` wallpaper
- Updated `level-up/project-screenshots/screenshot3.png` to use the `level-up/wallpapers/level-up.png` wallpaper.
- Updated `level-up/project-screenshots/screenshot4.png` to use the `level-up-icon-theme`. 

### Removed
- `level-up/wallpapers/end_4HyprlandWallpaper.png`

## 2025-11-12 07:00 - Updated logging and level-up-icon-theme 

### Added:
- Added the Arch wiki to `level-up/documentation/post-install-resources` as a resource.

### Changed:
- Updated `level-up/configs/hyprland.conf` with better logging support and added two environmental variables to help with theme import (dbus, systemctl line). Additionally a comment was left on hyprland-qtutils line as it prevents the installer from successfully completing on Fedora 43
- Updated `level-up/documentation/logging-locations-and-troubleshooting` with more details regarding hyprland logs
- Updated `level-up/documentation/compatibility-and-security-disclaimer` with notes on why this project is not compatible with Fedora 43 and added some information on a known issue with using `Alacritty` within a virtual machines.

### Removed:
- Removed the Noble resource  from the `level-up/documentation/post-install-resources` as it is not needed now that the project is on Fedora 42 KDE Plasma


## 2025-11-11 12:00 - Updated logging and level-up-icon-theme 

### Added:
- level-up/themes/.gitkeep

### Changed:
- Updated `level-up/README.md` to fix typos
- Updated `level-up/scripts/logging.sh` to be consistent with log formatting in the install.sh
- Updated `level-up/documentation/lessons-learned.md` to fix typos
- Updated `level-up/themes/level-up-icon-theme` to fix errors and improve hyprland compatibility


## 2025-11-10 00:00 - Updated documentation 

### Added:
- `level-up/scripts/logging.sh`
- `level-up/themes/level-up-icon-theme.tar.gz`
- `level-up/themes/level-up-icon-theme-old-backup.tar.gz`
- `level-up/licenses/level-up-icon-theme.txt`

### Changed:
- Updated `level-up/README.md` to include a note about the `level-up-icon-theme` licensing.
- Adjusted `level-up/scripts/launch-hyprland-with-logging` to include a more robust logging solution
- Adjusted `level-up/scripts/launch-waybar-with-logging` to include a more robust logging solution
- Adjusted `level-up/install.sh` to include a more robust logging solution, Section 11 Install Level-Up Icon Theme, Echo Output for each section


## 2025-11-05 22:00 - Updated documentation 

### Changed:
- updated `level-up/README.md` for consistent writting.
- updated `level-up/documentation/compatibility-and-security-disclaimer` for consistent writting.
- updated `level-up/documentation/lessons-learned.md` with updated future plans
- updated `level-up/documentation/branches.md` added a new issue to `v2.2.0-beta-fedora-kde-hyprland-and-waybar-with-logging`


## 2025-11-02 22:30 - Updated documentation and fixed launch-hyprland-wth-logging.sh

### Added:
- `level-up/scripts`
- `level-up/scripts/launch-hyprland-wth-logging.sh`
- `level-up/scripts/launch-waybar-wth-logging.sh`

### Changed:
- updated `level-up/README.md` to fix a broken link
- updated `level-up/install.sh` to create `level-up.desktop` which is used as an SDDM login option to start the project with logging.
- updated `level-up/documentation/logging-locations-and-troubleshooting.md` with updated logging informatino.
- updated `level-up/documentation/lessons-learned.md` with updated future plans
- updated `level-up/documentation/awknowledgements.md` to fix broken links


## 2025-10-28 22:30 - Created branches.md documentation for branch changes.

### Added:
- Created `level-up/documentation/branches.md`

### Changed:
- updated `level-up/README.md` to include a link to the `level-up/documentation/branches.md`. 


## 2025-10-28 21:30 - Added Logging for Hyprland, Waybar, and Documentation Update

### Added:
- Logging enabled for Hyprland: Configured logging in `level-up/hypr/hyprland.conf` to capture detailed logs.
- Logging enabled for Waybar: Configured Waybar’s built-in logging functionality to capture logs.
- Created `level-up/documentation/logging-and-troubleshooting.md`: for explaining where to find logs for the installation process, hyprland.conf, and waybar for easier debugging and troubleshooting.

### Changed:
- Logging configuration: Updated `level-up/install.sh` , `levelup/configs/hypr/hyprland.conf`, and `level-up/configs/waybar/waybar.conf` to ensure logs are correctly captured for key system components.


## 2025-10-28 21:00 - Move CHANGELOG.md to Root & Create Separate install.sh

### Added:
- Created `level-up/INSTALL.md` as a separate file the installation process.

### Changed:
- `level-up/documentation/CHANGELOG.md` moved to `level-up/CHANGELOG.md`  for better visibility and alignment with best practices.


## 2025-10-28 20:30 - Added logging, dry-run support, and security disclaimer to install.sh

### Added:
- Added logging of `level-up/install.sh` actions to `$HOME/.local/share/level-up/level-up-install.log` following best practices.
- Added Dry-run mode for `level-up/install.sh` using the --dry-run flag, allowing users to preview actions without making changes.
- Added Security Disclaimer and explicit user confirmation before installation requiring sudo to `level-up/install.sh`.

### Changed:
- Updated `level-up/install.sh` to support logging, dry-run mode, and security confirmation.


## 2025-10-27 23:00 - Renamed all files and directories to lowercase to follow programming best practices and replaced spaces with hyphens in file and folder names.

### Changed:
- `/Level-Up/` was renamed to `/level-up/`


## 2025-10-27 19:30 - Adjusted the formatting of documentation to use consistent formatting.

### Changed:
- `level-Up/fedora-kde-plasma-ssh-Setup.md`
- `level-up/github-private-repo-access-setup.md`
- `level-up/linux-boot-time-ptimizations.md`
- `level-up/vpn-private-internet-access-setup.md`

### Removed:
- Fedora Server Install documentation
  

## 2025-10-22 22:30 - Added a Project Screenshots folder with some example screenshots of the project

### Added:
- `level-up\project-screenshots`


## 2025-10-22 12:30 - Renamed named branches to use Semantic Versioning for the naming.

### Changed:
- Renamed main branch to `v1.0.0-alpha-fedora-server-deprecated`
- Renamed `fedora-kde-plasma-rebuild branch` to `v2.0.0-beta-fedora-kde`
- Changed the main branch from `v1.0.0-alpha-fedora-server-deprecated` to `v2.0.0-beta-fedora-kde`


## 2025-10-21 21:30 - Added the floating keybinding from main to this branch to enable floating on some windows. Added virtual machine manager to install.sh

### Added:
- Keybinding to `level-up/configs/hypr/hyprland.conf` to enable floating on windows
- Added virt-manager package to `level-up/install.sh`
- Added virt-manager section to `level-up/install.sh` to enable the correct service.

### Changed:
- `level-up/configs/hypr/hyprland.conf`


## 2025-10-21 21:00 - Fixed broken install.sh for Fedora KDE Plasma

### Changed:
- `level-up/install.sh`


## 2025-10-12 21:30 - Adjusted Waybar Widget Tray Background Color

### Changed:
- Changed the waybar tray backgrounbd color to purple to match the waybar in`level-up/config/waybar/style.css`.


## 2025-10-11 21:30 - Removed a bunch of stuff from install.sh not needed on Fedora KDE Plasma. 

### Added:
- The Pavucontrol package was added back in to `level-up/install.sh` to use with hyprland

### Changed:
- Removed a bunch of stuff from `level-up/install.sh` that does not work with Fedora KDE Plasma

### Removed:
- Removed cabextract package from `level-up/install.sh`. Cabextract is needed for ms fonts but the rebuild is using the KDE Plasma fonts


## 2025-10-05 21:30 - Removed a bunch of stuff from install.sh not needed on Fedora KDE Plasma

### Changed:
- `level-up/install.sh`


## 2025-09-29 22:30 - Added a keybinding to enable floating on some windows

### Changed:
- `level-up/install.sh`

### Removed:
- Pipewire configuration in `level-up/install.sh`. I believe it breaks installing this config ontop of Fedora KDE Plasma.


## 2025-09-28 14:30 - Added a Licenses folder and created Licensing information for this project. The licensing information in this project is best effort. If anything is missing or incorrect please message me and I will work to fix the errors.

### Added:
- `level-Up/licenses` folder
- `level-up/level-up-license.txt`

### Changed:
- `level-up/README.md`
  

## 2025-09-19 23:00 - Updated install.sh to create user wofi directory and copy over the wofi configurations

### Changed:
- `level-up/install.sh`
  

## 2025-09-19 22:30 - Updated Waybar and Power Menu.sh. Power menu now attached to waybar button.

### Changed:
- `level-up/configs/waybar/config`
- `level-up/configs/waybar/style.css`
- `level-up/configs/waybar/scripts/power_menu.sh`
  

## 2025-09-18 22:00 - Added Wofi folder and style.css

### Added:
- `level-up/configs/wofi`
- `level-up/configs/wofi/style.css`

### Changed:
- Added a keybinding for kate in `level-up/configs/hypr/hyprland.conf`
  

## 2025-09-17 23:00 - Main Branch - Modified README to fix technical inaccuracies and to add an explicit warning to only install this configuration on a fresh Fedora Server install. 

### Changed:
- Modified `level-up/README.md` to have a more clear and technically accurate reason for why you should avoid running this configuration in a virtual machine.
- Modified `level-up/README.md` to have an explicit warning do not install this on anything other than a fresh install of Fedora Server
  

## 2025-09-16 22:30 - Main Branch - Modified Level-Up/configs/waybar/conf removing bad icons.

### Changed:
- Modified `level-up/configs/waybar/config`. Removed two bad icons. Changed sound percentage to remain while the device is muted.


## 2025-09-16 22:00 - Main Branch - Added wayland-utils wl-clipboard to install.sh

### Changed:
- Modified `level-up/install.sh` to add wayland-utils wl-clipboard. This package is needed to save clip art when you select some of the screen top copy for screenshots.


## 2025-09-16 07:00 - Main Branch - Modified install.sh to fix a typo

### Changed:
- Modified `level-up/install.sh` to add a missing backslash after the kde packages.


## 2025-09-15 12:30 - Fixed inconsistent syntax in hyprland.conf

### Changed:
- `level-up/configs/hypr/hyprland.conf` fixed inconsistent variable declarations.
- Created a hyprlock.conf keybinding in `level-up/configs/hypr/hyprland.conf` 


## 2025-09-14 23:30 - Main Branch - Added Documentation folder to repo

### Added:
- `level-up/Documentation/` folder containing VPN setup, GitHub SSH access, and boot optimization guides
  

## 2025-09-14 23:00 - Test Branch - Merged hyprlock_test with hyprlock

### Added:
- Added installation packages to `level-up/install.sh` to install.sh fix Dolphin issues: kde-cli-tools kde-runtime


## 2025-09-14 21:00 - Test Branch - Worked on broken fonts install.sh.

### Changed:
- `level-up/install.sh` 
- `level-up/configs/hypr/hyprland.conf` added hyprlock keybinding


## 2025-09-14 15:00 - Test Branch - Enhanced install.sh with Pipewire audio setup and improved dolphin file associations

### Added:
- Added installation packages to `level-up/install.sh` pipewire, pipewire-pulse, pipewire-alsa, wireplumber.

### Changed:
- Improved messages and flow in `level-up/install.sh`.
- Added a check in `level-up/install.sh` to see if xdg-mime is available before setting file associations.
- Added copying of `level-up/configs/hypr/hyprlock.conf` to the config directory.
- Added file associations for basic file types to dolphin
- Updated `level-up/README.md` to give a more accurate description of the project.


## 2025-09-13 20:00 - Fixed install.sh hyprland.conf installation issue.

### Changed:
- Updated `level-up/install.sh` to correctly copy over `level-up/configs/hypr/hyprland.conf`. 
- Updated `level-up/README.md` to indicate testing was done with Fedora 42 Server.

### Removed:
- Removed some of LibreOffice files. The intention was to only install LibreOffice Writer.


## 2025-09-13 17:00 - Merged feature/installed-apps into main

### Changed:
- Refactored `level-up/install.sh` script with improved package installation and setup.
- `level-up/CHANGELOG.md`
- `level-up/configs/hypr/hyprland.conf`
- `level-up/configs/waybar/scripts/power_menu.sh`


### Removed:
- Deleted `feature/installed-apps` branch after successful merge.


## 2025-09-13 13:30 - Install Script Fixes and Improvements 

### Added:
- Added fallback check in `level-up/install.sh` to skip power_menu.sh setup if the script is missing.
- Added logic to `level-up/install.sh` for rebuilding font cache after installing Microsoft Fonts.

### Changed:
- Replaced RPM-based Microsoft Fonts install in `level-up/install.sh` with a reliable tar.gz-based method.
- Fixed .bashrc prompt customization in `level-up/install.sh` to prevent grep warnings and ensure correct escaping.
- Improved output messages in `level-up/install.sh` for clarity during installation.
- Ensured config directories and wallpaper paths in `level-up/install.sh` are handled more robustly.

### Removed:
- Removed broken msttcore-fonts-installer RPM installation method.


## 2025-09-13 12:00 - Added missing software to the installation

### Added:
- Installed Firefox, GNOME Calendar, Galculator, GIMP, Virt-Manager, NetworkManager Connection Editor, LibreOffice, and Microsoft Fonts in `level-up/install.sh`.

### Changed:
- Updated `level-up/install.sh` to group all package installations together for better readability.
- Improved `level-up/install.sh` completion messages for clarity.
- Added Firefox, GNOME Calendar, Galculator, GIMP, Virt-Manager, NetworkManager Connection Editor, LibreOffice, and Microsoft Fonts packages to the `level-up/install.sh`


## 2025-09-02 20:30 - Power Menu Integration 

### Added:
- Added `level-up/install.sh`  to include power menu setup.
- Added `level-up/configs/waybar/scripts/power_menu.sh` to ~/.config/hypr/waybar/scripts/
- Updated `level-up/install.sh`  to make `level-up/configs/waybar/scripts/power_menu.sh` executable.
- Created `level-up/CHANGELOG.md` to track changes
- Added Post Install Resources to the `level-up\documentation\README.md`
- Added Security and Compatibility Disclaimer to the `level-up\documentation\README.md`
- Added Acknowledgments to the `level-up\documentation\README.md`


## 2025-09-02 12:00 - Fedora 42 Hyprland Setup

### Added
- Updated `level-up/install.sh` to install Hyprland via the COPR repository.
- Updated `level-up/install.sh` to install additional packages: Alacritty, Fastfetch, Waybar, etc.
- Added a configuration section in `level-up/install.sh` for Alacritty, Fastfetch, Waybar, and Hyprland.
- Updated `.bashrc` to set up a custom bash prompt.
- Added default wallpaper and created required directories.



### Note: Initial development began around July 2025. Early changes from the first couple of months were not consistently documented, as the project was not yet being actively tracked.
