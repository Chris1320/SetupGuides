# Cinnamon

This guide will help you install a new theme for the Cinnamon Desktop Environment. In this guide, I will be using the *teal* variation of the Catppuccin theme, but the same steps apply for any variation.

This guide has been tested on the following systems:

- **Cinnamon 5.2.7** on *Linux Mint 20.3*

## Customization Guide

### Theming the Desktop

1. Download the [Catppuccin theme](https://github.com/catppuccin/gtk) for [GTK](https://gtk.org/).
2. Extract the archive you downloaded to `~/.themes/`.
3. Apply the theme by running the *Themes* application and selecting `Catppuccin-[COLOR]` for the windows borders, controls, and desktop.
4. Download and apply the [Catppuccin Cursors](https://github.com/catppuccin/cursors).[^1]
5. Install the [Papirus Icon Theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme).[^1]
6. Apply the [Catppuccin theme for Papirus Folders](https://github.com/catppuccin/papirus-folders).[^1]

### Customizing Panels

1. Open the panel settings by selecting `Panel` in the application list or right-clicking the panel and selecting `Panel Settings`.
2. In `General Panel Options`, click `Add new panel` to add a new panel. Add one at the top of the desktop.
3. Now that we have two panels, enable `Panel edit mode` to enable edit mode in the bottom panel.
4. To enable "*Panel Edit Mode*" in the top panel, click `Next Panel` and then `Panel edit mode`.
5. You should now see red, green, and blue colors on the left, middle, and right side of both panels, respectively.
6. Move the system time and icons to the **top-right panel**. Add a spacer between the time and the icons.
7. Move the notification and application-specific icons to the **top-left panel**.
8. Move the running applications' icons to the **bottom-middle panel**. Leave the application menu (the Mint icon) on the bottom-left panel.
9. Download "Transparent Panels" from `System Settings > Extensions > Download > Transparent Panels`.
10. Enable panel transparency for the bottom panel only.

[^1]: Follow the usage instructions from their `README.md` files.

-----

**References**:

- [Papirus Icon Theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- [Catppuccin for GTK](https://github.com/catppuccin/gtk)
- [Catppuccin Cursors](https://github.com/catppuccin/cursors)
- [Catppuccin for Papirus Folders](https://github.com/catppuccin/papirus-folders)

