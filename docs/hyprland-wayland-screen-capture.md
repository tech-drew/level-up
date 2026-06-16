# Hyprland vs Hyprland (UWSM) on Fedora Linux

## Overview

Hyprland is a Wayland compositor/window manager. When installed on Fedora (especially alongside KDE Plasma), you may see two login options:

- **Hyprland**
- **Hyprland (UWSM)**

Both run the same Hyprland compositor. The difference is **how the session is started and managed**.

The difference becomes important for things like:

- screen sharing
- OBS capture
- portals
- PipeWire
- notifications
- systemd user services
- application startup

---

# Normal Hyprland Session

## Startup flow

```

SDDM
|
v
Hyprland
|
v
hyprland.conf
|
v
Applications

````

Hyprland starts directly from the display manager.

Your configuration usually handles startup:

```ini
exec-once = waybar
exec-once = hyprpaper
exec-once = mako
````

The compositor works, but you are responsible for managing the environment.

---

## Advantages

* Simple setup
* Easy to understand
* Most tutorials assume this setup
* Less dependency on systemd

---

## Disadvantages

Some Wayland services may not receive the correct session environment.

Examples:

* xdg-desktop-portal
* xdg-desktop-portal-hyprland
* PipeWire
* screen capture services

Symptoms can include:

* OBS opens screen capture
* No monitors/windows appear
* Screen sharing does not work

---

# Hyprland with UWSM

## What is UWSM?

UWSM means:

**Universal Wayland Session Manager**

It wraps Wayland compositors inside a systemd-managed user session.

Instead of Hyprland starting alone, UWSM manages the session.

---

## Startup flow

```
SDDM
 |
 v
UWSM
 |
 v
systemd user session
 |
 v
Hyprland
 |
 v
Applications
```

---

# Why UWSM Helps

Wayland applications depend on environment variables and services being available.

Important variables:

```
XDG_SESSION_TYPE=wayland
XDG_CURRENT_DESKTOP=Hyprland
WAYLAND_DISPLAY=wayland-0
```

A proper session allows services like:

```
OBS
 |
 v
xdg-desktop-portal
 |
 v
xdg-desktop-portal-hyprland
 |
 v
Hyprland compositor
```

to communicate correctly.

---

# Screen Capture Example

## Normal Hyprland

Possible failure:

```
OBS
 |
 v
Screen Capture Portal
 |
 v
Missing session information
 |
 v
No displays listed
```

OBS opens, but no screens appear.

---

## Hyprland + UWSM

Working flow:

```
OBS
 |
 v
xdg-desktop-portal
 |
 v
xdg-desktop-portal-hyprland
 |
 v
Hyprland
 |
 v
Monitor list appears
```

OBS can select displays.

---

# Recommended Fedora Setup

For Fedora systems:

* Fedora uses systemd heavily
* KDE Plasma already uses systemd user services
* UWSM fits naturally into the environment

Recommended:

```
SDDM
 |
Hyprland (UWSM)
```

---

# Application Startup with UWSM

Instead of:

```ini
exec-once = waybar
exec-once = hyprpaper
exec-once = mako
```

Prefer:

```ini
exec-once = uwsm app -- waybar
exec-once = uwsm app -- hyprpaper
exec-once = uwsm app -- mako
```

This lets UWSM track and manage applications.

---

# Useful Packages

Fedora:

```bash
sudo dnf install \
uwsm \
xdg-desktop-portal \
xdg-desktop-portal-hyprland \
pipewire \
wireplumber
```

---

# Troubleshooting

## Check UWSM

```bash
uwsm --version
```

---

## Check Hyprland

```bash
pgrep -a Hyprland
```

---

## Check portals

```bash
systemctl --user status xdg-desktop-portal
```

```bash
systemctl --user status xdg-desktop-portal-hyprland
```

---

## Restart portals

```bash
systemctl --user restart xdg-desktop-portal
systemctl --user restart xdg-desktop-portal-hyprland
```

---

# Summary

| Feature             | Hyprland          | Hyprland UWSM        |
| ------------------- | ----------------- | -------------------- |
| Same compositor     | Yes               | Yes                  |
| Simple setup        | Better            | More complex         |
| systemd integration | Limited           | Better               |
| Portal support      | Manual setup      | Usually works        |
| OBS capture         | May require fixes | Usually works        |
| App management      | Manual            | systemd/UWSM managed |

For a modern Fedora Hyprland rice:

**Hyprland + UWSM is the preferred setup.**

It provides a cleaner Wayland session and avoids many issues with portals, screen capture, and desktop services.
