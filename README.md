# Level-Up

**Level-Up** is a customizable desktop environment built on **Fedora 42 KDE Plasma Desktop Edition**, featuring **Hyprland** as the dynamic window manager. It comes preconfigured with a curated set of tools and aesthetic customizations, including **Waybar**, **Alacritty**, **Fastfetch**, **Dolphin**, and more.

> Linux is about making your computer work for you.  
> This configuration is meant to be a starting point, not a final product. Feel free to try it out, tweak it, and make Level-Up your own.

---

## Project Status: Work in Progress

This project is under development and evolving as I learn and grow. Features may change over time, and feedback is welcome.

I started learning Linux in June 2025, and this project serves as a hands-on way to deepen my Linux knowledge. Prior to working on this project I had no experience in GitHub, scripting, or programming.

For a detailed summary of the skills, challenges, and lessons I learned while building this project, see the [Lessons Learned](docs/lessons-learned.md) document.

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
_A layout with a few applications open in a tiled setup. Dolphin is using the Level-Up-Icon theme, configured through the KDE Icon Settings._

---

## Installation

Before proceeding with the installation, please **read the [Compatibility and Security Disclaimer](docs/compatibility-and-security-disclaimer.md)** to ensure that your system meets the necessary requirements and to be aware of any potential issues.

Once you've reviewed the disclaimer, follow the steps in the [INSTALL.md](INSTALL.md) to get started with the installation.

---

## Project Workflow Overview

Level-Up uses a **GitFlow-inspired workflow** to organize development and maintain historical snapshots.  
**Note:** This workflow is for informational purposes only; contributions via pull requests are not being accepted at this time.

### Branch Structure

- **`main`**: Stable snapshot branch containing the full project history (currently v2.3-beta). Only updated when creating snapshots or applying hotfixes.  
- **`develop`**: Active development branch where ongoing changes, experiments, and preparations for future snapshots occur.  
- **`feature/*`**: Short-lived branches for new features, branched off `develop`. Used mainly for historical reference.  
- **`issue/*`**: Short-lived branches for resolving specific issues or bugs, branched off `develop`. Example: `issue/42-fix-waybar-logs`.  
- **`release/*`** (optional): Branches used to stabilize upcoming snapshots before merging into `main`.  
- **`hotfix/*`**: Branches for urgent fixes applied to `main` and merged back into `develop`.

main  (stable snapshot)
  │
  ├── hotfix/hotfix-1      <- urgent fixes branch off main
  │         │
  │         └── merges back into main & develop
  │
  └── develop  (active development)
         │
   ┌─────┬───────────┬───────────┐
feature/xyz  issue/42-fix-waybar-logs  release/v4.0.0.example-release
   │           │           │
   └───────────┴───────────┘ merged back into develop
         │
         └── eventually merged into main for snapshot

## Commit Message Best Practices

To maintain a clear, organized project history, follow these guidelines for commit messages. Commit types **do not have to match branch names**: branches indicate **where work happens**, commits indicate **what type of change** was made.

### Recommended Format

`<type>(<scope>): <short description>`

- **`type`** – Kind of change:
  - `feat` – New feature
  - `fix` – Bug fix
  - `docs` – Documentation changes
  - `style` – Formatting or style changes
  - `refactor` – Code changes that do not add features or fix bugs
  - `test` – Adding or updating tests
  - `chore` – Maintenance tasks

- **`scope`** – Optional; the project section affected (e.g., `hyprland`, `waybar`, `install`)  
- **`short description`** – A concise, imperative mood description of the change (e.g., “Add support for Waybar modules”)

### Examples

- `feat(hyprland): add new workspace navigation keybindings`  
- `fix(issue/42): resolve Waybar log display bug`  
- `docs(README): update installation instructions for Fedora 43`  
- `refactor(alacritty): simplify color scheme configuration`  
- `chore: update dependencies to latest versions`

### Guidelines

