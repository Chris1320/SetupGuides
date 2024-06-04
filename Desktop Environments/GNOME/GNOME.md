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

Disable the *Background Logo* built-in extension.

### Custom Keyboard Shortcuts

- Accessibility
	- Turn screen reader on or off: *Disabled*
- Launchers
	- Launch Help Browser: *Disabled*
- Navigation
	- Move window one monitor down: *Disabled*
	- Move window one monitor to the left: *Disabled*
	- Move window one monitor to the right: *Disabled*
	- Move window one monitor up: *Disabled*
	- Move window one workspace to the left: `SHIFT+CTRL+ALT+LEFT`
	- Move window one workspace to the right: `SHIFT+CTRL+ALT+RIGHT`
	- Move window to last workspace: *Disabled*
	- Move window to workspace 1: `SHIFT+SUPER+1`
	- Move window to workspace 2: `SHIFT+SUPER+2`
	- Move window to workspace 3: `SHIFT+SUPER+3`
	- Move window to workspace 4: `SHIFT+SUPER+4`
	- Switch system controls directly: *Disabled*
	- Switch to last workspace: *Disabled*
	- Switch to workspace 1: `ALT+SUPER+1`
	- Switch to workspace 2: `ALT+SUPER+2`
	- Switch to workspace 3: `ALT+SUPER+3`
	- Switch to workspace 4: `ALTB+SUPER+4`
	- Switch to workspace on the left: `CTRL+ALT+LEFT`
	- Switch to workspace on the right: `CTRL+ALT+RIGHT`
	- Switch windows directly: *Disabled*
	- Switch windows of an app directly: *Disabled*
- Screenshots
	- Record a screencast interactively: `SHIFT+SUPER+R`
	- Take a screenshot: `SUPER+S`
	- Take a screenshot interactively: `SHIFT+SUPER+S`
	- Take a screenshot of a window: `ALT+SUPER+S`
- Sound and Media
	- Microphone mute/unmute: `SUPER+M`
- System
	- Focus the active notification: `CTRL+SUPER+X`
	- Log out: `SHIFT+CTRL+ALT+DEL`
	- Open the quick settings menu: `SUPER+D`
	- Restore the keyboard shortcuts: *Disabled*
	- Show all apps: *Disabled*
	- Show the notification list: `SUPER+N`
	- Show the run command prompt: `SUPER+R`
- Windows
	- Close window: `SUPER+W`
	- Maximize window: *Disabled*
	- Restore window: *Disabled*
	- Toggle fullscreen mode: `SUPER+F`
	- View split on left: *Disabled*
	- View split on right: *Disabled*
- Custom Shortcuts
	- System Monitor
		- Command: `gnome-system-monitor`
		- Shortcut: `SHIFT+SUPER+ESC`

### GNOME Window Tiling

I want a similar experience with Hyprland in GNOME, so I use [Forge](https://extensions.gnome.org/extension/4481/forge/) to tile my windows. Install the extension and open its settings.

- Settings
	- Default Drag-and-Drop Center Layout: <u>Swap</u>
- Appearance
	- Color
		- Tiled Focus Hint and Preview
			- Border Color: `#94e2d5`
		- Tabbed Focus Hint and Preview
			- Border Color: `#94e2d5`
		- Stacked Focus Hint and Preview
			- Border Color: `#94e2d5`
		- Floated Focus Hint
			- Border Color: `#94e2d5`
		- Split Direction Hint
			- Border Color: `#f9e2af`
- Keyboard
	- Update Shortcuts
		- Window Shortcuts
			- `window-focus-down`: `<Super>Down`
			- `window-focus-left`: `<Super>Left`
			- `window-focus-right`: `<Super>Right`
			- `window-focus-up`: `<Super>Up`
			- `window-gap-size-decrease`: *unset*
			- `window-gap-size-increase`: *unset*
			- `window-move-down`: *unset*
			- `window-move-left`: *unset*
			- `window-move-right`: *unset*
			- `window-move-up`: *unset*
			- `window-resize-bottom-decrease`: *unset*
			- `window-resize-bottom-increase`: *unset*
			- `window-resize-left-decrease`: *unset*
			- `window-resize-left-increase`: *unset*
			- `window-resize-right-decrease`: *unset*
			- `window-resize-right-increase`: *unset*
			- `window-resize-top-decrease`: *unset*
			- `window-resize-top-increase`: *unset*
			- `window-snap-center`: `<Super>c`
			- `window-snap-one-third-left`: *unset*
			- `window-snap-one-third-right`: *unset*
			- `window-snap-two-third-left`: *unset*
			- `window-snap-two-third-right`: *unset*
			- `window-swap-down`: `<Shift><Super>Down`
			- `window-swap-last-active`: *unset*
			- `window-swap-left`: `<Shift><Super>Left`
			- `window-swap-right`: `<Shift><Super>Right`
			- `window-swap-up`: `<Shift><Super>Up`
			- `window-toggle-float`: `<Super>b`
		- Workspace Shortcuts
			- `workspace-active-tile-toggle`: `<Shift><Super>w`
		- Container Shortcuts
			- `con-split-horizontal`: *unset*
			- `con-split-layout-toggle`: *unset*
			- `con-split-vertical`: *unset*
			- `con-stacked-layout-toggle`: *unset*
			- `con-tabbed-layout-toggle`: *unset*
			- `con-tabbed-showtab-decoration-toggle`: `<Super><Alt>y`
		- Focus Shortcuts
			- `focus-border-toggle`: *unset*
		- Other Shortcuts
			- `prefs-open`: *unset*
			- `prefs-tiling-toggle`: *unset*
	- Drag-Drop Tiling Modifier Key Options
		- Tile Modifier: Super

[^1]: SF Pro is made by Apple. You have to download their font package from [their website](https://developer.apple.com/fonts/), extract the fonts using `dmg2img`, and then install it into your system.
[^2]: You can get nerd fonts at [nerdfonts.com](https://www.nerdfonts.com/).
