# Fedora Workstation

This is a guide on how I customize my Fedora installation. [Fedora Workstation](https://fedoraproject.org/) is a great operating system if you want something between a beginner-friendly Linux distribution (e.g., [Linux Mint](https://linuxmint.com/)) and a highly customizable and experimental distro (e.g., [Arch Linux](https://archlinux.org/)).

> [!WARNING] This guide is not yet complete and might break your system.

## Installation

> [!NOTE] This guide is tested on Fedora Workstation 39.

### Installing Fedora Workstation

1. Download the ISO image from [fedoraproject.org](https://fedoraproject.org/workstation/download/).
2. Restart your system into the Fedora Workstation Live USB.
3. Follow the on-screen instructions to install Fedora Workstation into your machine.

   > [!TIP]
   > 
   > I personally use the `WIN+SPACE` keymap to switch between languages to keep the same keybindings with Windows. I only have one language chosen:
   >
   > - English (US)
   > 
   > The rest are added in the customization part of the guide.

4. Restart the machine.
5. Follow the on-screen instructions.

### Customization

> [!TIP]
> 
> I recommend that you use the following customization
> guides first:
>
> - [catppuccin/gnome-terminal](https://github.com/catppuccin/gnome-terminal)
>   or replace it with Kitty and [customize it](https://github.com/catppuccin/kitty).
> - [[ZSH]]
> - [[Neovim]] (only if you are going to use [Neovim](https://neovim.io/)).

#### 1. Set the Machine Hostname

```bash
hostnamectl hostname <YOUR_DESIRED_HOSTNAME>

# or specify static and pretty hostnames
hostnamectl hostname --static <YOUR_DESIRED_STATIC_HOSTNAME>
hostnamectl hostname --pretty <YOUR_DESIRED_PRETTY_HOSTNAME>
```

#### 2. Configure DNF Package Manager

```bash
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=True' | sudo tee -a /etc/dnf/dnf.conf
# echo 'fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf

# Enable RPMFusion repositories
# More Info: https://rpmfusion.org/Configuration
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264
sudo dnf groupupdate core
```

#### 3. SSD-Specific Configuration

> See [this article](https://mutschler.dev/linux/fedora-post-install/#btrfs-filesystem-optimizations).

#### 4. Install Updates

```bash
sudo dnf upgrade --refresh -y
sudo dnf check
sudo dnf autoremove
flatpak update

sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
reboot
```

#### 5. Install Utilities

```bash
sudo dnf install openssl \
    git git-lfs wl-clipboard file-roller dmg2img \
    gnome-tweaks gnome-extensions-app \
    blueman-nautilus file-roller-nautilus \
    gnome-terminal-nautilus nautilus-gsconnect \

# multimedia codecs
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia

# firefox multimedia codecs
sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install -y gstreamer1-plugin-openh264 mozilla-openh264

flatpak install -y flatseal
```

#### 6. Customizing GNOME

Install the following extensions:

##### Installing the Catppuccin Theme

1. Open *Settings* and do the following:
    - Select **Dark** in `Appearance > Style`.
    - Go to `Date & Time > Clock & Calendar` and...
        - Week Day: *Disabled*
        - Date: *Disabled*
        - Seconds: *Enabled*
        - Week Numbers: *Disabled*
1. Install [User Themes](https://extensions.gnome.org/extension/19/user-themes/) extension.
2. Customize using [catppuccin/gtk](https://github.com/catppuccin/gtk).
3. Customize using [catppuccin/papirus-folders](https://github.com/catppuccin/papirus-folders).
4. Customize using [catppuccin/cursors](https://github.com/catppuccin/cursors).
5. Install fonts and set via GNOME Tweaks.
    - Fonts
        - Interface Text: **SF Pro Rounded Regular**
        - Document Text: **SF Pro Text Regular**
        - Monospace Text: **JetBrainsMono Nerd Font Regular**
    - Appearance
        - Cursor: **Catppuccin-Mocha-Teal-Cursors**
        - Icons: **Papirus-Dark**
        - Shell: **Catppuccin-Mocha-Standard-Teal-Dark**
        - Legacy Applications: **Catppuccin-Mocha-Standard-Teal-Dark**
4. [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)
    - Enable `Applications > Applications blur (beta)`.
    - Add GNOME Terminal to Applications blur to the whitelist.
5. [Just Perfection](https://extensions.gnome.org/extension/3843/just-perfection/)
    - Disable `Visibility > Keyboard Layout`
    - Disable `Visibility > Window Picker Caption`
    - Disable `Visibility > Background Menu`
    - Change `Behavior > Startup Status` to `Desktop`.
6. [User Avatar In Quick Settings](https://extensions.gnome.org/extension/5506/user-avatar-in-quick-settings/)
    - Set `Position` to `Left`.

##### Installing the Rest of the GNOME Extensions

- [Alphabetical App Grid](https://extensions.gnome.org/extension/4269/alphabetical-app-grid/)
- [App Hider](https://extensions.gnome.org/extension/5895/app-hider/)
- [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/appindicator-support/)
- [Caffeine](https://extensions.gnome.org/extension/517/caffeine/)
- [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)
- [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect/)
- [Removable Drive Menu](https://extensions.gnome.org/extension/7/removable-drive-menu/)
<!-- - [Disconnect Wifi](https://extensions.gnome.org/extension/904/disconnect-wifi/) -->

##### Installing PaperWM

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

##### Running Windows Software and Gaming

```bash
flatpak install com.valvesoftware.Steam net.lutris.Lutris
```

Open Lutris and go to settings

- `Interface > Use dark theme`: *Enabled*
- `Interface > Enable Discord Rich Presence for Available Games`: *Enabled*
- `Storage > Game library`: `~/.local/share/lutris`
- `Storage > Installer cache`: `~/.cache/lutris`

##### Setting Up Virtualization

```bash
# more info: https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started/
# install virtualization group
sudo dnf group install --with-optional virtualization
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
lsmod | grep kvm  # verify KVM kernel modules
```