1. Keep the first line ≤ 72 characters.  
2. Use **imperative mood** (“Fix bug” not “Fixed bug”).  
3. Reference issues when applicable (e.g., `fix(issue/42)`).  
4. Make **one logical change per commit**; avoid mixing unrelated changes.  
5. Use a blank line before a longer description if needed.

Following these best practices keeps the project history **organized, readable, and easy to track**, especially when working across multiple branches (`feature/*`, `issue/*`, `release/*`, `hotfix/*`) and snapshots (`develop` → `main`).

---

## Documentation

Optional guides and resources are available in the [docs](docs/) folder, including:
- [Compatibility and Security Disclaimer](docs/compatibility-and-security-disclaimer.md) – Disclaimer regarding compatibility and security considerations.
- [INSTALL](INSTALL.md) – Installation instructions for setting up the project.
- [CHANGELOG](CHANGELOG.md) – Project version history and updates.
- [Branches Overview](docs/branches.md) – Overview of branches, including their purposes, changes, and related issues.
- [Logging Locations and Troubleshooting](docs/logging-locations-and-troubleshooting.md) – Guide on where to find logs for the installation process, hyprland, waybar, and troubleshooting tips.
- [Post-Install Resources](docs/post-install-resources.md) – Optional tools, drivers, and tweaks.
- [Fedora KDE Plasma SSH Setup](docs/fedora-kde-plasma-ssh-setup.md) – Optional SSH configuration tips.
- [Github Private Repo Access Setup](docs/github-private-repo-access-setup.md) – Optional setup guide for private repo access.
- [Linux Boot Time Optimizations](docs/linux-boot-time-optimizations.md) – Tips for faster boot times.
- [VPN Private Internet Access Setup](docs/vpn-private-internet-access-setup.md) – Optional VPN configuration guide.
- [Acknowledgments](docs/acknowledgments.md) – Credits for referenced open-source projects.

---

## Feedback & Suggestions

---

This project is part of my ongoing journey to learn Linux. I welcome constructive feedback, ideas, and suggestions that can help me improve and refine **Level-Up**.

At this time, I’m not accepting direct code contributions or pull requests. I want this project to reflect my personal growth over time, so code changes from others will be rejected. However, I truly appreciate hearing different perspectives and learning from community input.

If you’d like to share feedback or suggestions, please use the **Discussions tab**:

- Leave a comment or suggestion in the [Discussions tab](https://github.com/Always-Growing/level-up/discussions/31) to share your thoughts, ideas, or recommendations.

If you're reporting a problem or bug, please open an **Issue**:

- Open an [issue](../../issues) for any bugs, errors, or technical problems that need attention.

Thank you for being part of this journey

---

## Licensing

---

**Level-Up** is licensed under the **Level-Up License**, which grants you the freedom to use, modify, and distribute the project. However, certain conditions must be met for redistribution and modification. Please refer to the full **Level-Up License** in the [Level-Up License](licenses/level-up-license.txt) file for the complete terms.

This project also incorporates third-party software with their respective licenses. Please refer to the [licenses/](licenses) directory for the licenses of third-party software used in this project.

For more details on the Level-Up License, please see the full [Level-Up License](licenses/level-up-license.txt) file.

---

If you believe any licensing is missed or not properly acknowledged in this project, please reach out to me directly so I can update the licensing to remedy any issues. Your help in ensuring proper licensing is greatly appreciated.

---

### Icon Theme

The **Level-Up Icon Theme** (purple variant of Breeze Dark) included in this project is a derivative work of the **Breeze Dark Icon Theme** by the KDE Community.

- Original Breeze Dark Icon Theme: © KDE Community, licensed under the **GPL v2 or later**.
- Level-Up modifications: © Always-Growing / 2025, licensed under the **GPL v3**.

The full license for the Level-Up Icon Theme can be found in the [Level-Up-Icon-Theme-LICENSE](licenses/level-up-icon-theme.txt) file.

