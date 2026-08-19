---
title: Fedora Workstation
description: My Fedora Workstation configuration
draft: false
tags:
  - linux/distro
---

# Fedora Workstation

This is a guide on how I customize my Fedora installation. [Fedora Workstation](https://fedoraproject.org/) is a great operating system if you want something between a beginner-friendly Linux distribution (e.g., [Linux Mint](https://linuxmint.com/)) and a highly customizable and experimental distro (e.g., [Arch Linux](https://archlinux.org/)).

## Base Installation & Initial Boot Setup

> [!NOTE]
>
> - This guide is tested on **Fedora Workstation 44** using the GNOME Desktop Environment.
> - After the following the whole guide, the system will consume about 25 GBs of storage space.

### Installing Fedora Workstation

1. Download the ISO image from [fedoraproject.org](https://fedoraproject.org/workstation/download/).
2. Restart your system into the Fedora Workstation Live USB.
3. Follow the on-screen instructions to install Fedora Workstation into your machine.
4. Restart the machine.
5. Follow the on-screen instructions.

> [!WARNING]
>
> **Do not** enable third-party repositories when asked. We are going to manually enable it when we [[#Package Manager & Repository Setup|configure our package managers]].

### Hostname Setup

Open the terminal and follow the instructions.

There are two ways to do this. We can change the system hostname normally

```bash
hostnamectl hostname <YOUR_DESIRED_HOSTNAME>
```

or specify different _static_ and _pretty_ hostnames

```bash
hostnamectl hostname --static <YOUR_DESIRED_STATIC_HOSTNAME>
hostnamectl hostname --pretty <YOUR_DESIRED_PRETTY_HOSTNAME>
```

> [!INFO] Run `man hostnamectl` for more information.

## Package Manager & Repository Setup

### DNF Configuration

Edit DNF's configuration file to make it faster in general. I also added some settings that I find convenient.

```bash
echo 'defaultyes=True' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
```

### Enabling Third-Party Repositories

Since we did not enable the _Third-Party Repositories_ when we were asked earlier,
we manually add [RPMFusion](https://rpmfusion.org/) and [Flathub](https://flathub.org/)'s remotes.

```bash
# Enable RPMFusion repositories
sudo dnf install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager enable fedora-cisco-openh264
sudo dnf group upgrade core

# Enable Flathub remote
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

More setup information can be found in the following links:

- [RPMFusion](https://rpmfusion.org/Configuration)
- [Flathub](https://flathub.org/setup/Fedora)

> [!TIP]- Verifying results
>
> Verify the results by checking the outputs of the following commands:
>
> ```bash
> cat /etc/dnf/dnf.conf
> dnf repolist
> flatpak remotes
> ```

## System Update & Essential Utilities

### System Update

Regardless of the operating system you use, it is a good practice to update your
software after installing the new system.

```bash
# update dnf and flatpak packages
sudo dnf upgrade -y --refresh
sudo dnf autoremove
flatpak update

# update firmwares
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
```

> [!INFO] A reboot is recommended after updating.

### System Configuration

We need to increase the number of `inotify` instances because some applications
(e.g., Visual Studio Code/Neovim LSP Servers) require more than the default
value. We also enable `kernel.sysrq` to allow us to use the Magic SysRq key
for emergency situations. The second command applies the changes we made to
the system configuration.

```bash
printf "fs.inotify.max_user_instances = 256\nkernel.sysrq = 1" | sudo tee /etc/sysctl.d/50-user.conf
sudo sysctl --system
```

### Essential Utilities

I install essential CLI utilities and libraries that I frequently use. I also
install [Flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal)
to manage Flatpak permissions.

```bash
# install essential CLI utilities and libraries
sudo dnf install \
  git git-lfs gh \
  mc unrar 7zip-standalone-all \
  file-roller dmg2img trash-cli \
  openssl btop inxi wl-clipboard

# install flatseal
flatpak install -y flathub flatseal
```

Install other utilities that I frequently use/nice to have.

```bash
sudo dnf install tealdeer
flatpak install -y flathub org.gnome.SoundRecorder
flatpak install -y flathub md.obsidian.Obsidian
flatpak install -y flathub org.cryptomator.Cryptomator
flatpak install -y flathub org.qbittorrent.qBittorrent

# Update tealdeer cache
tldr --update
```

## Applications & Software

Before proceeding, create desktop directories and clone the _SetupGuides-dotfiles_ repository to `~/Temp`.
Most software that will be installed are pre-configured in the dotfiles repository, so we will just copy
the configuration files to their respective locations.

```bash
mkdir -p ~/Temp ~/Cloud ~/Projects
git clone https://github.com/Chris1320/SetupGuides-dotfiles.git ~/Temp/SetupGuides-dotfiles
```

### Terminal & Shell

Fedora Workstation comes with the new Ptyxis terminal, which is a modern terminal emulator for GNOME.
You can keep using it or use kitty, which is a cross-platform GPU-based terminal emulator.

However, the main shell that I use is [Zsh](https://www.zsh.org/) with [Oh My Zsh](https://ohmyz.sh/).
Follow the [[Shells/ZSH/ZSH|ZSH]] customization guide to set it up.

> [!TIP]
>
> It is recommended that you **restart your terminal** for the changes to take effect.

### Development

As a software engineer, I need to install development tools and programming languages.
However, some of the applications that are installed in this setup also require
these tools to be installed (e.g., Node.js, Rust, Go, etc.) to work properly.
So, I install these tools first before installing the applications.

```bash
# development tools
sudo dnf install uv python3-pip gcc golang rustup

# install lazygit to use as Git TUI
sudo dnf copr enable dejan/lazygit
sudo dnf install lazygit

# install Fast Node Manager
curl -fsSL https://fnm.vercel.app/install | bash
cat ~/.bashrc | tail -n 6 >> ~/.config/zsh/user_env.sh
```

After changing the ZSH configuration, reload the config either by restarting your terminal or running `exec zsh`.

```bash
fnm install --latest --use  # install and use latest version of Node

# install Bun
curl -fsSL https://bun.sh/install | bash
cat ~/.bash_profile | tail -n 3 >> ~/.config/zsh/user_env.sh
```

We've changed the ZSH config again, so reload the config again.

```bash
# actually install Rust
rustup-init

# Firebase CLI and OpenCode AI
bun install --global firebase-tools opencode-ai
flatpak install flathub com.visualstudio.code

uv tool install jupyterlab
```

### Web Browsers

Aside from Firefox, I also use a backup browser as a fallback, [Microsoft Edge](https://explore.microsoft.com/en-us/edge), which is available as an unofficial flatpak. As an alternative, you can also use [Ungoogled Chromium](https://github.com/ungoogled-software/ungoogled-chromium).

```bash
# Install Microsoft Edge
flatpak install flathub com.microsoft.Edge
# or use Ungoogled Chromium
flatpak install flathub io.github.ungoogled_software.ungoogled_chromium
```

### Communication

I use [Discord](https://discord.com/) via [Vesktop](https://github.com/Vencord/Vesktop) instead of the [official Flatpak](https://flathub.org/apps/com.discordapp.Discord) because it fixes screensharing and it also already comes with [Vencord](https://vencord.dev/) pre-installed.

```bash
flatpak install flathub dev.vencord.Vesktop
```

Open _Flatseal_, select _Vesktop_, and in the `Portals` section, enable the following:

- Background
- Notifications

> [!TIP]- Enabling Discord Rich Presence
>
> In _Flatseal_, go to `Vesktop > Filesystem > Other files` section, add the following entries:
>
> ```text
> xdg-run/.flatpak/dev.vencord.Vesktop:create
> xdg-run/discord-ipc-0
> ```
>
> And on the terminal, run the following commands to enable Discord Rich Presence in
> Vesktop. This sets up a symlink at `%t/discord-ipc-0` (your `$XDG_RUNTIME_DIR`, usually
> `/run/user/$UID`) pointing to Vesktop’s socket, so that other applications
> (e.g., Visual Studio Code, Neovim) can use it to show your Discord Rich Presence.
>
> ```bash
> mkdir -p ~/.config/user-tmpfiles.d
> echo 'L %t/discord-ipc-0 - - - - .flatpak/dev.vencord.Vesktop/xdg-run/discord-ipc-0' > ~/.config/user-tmpfiles.d/discord-rpc.conf
> systemctl --user enable --now systemd-tmpfiles-setup.service
> ```
>
> As for other flatpak applications, you need to provide the following global filesystem permissions in _Flatseal_:
>
> 1. `xdg-run/.flatpak/dev.vencord.Vesktop:create`
> 2. `xdg-run/discord-ipc-0`
>
> You can read more information on [flathub/dev.vencord.Vesktop](https://github.com/flathub/dev.vencord.Vesktop#discord-rich-presence).

### Media

I am using this OS as my daily driver, so I need to install multimedia codecs
to play videos and music. I'm not actually sure which codecs are required for
Fedora Workstation, but I installed the following packages to make sure that
I can play all of my media files.

```bash
# use full ffmpeg package
sudo dnf swap ffmpeg-free ffmpeg --allowerasing

# install multimedia codecs
sudo dnf install -y @multimedia @sound-and-video \
  gstreamer1-plugins-{bad-\*,good-\*,base} \
  gstreamer1-plugin-openh264 mozilla-openh264 \
  gstreamer1-libav lame\* \
  --exclude=gstreamer1-plugins-bad-free-devel,lame-devel
sudo dnf group install multimedia

uv tool install yt-dlp
```

### Gaming & Windows Software

Of course, gaming is one of the main reasons why I use Fedora Workstation. I
use [Steam](https://store.steampowered.com/) as my main gaming platform, and I
also use [Bottles](https://usebottles.com/) to run Windows games and applications
that are not available on Linux.

```bash
flatpak install -y flathub com.valvesoftware.Steam
flatpak install -y flathub com.usebottles.bottles
flatpak install -y flathub org.freedesktop.Platform.VulkanLayer.MangoHud
flatpak install -y flathub net.davidotek.pupgui2
sudo dnf install -y gamemode

# Enable Steam Proton Integration
flatpak override --user com.usebottles.bottles --filesystem=~/.var/app/com.valvesoftware.Steam/data/Steam
# Grant all flatpak applications read-only access to MangoHUD config
flatpak override --user --filesystem=xdg-config/MangoHud:ro
# Enable MangoHUD on all Steam games
flatpak override --user --env=MANGOHUD=1 com.valvesoftware.Steam
```

Open Steam once to create the necessary files and directory, then install Proton-GE via **ProtonUp-Qt**.
Set `Steam Settings > Compatibility > Run other titles with` to `GE-Proton`.

> [!TIP]+
>
> When you are going to play a game, enable _mangohud_ and _gamemode_ by adding the following to the launch options:
>
> ```bash
> mangohud gamemoderun %command%
> ```

### Virtualization

If you want to run virtual machines, you need to install the virtualization group and enable `libvirtd` on boot.
You can instead use Oracle VirtualBox (I haven't tested it yet though), but I prefer using [virt-manager](https://virt-manager.org/)
because it is more integrated with Linux and has all the features that I need.

```bash
# more info: https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started/
# install virtualization group
sudo dnf group install virtualization

# enable libvirtd on boot
sudo systemctl enable --now libvirtd

# verify KVM kernel modules
lsmod | grep kvm
```

> [!TIP] Nested Virtualization
>
> You only have to enable nested virtualization if you want to run virtual machines inside a virtual machine. If you
> are not going to do that, you can skip this step. More information can be found on [Fedora Wiki](https://docs.fedoraproject.org/en-US/quick-docs/using-nested-virtualization-in-kvm/).
>
> > [!INFO]- Enabling nested virtualization in an Intel CPU
> >
> > First, check if your CPU supports nested virtualization:
> >
> > ```bash
> > cat /sys/module/kvm_intel/parameters/nested
> > ```
> >
> > If you see `1` or `Y`, nested virtualization is supported; if you see `0` or `N`, nested virtualization is not supported. If it is supported, run the following command to permanently enable nested virtualization.
> >
> > ```bash
> > echo 'options kvm_intel nested=1' | sudo tee -a /etc/modprobe.d/kvm.conf
> > ```
>
> > [!INFO]- Enabling nested virtualization in an AMD CPU
> >
> > First, check if your CPU supports nested virtualization:
> >
> > ```bash
> > cat /sys/module/kvm_amd/parameters/nested
> > ```
> >
> > If you see `1` or `Y`, nested virtualization is supported; if you see `0` or `N`, nested virtualization is not supported. If it is supported, run the following command to permanently enable nested virtualization.
> >
> > ```bash
> > echo 'options kvm_amd nested=1' | sudo tee -a /etc/modprobe.d/kvm.conf
> > ```

### Android Applications

I haven't used this much, but I installed [Waydroid](https://waydro.id/) to
run Android applications on my Fedora Workstation. It is a container-based
approach to boot a full Android system on a regular GNU/Linux system.

```bash
sudo dnf install waydroid
```

After installing, launch Waydroid from the applications menu and proceed with the initialization by pasting these URLs in the OTA fields:

- System OTA: https://ota.waydro.id/system
- Vendor OTA: https://ota.waydro.id/vendor

> [!IMPORTANT] Read more information from [their website](https://docs.waydro.id/usage/install-on-desktops#fedora).

### Integrating Online/Cloud File Storage Services

I use several online cloud storage services, mainly [Google Drive](https://workspace.google.com/intl/en-US/products/drive/), [OneDrive](https://www.microsoft.com/en/microsoft-365/onedrive/online-cloud-storage), and [MEGA](https://mega.io/).
GNOME has support for Microsoft 365 accounts, but MEGA is not supported natively.
As of GNOME 50, [Google Drive support has been dropped](https://discourse.gnome.org/t/google-drive-in-gnome-50/34417)
due to its dependencies being unmaintained.

To solve all these, we will use [rclone](https://rclone.org/) to mount these cloud storage services as virtual drives. This will
require some setup, but it is worth it in the end. To start, install `rclone` and run `rclone config` to
add remotes that you want to use. Refer to [rclone's documentation](https://rclone.org/docs/) for more
information on how to configure remotes. For Google Drive remotes, you most likely want to use your
own **Google API credentials** instead of the default ones provided by `rclone` as the default credentials have
a very low API quota and will most likely hit the limit if you are going to use it frequently. You can
create your own credentials by following [this guide](https://rclone.org/drive/#making-your-own-client-id).

```bash
sudo dnf install rclone
rclone config
```

After setup, we will create a systemd service to automatically mount the remotes on boot.

```bash
mkdir -p ~/.config/systemd/user
cp ~/Temp/SetupGuides-dotfiles/systemd/rclone@.service ~/.config/systemd/user/rclone@.service
```

The `rclone@.service` file is a template service that can be used to mount any remote that you have configured
in `rclone`. To use it, enable the service with the name of the remote that you want to mount. For example,
if you have a remote named `gdrive-personal`, run the following command:

```bash
systemctl --user enable --now rclone@gdrive-personal
```

Now, every time you boot your system, the `gdrive-personal` remote will be automatically mounted. You can check the status of the service with the following command:

```bash
systemctl --user status "rclone@*"
```

## Desktop Customization & Ricing

### 1. Text Editing

I use [[Text Editors/Neovim/Neovim|Neovim]] as my IDE and text editor. I recommend only customizing it thoroughly if you are going to use [Neovim](https://neovim.io/) as your main text editor.

### 2. Audio & Video Setup

Install EasyEffects, OBS Studio, and its essential plugins..

```bash
# install EasyEffects and OBS Studio
flatpak install -y flathub com.github.wwmm.easyeffects com.obsproject.Studio
sudo dnf install -y v4l2loopback  # To use OBS Studio's virtual camera feature

# Create the `plugins/` directory in OBS Studio.
mkdir -p ~/.var/app/com.obsproject.Studio/config/obs-studio/plugins
# Optional; to use smartphone as webcam (proprietary software)
flatpak install -y flathub com.obsproject.Studio.Plugin.DroidCam
```

Download and install [Composite Blur](https://obsproject.com/forum/resources/composite-blur.1780/) plugin for OBS Studio.

### 3. Configuring Nautilus

```bash
# install GNOME/Nautilus customization helpers and extensions
sudo dnf install \
    gnome-tweaks gnome-extensions-app \
    blueman-nautilus file-roller-nautilus \
    nautilus-gsconnect
```

Open Nautilus and open its preferences panel (`CTRL+,`)

- General
  - _Enable_ `Sort folders before files` option
- Optional Context Menu Actions
  - _Show_ `Create Link`
  - _Show_ `Delete Permanently`

### 4. Update XDG Directories

I want my home directory to be clean as possible. Dotfiles are everywhere, but fortunately they can be hidden in Nautilus. However, default user directories that I do not frequently visit cannot be hidden. Edit the `~/.config/user-dirs.dirs` file and move the directories to where you want to. Alternatively, you can run the following commands to move the `Desktop/`, `Templates/`, and `Public/` directories inside `~/.desktop/`.

```bash
mkdir -p ~/.desktop
mv ~/{Desktop,Templates,Public} ~/.desktop

xdg-user-dirs-update --set DESKTOP "$HOME/.desktop/Desktop"
xdg-user-dirs-update --set TEMPLATES "$HOME/.desktop/Templates"
xdg-user-dirs-update --set PUBLICSHARE "$HOME/.desktop/Public"
```

> [!NOTE]- My `xdg-user-dirs` Configuration
>
> ```bash
> # This file is written by xdg-user-dirs-update
> # If you want to change or add directories, just edit the line you're
> # interested in. All local changes will be retained on the next run.
> # Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
> # homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
> # absolute path. No other format is supported.
> #
> XDG_DESKTOP_DIR="$HOME/.desktop/Desktop"
> XDG_DOWNLOAD_DIR="$HOME/Downloads"
> XDG_TEMPLATES_DIR="$HOME/.desktop/Templates"
> XDG_PUBLICSHARE_DIR="$HOME/.desktop/Public"
> XDG_DOCUMENTS_DIR="$HOME/Documents"
> XDG_MUSIC_DIR="$HOME/Music"
> XDG_PICTURES_DIR="$HOME/Pictures"
> XDG_VIDEOS_DIR="$HOME/Videos"
>
> ```

### 5. Customizing GNOME

> See the [[Desktop Environments/GNOME/GNOME|GNOME]] customization guide.

### 6. Setting Up Ptyxis

[Ptyxis](https://gitlab.gnome.org/chergert/ptyxis) is the new terminal of Fedora operating system. Unlike the old [gnome-terminal](https://help.gnome.org/gnome-terminal/) where we had to install [catppuccin/gnome-terminal](https://github.com/catppuccin/gnome-terminal), theming it is much easier now.

Just open **Preferences**, expand the palette grid by clicking the "Show All Palettes" button at the top right corner, and selecting **Catppuccin Mocha**. I also prefer an I-Beam so just at the bottom of the same panel, you can see `Cursor > Cursor Shape` and set it to _I-Beam_. Also disable **Use System Font** and set it to `JetBrainsMono Nerd Font Mono Regular` with size 10.

### 7. Language & Input Methods

Open Settings and go to `Keyboard > Input Sources`. Add the following languages:

- Japanese (Anthy)
- Korean (Hangul)

You can now write Japanese and Korean by switching to these languages using `WIN+SPACE`.

## Back-Up Strategy

I use [backrest](https://github.com/garethgeorge/backrest) to perform automatic backups of my system.

> [!QUESTION] Why use backrest?
>
> **Backrest** uses [restic](https://restic.net/) under the hood to perform backups. This means
> that in a situation where I need to restore specific files or directories,
> I can do so using the `restic` command line tool. Also, I can move
> restic repositories anywhere I want.

### Setting Up Backrest

First, install Backrest in your machine by following their [installation guide](https://github.com/garethgeorge/backrest#linux--macos-recommended).

```bash
curl -fsSL https://raw.githubusercontent.com/garethgeorge/backrest/main/install.sh | bash
systemctl status backrest.service  # Check if the service is installed and running
```

If `systemctl` reports it as running, you should be able to access it in [http://localhost:9898](http://localhost:9898).
You may now add a new backup repository and configure it to your liking.
You can also check the [Backrest documentation](https://garethgeorge.github.io/backrest/introduction/getting-started) for more information.

## Optional Modifications

### Replace `systemd-oomd` with `earlyoom`

I have experienced many out-of-memory scenarios during my use of Fedora Workstation. For some reason, `systemd-oomd` never kicked in to kill the culprit that's hogging the system memory. However, `earlyoom` has saved me (and my unsaved works and hundreds of Firefox tabs) numerous times so you might want to switch as well.

> [!NOTE] Technical Explanation
>
> The two daemons operate differently:
>
> > [!INFO]+ systemd-oomd
> >
> > "The primary mechanism used by `systemd-oomd` for detecting when the system is out of memory is memory pressure. **Memory pressure** measures the percentage of time a cgroup has “wasted” due to lack of memory. This includes time spent reclaiming free memory, faulting in recently resident pages, and loading in anonymous pages from swap.
> >
> > When a monitored cgroup’s memory pressure exceeds the specified thresholds, `systemd-oomd` will perform action(s) on the targeted cgroup’s descendants, starting from the cgroups with the most reclaim scans. **Reclaim activity** is used here, rather than the largest consumer, as it reflects values set in the cgroup memory controller for memory protection (such as memory.low). "
>
> \- [Changes/EnableSystemdOomd - Fedora Project Wiki](https://fedoraproject.org/wiki/Changes/EnableSystemdOomd)
>
> > [!INFO]+ earlyoom
> >
> > "`earlyoom` checks the amount of available memory and free swap up to 10 times a second (less often if there is a lot of free memory)."
>
> \- [GitHub - rfjakob/earlyoom: earlyoom - Early OOM Daemon for Linux · GitHub](https://github.com/rfjakob/earlyoom)

To use `earlyoom` instead of `systemd-oomd`, you will have to first install `earlyoom`, and then enable it.

```bash
sudo dnf install earlyoom                         # 1. Install earlyoom
```

`earlyoom` is now installed, and we need to adjust its configuration. Open `/etc/default/earlyoom` and change the variables to the following:

| Variable        | Value                                                                                                 |
| --------------- | ----------------------------------------------------------------------------------------------------- |
| `EARLYOOM_ARGS` | Append `-n` to the existing arguments to send notifications to the user when `earlyoom` is triggered. |

```bash
sudo systemctl enable --now earlyoom.service      # 2. Enable and start earlyoom
```

Now, to avoid conflicts, we need to disable `systemd-oomd`.

```bash
sudo systemctl disable --now systemd-oomd.service # 3. Stop and disable systemd-oomd
sudo systemctl disable --now systemd-oomd.socket  # 4. Disable systemd-oomd's socket as well.
sudo systemctl mask systemd-oomd.socket           # 5. Mask systemd-oomd so that it won't start again.
```

Finally, make sure that `earlyoom` is running and `systemd-oomd` has stopped.

```bash
systemctl status earlyoom.service \               # 6. Make sure earlyoom daemon is running,
    systemd-oomd.service \                        #    systemd-oomd has stopped,
    systemd-oomd.socket                           #    and its socket masked.
```

### Remote Connections

If you want to connect to your Fedora Workstation remotely, you can enable Remote Control and/or SSH.

#### Remote Control (RDP)

1. Open Settings and go to `System > Remote Desktop`.
2. Enable `Desktop Sharing` and `Remote Control`. Change the login credentials as you wish.

#### Secure Shell (SSH)

1. Open Settings and go to `System > Secure Shell`. Toggle the switch to "ON".
2. Run the following command to secure your SSH server:

> [!CAUTION]
>
> Change `Port` to something you want.

```bash
printf "Port 2222\nPermitRootLogin no\nPubkeyAuthentication yes\nPasswordAuthentication no" | sudo tee /etc/ssh/sshd_config.d/10-custom.conf
sudo systemctl restart sshd.service
```

## Customization Done

And with that, you have a fully customized Fedora Workstation installation. You can now remove the `~/Temp/SetupGuides-dotfiles`
directory if you want to free up some space.

You can now enjoy your new operating system with all the tools and applications you need.
Every person has their own preferences, so feel free to explore and customize your system further to suit your needs.
