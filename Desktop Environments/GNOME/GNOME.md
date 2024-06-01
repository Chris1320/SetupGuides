---
title: GNOME
description: My GNOME customizations.
draft: false
tags:
  - linux
  - linux/desktop-environment
---
# GNOME

[GNOME](https://www.gnome.org/) is one of the most popular desktop environments in the whole Linux community. It is used by major Linux distributions such as [Ubuntu](https://ubuntu.com/), [Pop!\_OS](https://pop.system76.com/), and [[Fedora Workstation]].

## Customization

### Setting up the theme

1. Open *Settings* and do the following:
    - Select **Dark** in `Appearance > Style`.
    - Go to `System > Date & Time > Clock & Calendar` and set the following into their assigned values:
        - Week Day: *Disabled*
        - Date: *Disabled*
        - Seconds: *Enabled*
        - Week Numbers: *Disabled*
2. Install [User Themes](https://extensions.gnome.org/extension/19/user-themes/) extension.
3. Customize using [catppuccin/gtk](https://github.com/catppuccin/gtk).
4. Customize using [catppuccin/papirus-folders](https://github.com/catppuccin/papirus-folders).
5. Customize using [catppuccin/cursors](https://github.com/catppuccin/cursors).
6. Install fonts and set via GNOME Tweaks.
    - Fonts
        - Interface Text: **SF Pro Rounded Regular**[^1]
        - Document Text: **SF Pro Text Regular**[^1]
        - Monospace Text: **JetBrainsMono Nerd Font Regular**[^2]
    - Appearance
        - Cursor: **Catppuccin-Mocha-Teal-Cursors**
        - Icons: **Papirus-Dark**
        - Shell: **Catppuccin-Mocha-Standard-Teal-Dark**
        - Legacy Applications: **Catppuccin-Mocha-Standard-Teal-Dark**
	- Windows
		- Center New Windows
	- Startup Applications
		- EasyEffects
		- KeePassXC
		- Vesktop
1. [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)
    - Enable `Applications > Applications blur (beta)`.
    - Add the following classes to Applications blur whitelist:
	    - `gnome-terminal-server`
	    - `io.bassi.Amberol`
	    - `obsidian`
	    - `io.missioncenter.MissionCenter`
	    - `org.gnome.SystemMonitor`
2. [Just Perfection](https://extensions.gnome.org/extension/3843/just-perfection/)
    - Disable `Visibility > Keyboard Layout`
    - Disable `Visibility > Window Picker Caption`
    - Disable `Visibility > Background Menu`
    - Change `Behavior > Startup Status` to `Desktop`.
3. [User Avatar In Quick Settings](https://extensions.gnome.org/extension/5506/user-avatar-in-quick-settings/)
    - Set `Position` to `Left`.
4. [QSTweak](https://extensions.gnome.org/extension/5446/quick-settings-tweaker/)
	- Disable `Noti&Media > Notification Widget`.
	- Disable `Other > Remove Notifications On Date Menu`

### Installing the Rest of the GNOME Extensions

- [Alphabetical App Grid](https://extensions.gnome.org/extension/4269/alphabetical-app-grid/)
- [App Hider](https://extensions.gnome.org/extension/5895/app-hider/)
- [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/appindicator-support/)
- [Caffeine](https://extensions.gnome.org/extension/517/caffeine/)
- [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)
	- Private Mode: `ALT+SUPER+V`
	- Toggle The Menu: `SUPER+V`
	- Clear History: `SHIFT+SUPER+V`
- [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect/)
- [Removable Drive Menu](https://extensions.gnome.org/extension/7/removable-drive-menu/)
<!-- - [Disconnect Wifi](https://extensions.gnome.org/extension/904/disconnect-wifi/) -->

Disable *Background Logo*

### Customize Keyboard Shortcuts

### Installing PaperWM

> [!WARNING] Following this section is not yet recommended as I'm still experimenting with it.

1. Install [PaperWM](https://extensions.gnome.org/extension/6099/paperwm/).
2. Edit settings
    - Turn on `Enable Gnome Workspace Indicator Pill`
3. Adjust keybindings.

| Operation                                                                 | Keybind                |
| ------------------------------------------------------------------------- | ---------------------- |
| Open new window                                                           | `Super+Return`         |
| Close the active window                                                   | `Super+W`              |
| Switch to the next window                                                 | *Disabled*             |
| Switch to the previous window                                             | *Disabled*             |
| Switch to the next window (with wrap-around)                              | `Super+]`              |
| Switch to the previous window (with wrap-around)                          | `Super+[`              |
| Switch to previously active window                                        | `Super+Tab`            |
| Switch to previously active window, backward order                        | `Shift+Super+Tab`      |
| Switch to previously active scratch window                                | `Ctrl+Super+Tab`       |
| Switch to previously active scratch window, backward order                | `Shift+Ctrl+Super+Tab` |
| Move the active window to the left                                        | `Shift+Super+Left`     |
| Move the active window to the right                                       | `Shift+Super+Right`    |
| Move the active window up                                                 | `Shift+Super+Up`       |
| Move the active window down                                               | `Shift+Super+Down`     |
| Activate the window under mouse cursor                                    | `Super+Backslash`      |
| Switch to previously active workspace                                     | *Disabled*             |
| Switch to previously active workspace, backward order                     | *Disabled*             |
| Move the active window to the previously active workspace                 | *Disabled*             |
| Move the active window to the previously active workspace, backward order | *Disabled*             |
| Switch to workspace above (ws only from current monitor)                  | `Alt+Super+Up`         |
| Switch to workspace below (ws only from current monitor)                  | `Alt+Super+Down`       |
| Move window one workspace up                                              | `Shift+Alt+Super+Up`   |
| Move window one workspace down                                            | `Shift+Alt+Super+Down` |
| Switch to the right monitor                                               | `Ctrl+Super+Right`     |
| Switch to the left monitor                                                | `Ctrl+Super+Left`      |
| Switch to the above monitor                                               | `Ctrl+Super+Up`        |
| Switch to the below monitor                                               | `Ctrl+Super+Down`      |
| Swap workspace with monitor to the right                                  | *Disabled*             |
| Swap workspace with monitor to the left                                   | *Disabled*             |
| Swap workspace with monitor above                                         | *Disabled*             |
| Swap workspace with monitor below                                         | *Disabled*             |
| Move the active window to the right monitor                               | `Ctrl+Alt+Super+Right` |
| Move the active window to the left monitor                                | `Ctrl+Alt+Super+Left`  |
| Move the active window to the above monitor                               | `Ctrl+Alt+Super+Up`    |
| Move the active window to the below monitor                               | `Ctrl+Alt+Super+Down`  |
| Toggles the floating scratch layer                                        | `Super+Tilde`          |
| Attach/detach the active window into the scratch layer                    | `Shift+Super+~`        |

[^1]: SF Pro is made by Apple. You have to download their font package from [their website](https://developer.apple.com/fonts/), extract the fonts using `dmg2img`, and then install it into your system.
[^2]: You can get nerd fonts at [nerdfonts.com](https://www.nerdfonts.com/).
