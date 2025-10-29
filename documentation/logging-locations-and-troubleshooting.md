## Logging Locations and Troubleshooting

### 1. **`install.sh` Logs**
The installation script logs its activities, including package installation, configuration copying, and any errors or warnings that occur during execution.

- **Log File**: `$HOME/.local/share/level-up/level-up-install.log`
- **Dry-Run Log File** (if you use the `--dry-run` option): `$HOME/.local/share/level-up/level-up-install-dryrun.log`

These logs will contain detailed information about the installation process. If you encounter any issues during the installation, these logs can help identify what went wrong.

---

### 2. **Hyprland Logs**
Hyprland logs provide detailed information about the window manager’s behavior, including errors, warnings, and debugging information.

- **Log File**: `$HOME/.local/share/level-up/hyprland.log`

**Log Levels:**
- `0`: Errors only (Minimal log output)
- `1`: Warnings
- `2`: Info (General informational messages)
- `3`: Debug (Verbose logging for detailed troubleshooting)
- `trace`: Extremely verbose, detailed logging (Use with caution, generates large amounts of data)

You can adjust the logging level by editing the `loglevel` in your `hyprland.conf`. By default, the log file will be located in `$HOME/.local/share/level-up/hyprland.log`.

---

### 3. **Waybar Logs**
Waybar logs provide information about the status bar and any issues related to modules like network, audio, battery, etc.

- **Log File**: `$HOME/.local/share/level-up/waybar.log`

**Log Levels:**
- `error`: Logs errors only
- `warn`: Logs warnings
- `info`: Logs general information
- `debug`: Logs detailed debug info
- `trace`: Extremely verbose logs, including all internal operations

You can adjust the logging level by modifying the `logging` section in your Waybar config file (`~/.config/waybar/config.json`). The default log level is typically `info`, but you can set it to `debug` or `trace` if you need more detailed logs for troubleshooting.

---

### General Notes:
- **Where to find logs**: All log files are stored in the directory `$HOME/.local/share/level-up/`.
- **When to check the logs**: You should review the logs if you encounter any issues during installation (`install.sh` logs), window manager behavior (`hyprland` logs), or status bar functionality (`waybar` logs).
- **Log rotation**: Depending on how much logging is done, log files might grow over time. Make sure to monitor them if you're using `trace` level logging for development purposes.
