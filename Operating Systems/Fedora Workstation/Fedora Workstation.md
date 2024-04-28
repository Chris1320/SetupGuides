---
title: Fedora Workstation
description: My Fedora Workstation configuration
draft: false
tags:
  - linux/distro
---
# Fedora Workstation

This is a guide on how I customize my Fedora installation. [Fedora Workstation](https://fedoraproject.org/) is a great operating system if you want something between a beginner-friendly Linux distribution (e.g., [Linux Mint](https://linuxmint.com/)) and a highly customizable and experimental distro (e.g., [Arch Linux](https://archlinux.org/)).

> [!WARNING] This guide is not yet complete and might break your system.

## Installation

> [!NOTE] This guide is tested on Fedora Workstation 40, but it should also work on Fedora Workstation 39.

### Installing Fedora Workstation

1. Download the ISO image from [fedoraproject.org](https://fedoraproject.org/workstation/download/).
2. Restart your system into the Fedora Workstation Live USB.
3. Follow the on-screen instructions to install Fedora Workstation into your machine.

   > [!TIP]- Language Settings
   > 
   > I personally use the `WIN+SPACE` keymap to switch between languages to keep the same keybindings with Windows. I only have one language chosen:
   >
   > - English (US)
   > 
   > The rest are added later in the customization part of the guide.

4. Restart the machine.
5. Follow the on-screen instructions.

> [!WARNING]
> 
> **Do not** enable third-party repositories when asked.

### Setting Up The System

Open the terminal and follow the instructions.

#### 1. Set the Machine Hostname

There are two ways to do this:

```bash
# change the system hostname normally
hostnamectl hostname <YOUR_DESIRED_HOSTNAME>

# or specify different static and pretty hostnames
hostnamectl hostname --static <YOUR_DESIRED_STATIC_HOSTNAME>
hostnamectl hostname --pretty <YOUR_DESIRED_PRETTY_HOSTNAME>
```

Run `man hostnamectl` for more information.

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
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264
sudo dnf groupupdate core

# Enable Flathub remote
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

More setup information can be found in the following links:

- [RPMFusion](https://rpmfusion.org/Configuration)
- [Flathub](https://flathub.org/setup/Fedora)

> [!TIP]
> 
> Verify the results by checking the outputs of the following commands:
> 
> ```bash
> cat /etc/dnf/dnf.conf
> dnf repolist
> flatpak remotes
> ```

#### 3. Update Your System

Regardless of the operating system you use, it is a good practice to update the software installed after installing your new system.

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

> [!INFO] A reboot is recommended after update.

#### 4. Install Utilities

```bash
# install essential CLI utilities and libraries
sudo dnf install \
	git git-lfs gh p7zip p7zip-gui \
    file-roller dmg2img trash-cli \
    openssl inxi wl-clipboard \
    python3-pip pipx

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
sudo dnf group upgrade --with-optional Multimedia

# install flatseal
flatpak install -y flatseal
```

### Ricing Your New System

> [!TIP]
> 
> I recommend that you use the following customization
> guides first:
>
> - [catppuccin/gnome-terminal](https://github.com/catppuccin/gnome-terminal)
> - [[ZSH]]
> - [[Neovim]] (recommended only if you are going to use [Neovim](https://neovim.io/) as your main text editor)

#### 1. Replace Firefox Stable with Firefox Nightly

I have been using Firefox Nightly in my Windows machine for more than 4 years to get the latest features and fixes, and I did not have any major problems about it. I don't think it hurts to use Firefox Nightly than Firefox Stable, plus I get that good-looking blue Firefox icon.

```bash
# Download the archive and extract its contents to ~/.local/share/firefox-nightly
wget -O ~/Downloads/FirefoxNightly.tar.bz2 "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US"
sudo tar -xf ~/Downloads/FirefoxNightly.tar.bz2 --one-top-level=~/.local/share/firefox-nightly --strip-components=1

# OPTIONAL: move old Firefox data to trash
trash ~/.mozilla

# OPTIONAL: install speech-dispatcher for text-to-speech support
sudo dnf install speech-dispatcher

# run Firefox Nightly once to set it as default browser. You can now also configure it at this point or restore an existing profile backup.
~/.local/share/firefox-nightly/firefox

# remove Firefox stable
sudo dnf remove firefox
```

Add the desktop shortcut to the applications list by running `sudo desktop-file-install firefox-nightly.desktop` and create a symlink of the Firefox executable to `~/.local/bin/`.

#### 2. Setting Up Audio And Video

Install EasyEffects.

```bash
flatpak install flathub com.github.wwmm.easyeffects
```

### Others

```bash
sudo dnf install python3-pip pipx tealdeer
pipx install howdoi yt-dlp magika
flatpak install flathub org.keepassxc.KeePassXC
flatpak install flathub md.obsidian.Obsidian
```

Nautilus:

- Sort folders before files
- Create Link
- Delete Permanently

update xdg dirs

#### 7. Customizing GNOME

> See the [[GNOME]] customization guide.

### Installing The Rest

#### Discord

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
> You can read more information on [flathub/dev.vencord.Vesktop](https://github.com/flathub/dev.vencord.Vesktop#discord-rich-presence).

### Running Windows Software and Gaming

```bash
flatpak install flathub com.valvesoftware.Steam
flatpak install com.valvesoftware.Steam net.lutris.Lutris
```

Open Lutris and go to settings

- `Interface > Use dark theme`: *Enabled*
- `Interface > Enable Discord Rich Presence for Available Games`: *Enabled*
- `Storage > Game library`: `~/.local/share/lutris`
- `Storage > Installer cache`: `~/.cache/lutris`

### Setting Up Virtualization

```bash
# more info: https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started/
# install virtualization group
sudo dnf group install --with-optional virtualization

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