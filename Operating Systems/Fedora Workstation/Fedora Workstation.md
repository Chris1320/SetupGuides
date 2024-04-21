---
title: Fedora Workstation
description: My Fedora Workstation configuration
draft: false
tags:
  - linux
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

   > [!TIP]
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

### Customization

> [!TIP]
> 
> I recommend that you use the following customization
> guides first:
>
> - [catppuccin/gnome-terminal](https://github.com/catppuccin/gnome-terminal)
> - [[ZSH]]
> - [[Neovim]] (only if you are going to use [Neovim](https://neovim.io/) as your main text editor)

#### 1. Set the Machine Hostname

```bash
hostnamectl hostname <YOUR_DESIRED_HOSTNAME>

# or specify different static and pretty hostnames
hostnamectl hostname --static <YOUR_DESIRED_STATIC_HOSTNAME>
hostnamectl hostname --pretty <YOUR_DESIRED_PRETTY_HOSTNAME>
```

#### 2. Configure DNF and Flatpak Package Managers

```bash
echo 'defaultyes=True' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=True' | sudo tee -a /etc/dnf/dnf.conf
# echo 'fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf

# Enable RPMFusion repositories
# More Info: https://rpmfusion.org/Configuration
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264
sudo dnf groupupdate core

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

> [!TIP]
> 
> Verify the results by checking the outputs of the following commands:
> 
> ```bash
> cat /etc/dnf/dnf.conf
> dnf repolist
> flatpak remotes
> ```

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
    nautilus-gsconnect \

# multimedia codecs
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf install -y @multimedia @sound-and-video \
	gstreamer1-plugins-{bad-\*,good-\*,base} \
	gstreamer1-plugin-openh264 mozilla-openh264 \
	gstreamer1-libav lame\* \
	--exclude=gstreamer1-plugins-bad-free-devel,lame-devel
sudo dnf group upgrade --with-optional Multimedia

flatpak install -y flatseal
```

#### 6. Replace Firefox Stable with Firefox Nightly

I have been using Firefox Nightly in my Windows machine for more than 4 years to get the latest features and fixes, and I did not have any major problems about it.

```bash
# Download the archive and extract its contents to /opt/firefox-nightly
wget -O ~/Downloads/FirefoxNightly.tar.bz2 "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US"
sudo tar -xf ~/Downloads/FirefoxNightly.tar.bz2 --one-top-level=/opt/firefox-nightly --strip-components=1

# OPTIONAL: remove Firefox data
rm -rf ~/.mozilla

# run Firefox Nightly once to set it as default browser. You can now also configure it at this point or restore an existing profile backup.
/opt/firefox-nightly/firefox

# remove Firefox stable
sudo dnf remove firefox
```

#### 7. Customizing GNOME

> See the [[GNOME]] customization guide.

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
