# Level-Up Keybindings Guide

This document provides an overview of the most common keybindings included in this Hyprland configuration, along with instructions on how to customize them.

Hyprland’s official keybinding documentation:
[https://wiki.hypr.land/Configuring/Binds/](https://wiki.hypr.land/Configuring/Binds/)

---

# Modifier Key

This configuration defines:

```
$mainMod = SUPER
```

This means **Super (Windows key)** is used as the primary modifier throughout keybindings.

---

# Application Launcher Keybindings

| Keybinding            | Action              | Description                       |
| --------------------- | ------------------- | --------------------------------- |
| **SUPER + b**         | `exec firefox`      | Open Firefox browser              |
| **SUPER + e**         | `exec dolphin`      | Open file manager                 |
| **SUPER + t**         | `exec alacritty`    | Open terminal                     |
| **SUPER + s**         | `exec wofi`         | Application/search menu           |
| **SUPER + v**         | `exec virt-manager` | Virtual machine manager           |
| **SUPER + k**         | `exec kwrite`       | Text editor                       |
| **SUPER + Shift + S** | `grim + slurp`      | Screenshot selection to clipboard |

### Wofi Application Menu
This configuration launches the Wofi menu with **SUPER + s**.  
Press **Esc** to close Wofi without launching anything. 
Wofi is also used for the Power Options menu on the Waybar.
Just like the main launcher, you can press **Esc** to close it as well

---

# Window Management

### Basic Actions

| Keybinding            | Action                           |
| --------------------- | -------------------------------- |
| **SUPER + c**         | Close active window              |
| **SUPER + f**         | Toggle floating window           |
| **SUPER + p**         | Toggle pseudotile (dwindle mode) |
| **SUPER + l**         | Lock screen (`hyprlock`)         |
| **SUPER + Shift + l** | Toggle split layout              |

### Window Movement (Keyboard)

| Keybinding                  | Action                     |
| --------------------------- | -------------------------- |
| **SUPER + ←/→/↑/↓**         | Move focus between windows |
| **SUPER + Shift + ←/→/↑/↓** | Swap window with neighbor  |

### Window Movement (Mouse)

| Keybinding                     | Action        |
| ------------------------------ | ------------- |
| **SUPER + Left Click + Drag**  | Move window   |
| **SUPER + Right Click + Drag** | Resize window |

---

# Workspaces

### Switching Workspaces

| Keybinding      | Action                  |
| --------------- | ----------------------- |
| **SUPER + 1–4** | Switch to workspace 1–4 |

### Moving Windows to Workspaces

| Keybinding              | Action                   |
| ----------------------- | ------------------------ |
| **SUPER + Shift + 1–4** | Move window to workspace |

### Scrolling Between Workspaces

| Keybinding                 | Action                          |
| -------------------------- | ------------------------------- |
| **SUPER + Scroll Up/Down** | Move to next/previous workspace |

---

# Special Workspace (Scratchpad)

| Keybinding            | Action                                      |
| --------------------- | ------------------------------------------- |
| **SUPER + D**         | Toggle the special “magic” workspace        |
| **SUPER + Shift + D** | Move active window to the special workspace |

---

# Configuration Shortcuts

Easily edit relevant config files.:

| Keybinding            | File                                        |
| --------------------- | ------------------------------------------- |
| **SUPER + H**         | `~/.config/hypr/hyprland.conf`              |
| **SUPER + Shift + H** | `~/.config/hypr/hyprlock.conf`              |
| **SUPER + A**         | `~/.config/alacritty/alacritty.toml`        |
| **SUPER + Shift + A** | `~/.config/alacritty/alacritty-colors.toml` |
| **SUPER + W**         | `~/.config/waybar/config`                   |
| **SUPER + Shift + W** | `~/.config/waybar/style.css`                |

---

# Audio Controls

Note: The XF86 audio options bind the sound settings to the defaults of your laptop or keyboard. So for example if you can increase, decrease, or mute
sound on your device using the function keys, the below keybindings should replicate that functionality with the same keybindings you currently use.

| Keybinding                              | Action                                |
| --------------------------------------- | ------------------------------------- |
| **XF86AudioRaiseVolume**                | Volume +5%                            |
| **XF86AudioLowerVolume**                | Volume -5%                            |
| **XF86AudioMute**                       | Toggle audio mute                     |
| **XF86AudioMicMute**                    | Toggle mic mute                       |
| **XF86AudioNext / Prev / Play / Pause** | Media controls (requires `playerctl`) |

---

# Screen Brightness


Note: The XF86 brightness options bind the brightness settings to the defaults of your laptop or keyboard. So for example if you can increase or decrease,
screen brightness on your device using the function keys, the below keybindings should replicate that functionality with the same keybindings you currently use.

| Keybinding                | Action              |
| ------------------------- | ------------------- |
| **XF86MonBrightnessUp**   | Increase brightness |
| **XF86MonBrightnessDown** | Decrease brightness |

---

# How to Modify Keybindings

All keybindings are defined in your Hyprland config file:

```
~/.config/hypr/hyprland.conf
```

### Changing a keybinding

To change a binding, edit the `bind = ...` line.
Example — change the terminal shortcut:

```ini
# Original
bind = $mainMod, t, exec, $terminal

# Change SUPER + t to SUPER + Return:
bind = $mainMod, RETURN, exec, $terminal
```

### Adding a new keybinding

Follow the standard format:

```
bind = <modifiers>, <key>, <action>, <arguments>
```

Example — launch a music player:

```ini
bind = $mainMod, m, exec, strawberry
```

### Reload Hyprland to apply changes

Inside Hyprland:

```
SUPER + Shift + R
```

(or restart the session entirely)

---

# Tips for Users

* To find valid keys, refer to: [https://wiki.hypr.land/Configuring/Binds/#keys](https://wiki.hypr.land/Configuring/Binds/#keys)
* `$mainMod` can be changed to `ALT` or other modifiers if desired.
* Mouse bindings use `bindm` and multimedia keys use `bindl` or `bindel`.


