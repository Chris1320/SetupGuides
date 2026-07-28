---
title: Fedora Workstation
description: My Fedora Workstation configuration
draft: false
tags:
  - linux/distro
---
# Fedora Workstation

This is a guide on how I customize my Fedora installation. [Fedora Workstation](https://fedoraproject.org/) is a great operating system if you want something between a beginner-friendly Linux distribution (e.g., [Linux Mint](https://linuxmint.com/)) and a highly customizable and experimental distro (e.g., [Arch Linux](https://archlinux.org/)).

> [!WARNING] This guide is still in beta.

## Installation

> [!NOTE] This guide is tested on **Fedora Workstation 44**.

### Installing Fedora Workstation

1. Download the ISO image from [fedoraproject.org](https://fedoraproject.org/workstation/download/).
2. Restart your system into the Fedora Workstation Live USB.
3. Follow the on-screen instructions to install Fedora Workstation into your machine.
4. Restart the machine.
5. Follow the on-screen instructions.

> [!WARNING]
> 
> **Do not** enable third-party repositories when asked. We are going to manually enable it when we [[#2. Configure Package Managers|configure our package managers]].

### Setting Up The System

Open the terminal and follow the instructions.

#### 1. Set the Machine Hostname

There are two ways to do this. We can change the system hostname normally

```bash
hostnamectl hostname <YOUR_DESIRED_HOSTNAME>
```

or specify different *static* and *pretty* hostnames

```bash
hostnamectl hostname --static <YOUR_DESIRED_STATIC_HOSTNAME>
hostnamectl hostname --pretty <YOUR_DESIRED_PRETTY_HOSTNAME>
```

> [!INFO] Run `man hostnamectl` for more information.

#### 2. Configure Package Managers

Edit DNF's configuration file to make it faster in general. I also added some settings that I find convenient.

```bash
echo 'defaultyes=True' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=True' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
```

Since we did not enable the *Third-Party Repositories* when we were asked earlier, we manually add [RPMFusion](https://rpmfusion.org/) and [Flathub](https://flathub.org/)'s remotes.

```bash
# Enable RPMFusion repositories
sudo dnf install \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager enable fedora-cisco-openh264
sudo dnf group ugrade core

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

#### 3. Update Your System

Regardless of the operating system you use, it is a good practice to update your software after installing the new system.

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

#### 4. Install Utilities

```bash
# install essential CLI utilities and libraries
sudo dnf install \
	git git-lfs gh \
	mc unrar 7zip-standalone-all \
    file-roller dmg2img trash-cli tmux \
    openssl inxi wl-clipboard

# development tools
sudo dnf install uv python3-pip gcc golang

# install Fast Node Manager
curl -fsSL https://fnm.vercel.app/install | bash
cat ~/.bash_profile | tail -n 6 >> ~/.config/zsh/user_env.sh
fnm install --latest --use  # install and use latest version of Node

# install Bun
curl -fsSL https://bun.sh/install | bash
cat ~/.bash_profile | tail -n 3 >> ~/.config/zsh/user_env.sh

bun install --global firebase-tools @charmland/crush
flatpak install flathub com.visualstudio.code

# install GNOME/Nautilus customization helpers and extensions
sudo dnf install \
    gnome-tweaks gnome-extensions-app \
    blueman-nautilus file-roller-nautilus \
    nautilus-gsconnect

# use full ffmpeg package
sudo dnf swap ffmpeg-free ffmpeg --allowerasing

# install multimedia codecs
sudo dnf install -y @multimedia @sound-and-video \
	gstreamer1-plugins-{bad-\*,good-\*,base} \
	gstreamer1-plugin-openh264 mozilla-openh264 \
	gstreamer1-libav lame\* \
	--exclude=gstreamer1-plugins-bad-free-devel,lame-devel
sudo dnf group install multimedia

# install flatseal
flatpak install -y flatseal
```

Install other utilities that I frequently use/nice to have.

```bash
sudo dnf install tealdeer
uv tool install yt-dlp
uv tool install jupyterlab
flatpak install flathub com.bitwarden.desktop
flatpak install flathub md.obsidian.Obsidian
flatpak install org.cryptomator.Cryptomator
```

#### 5. Language

Open Settings and go to `Keyboard > Input Sources`. Add the following languages:

- Japanese (Anthy)
- Korean (Hangul)

You can now write Japanese and Korean by switching to these languages using `WIN+SPACE`.

#### 6. Replacing the Default Browser

I have been using Firefox on all of my machines for more than 6 years, and I did not have any major problems about it.

```bash
sudo dnf install firefox
```

I also use a backup browser as a fallback, [Microsoft Edge](https://explore.microsoft.com/en-us/edge), which is available as a flatpak.

```bash
flatpak install flathub com.microsoft.Edge
```

#### 7. Discord

I use [Discord](https://discord.com/) via [Vesktop](https://github.com/Vencord/Vesktop) instead of the [official Flatpak](https://flathub.org/apps/com.discordapp.Discord) because it fixes screensharing and it also already comes with [Vencord](https://vencord.dev/) pre-installed.

```bash
flatpak install flathub dev.vencord.Vesktop
```

Open *Flatseal*, select *Vesktop*, and in the `Portals` section, enable the following:

- Background
- Notifications

> [!TIP]- Enabling Discord Rich Presence
> 
> In *Flatseal*, go to `Vesktop > Filesystem > Other files` section, add the following entries:
> 
> ```text
> xdg-run/.flatpak/dev.vencord.Vesktop:create
> xdg-run/discord-ipc-*
> ```
> 
> Create a symlink of the latter pointing to the former.
> 
> You can read more information on [flathub/dev.vencord.Vesktop](https://github.com/flathub/dev.vencord.Vesktop#discord-rich-presence).

### Ricing Your New System

> [!QUESTION] Prerequisites
> 
> I recommend that you use the following customization
> guides first:
>
> - [[ZSH]]
> - [[Neovim]] (recommended only if you are going to use [Neovim](https://neovim.io/) as your main text editor)

#### 1. Setting Up Audio And Video

Install EasyEffects, OBS Studio, and its essential plugins..

```bash
# install EasyEffects and OBS Studio
flatpak install flathub com.github.wwmm.easyeffects com.obsproject.Studio
sudo dnf install v4l2loopback  # To use OBS Studio's virtual camera feature

# Create the `plugins/` directory in OBS Studio.
mkdir -p ~/.var/app/com.obsproject.Studio/config/obs-studio/plugins
# Optional; to use smartphone as webcam (proprietary software)
flatpak install flathub com.obsproject.Studio.Plugin.DroidCam
```

Download and install [Composite Blur](https://obsproject.com/forum/resources/composite-blur.1780/) plugin for OBS Studio.

#### 2. Configuring Nautilus

Open Nautilus and open its preferences panel (`CTRL+,`)

- General
	- *Enable* `Sort folders before files` option
- Optional Context Menu Actions
	- *Show* `Create Link`
	- *Show* `Delete Permanently`

#### 3. Update XDG Directories

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

#### 7. Customizing GNOME

> See the [[GNOME]] customization guide.

#### 8. Setting Up Ptyxis

[Ptyxis](https://gitlab.gnome.org/chergert/ptyxis) is the new terminal of Fedora operating system. Unlike the old [gnome-terminal](https://help.gnome.org/gnome-terminal/) where we had to install [catppuccin/gnome-terminal](https://github.com/catppuccin/gnome-terminal), theming it is much easier now.

Just open **Preferences**, expand the palette grid by clicking the "Show All Palettes" button at the top right corner, and selecting **Catppuccin Mocha**. I also prefer an I-Beam so just at the bottom of the same panel, you can see `Cursor > Cursor Shape` and set it to *I-Beam*. Also disable **Use System Font** and set it to `JetBrainsMono Nerd Font Regular` with size 10.

### Installing The Rest

### Running Windows Software and Gaming

```bash
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.usebottles.bottles
flatpak install flathub org.freedesktop.Platform.VulkanLayer.MangoHud
flatpak install flathub net.davidotek.pupgui2
sudo dnf install gamemode

# Enable Steam Proton Integration
flatpak override --user com.usebottles.bottles --filesystem=~/.var/app/com.valvesoftware.Steam/data/Steam
# Grant all flatpak applications read-only access to MangoHUD config
flatpak override --user --filesystem=xdg-config/MangoHud:ro
# Enable MangoHUD on all Steam games
flatpak override --user --env=MANGOHUD=1 com.valvesoftware.Steam
```

Install Proton-GE. Set `Steam Settings > Compatibility > Run other titles with` to `GE-Proton`.

> [!TIP]+
> 
> When you are going to play a game, enable *mangohud* and *gamemode* by adding the following to the launch options:
> 
> ```bash
> mangohud gamemoderun %command%
> ```

### Setting Up Virtualization

```bash
# more info: https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started/
# install virtualization group
sudo dnf group install virtualization

# enable libvirtd on boot
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

# verify KVM kernel modules
lsmod | grep kvm
```

> [!TIP] Nested Virtualization
> 
> More information can be found on [Fedora Wiki](https://docs.fedoraproject.org/en-US/quick-docs/using-nested-virtualization-in-kvm/).
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

### Running Android Applications

```bash
sudo dnf install waydroid
```
