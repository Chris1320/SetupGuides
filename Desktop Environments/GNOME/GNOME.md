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
3. Customize using [catppuccin/cursors](https://github.com/catppuccin/cursors).
4. Install fonts and set via GNOME Tweaks.
    - Fonts
        - Interface Text: **SF Pro Rounded Regular**[^1]
        - Document Text: **SF Pro Text Regular**[^1]
        - Monospace Text: **JetBrainsMono Nerd Font Regular**[^2]
    - Appearance
        - Cursor: **Catppuccin-Mocha-Teal-Cursors**
	- Startup Applications
		- EasyEffects
		- Vesktop
5. [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)
    - Enable `Applications > Applications blur (beta)`.
    - Add the following classes to Applications blur whitelist:
	    - `org.gnome.Ptyxis`
	    - `obsidian`
	    - `io.missioncenter.MissionCenter`
	    - `org.gnome.SystemMonitor`
6. [Just Perfection](https://extensions.gnome.org/extension/3843/just-perfection/)
    - Disable `Visibility > Keyboard Layout`
    - Disable `Visibility > Window Picker Caption`
    - Disable `Visibility > Background Menu`
    - Change `Behavior > Startup Status` to `Desktop`.
7. [User Avatar In Quick Settings](https://extensions.gnome.org/extension/5506/user-avatar-in-quick-settings/)
    - Set `Position` to `Left`.
8. [QSTweak](https://extensions.gnome.org/extension/5446/quick-settings-tweaker/)

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
	- Toggle fullscreen mode: `SUPER+F`
- Custom Shortcuts
	- System Monitor
		- Command: `flatpak run io.missioncenter.MissionCenter`
		- Shortcut: `SUPER+ESC`

[^1]: SF Pro is made by Apple. You have to download their font package from [their website](https://developer.apple.com/fonts/), extract the fonts using `dmg2img`, and then install it into your system.
[^2]: You can get nerd fonts at [nerdfonts.com](https://www.nerdfonts.com/).
