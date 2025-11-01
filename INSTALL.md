## Install Instructions

---

If Git is not already installed, install it using the following command:

```bash
sudo dnf install git -y
```
Next, clone the repository and run the installation script:

```bash
git clone https://github.com/Always-Growing/level-up.git
cd level-up
chmod +x install.sh
./install.sh
```
**Note:** The install.sh script copies configuration files into the home directory of the user who runs it.
If you run the script with sudo or as root, those files will be placed in the root user’s home directory (/root) instead of your normal user’s profile.

To ensure the configuration is applied to your user account, run the "./install.sh" command as your regular user (without sudo):

### Optional Features

- **Dry-Run Mode** – Test the installation without making changes:

```bash
./install.sh --dry-run
```
All actions will be logged and printed, but no files will be copied or packages installed.

**Logs for Dry-Run Mode** are saved to:  
`$HOME/.local/share/level-up/level-up-install-dryrun.log`

**Normal Logging** (for regular installations) is saved to:  
`$HOME/.local/share/level-up/level-up-install.log`
