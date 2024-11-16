# Customization

Now that you have a new Arch Linux system, we will now start performing customizations in it.

## Installing An AUR Helper

[Install Paru](https://github.com/Morganamilo/paru). This is the AUR helper that we will use.

```bash
# Install the latest stable version of Rust
sudo pacman -S --needed rustup
rustup toolchain install stable

# Clone the repo in a temp directory.
export PARU_TMP_DIR=$(mktemp -d)
git clone https://aur.archlinux.org/paru.git "${PARU_TMP_DIR}/paru"

# build and install paru.
cd "${PARU_TMP_DIR}/paru"
makepkg -si

# Go back home and remove the created temp directory.
cd ~
rm -rf $PARU_TMP_DIR
unset $PARU_TMP_DIR
```

## Downloading the Dotfiles

Clone the [Chris1320/SetupGuides-dotfiles](https://github.com/Chris1320/SetupGuides-dotfiles) and [Chris1320/SetupGuides-ArchLinux](https://github.com/Chris1320/SetupGuides-ArchLinux) repositories.

```bash
mkdir ~/Temp

git clone https://github.com/Chris1320/SetupGuides-dotfiles.git ~/Temp/SGDotfiles
git clone https://github.com/Chris1320/SetupGuides-ArchLinux.git ~/Temp/ArchLinuxDotfiles

cd ~/Temp/ArchLinuxDotfiles
git submodule init    # Initialize git submodules
git submodule update  # Pull submodules from remote
git lfs pull          # Download LFS files
```

## Custom Fonts and Icons

We are going to use the following fonts and icons, so it's best to install them now.

- **Primary Fonts**: `ttf-jetbrains-mono-nerd ttf-noto-nerd noto-fonts-cjk ttf-opensans noto-fonts otf-apple-fonts`
- **Primary Icons**: `papirus-icon-theme papirus-folders-catppuccin-git`
- **Icon Fonts**: `otf-font-awesome ttf-material-icons-git`
- **Cursor Icons**: `catppuccin-cursors-mocha`

```bash
paru -Syu ttf-jetbrains-mono-nerd ttf-noto-nerd noto-fonts-cjk \
    ttf-opensans noto-fonts otf-apple-fonts \
    papirus-icon-theme papirus-folders-catppuccin-git \
    otf-font-awesome ttf-material-icons-git \
    catppuccin-cursors-mocha
```

## Useful Packages

### Essential System Utilities

Install these packages to ensure that the system will work properly.

```bash
paru -S acpid avahi dkms net-tools
systemctl enable \
    acpid.service \
    avahi-daemon.service \
    systemd-timesyncd.service
```

### Input Devices

Some peripherals require these packages to work properly.

```bash
paru -S xf86-input-synaptics xf86-input-libinput xf86-input-evdev
```

> [!TIP]- Additional Package to Install on Virtual Machines
> 
> ```bash
> paru -S xf86-input-vmmouse
> ```

### Audio and Video

PipeWire is now superseding PulseAudio when it comes to handling audio and video streams on Linux systems. We are going to install it on our system.

```bash
paru -S pipewire pipewire-audio pipewire-pulse lib32-pipewire \
	alsa-utils pipewire-jack wireplumber \
	gst-libav gst-plugins-base \
	gst-plugins-{good,bad,ugly} gstreamer-vaapi \
	ffmpeg easyeffects playerctl \
	x265 x264 lame
```

> [!NOTE] PipeWire and The Whole Setup
> 
> The dotfiles are configured to manipulate audio and video via PipeWire as well. It is **not recommended** to not use PipeWire, because you will have to change a lot of scripts.

Read more at [Arch Linux Wiki > PipeWire](https://wiki.archlinux.org/title/PipeWire).

### Bluetooth Support

```bash
paru -S bluez bluez-utils blueman
systemctl enable bluetooth.service
systemctl start bluetooth.service
```

I also install required Bluetooth drivers in this part, if necessary. For example, my laptop has Broadcom devices, so I also install `broadcom-bt-firmware` from the AUR via `paru`.

### Printer Support

These are needed to enable printing in our machine.

```bash
paru -S system-config-printer sane \
    foomatic-db foomatic-db-engine \
    gutenprint gsfonts \
    cups cups-pdf cups-filters
systemctl enable cups.service saned.socket
```

### Enable TRIM for SSDs

```bash
systemctl enable fstrim.timer
```

### Must-Have Programs

These are packages that I always keep in my machine installed. Some of these packages, such as `btop`, `socat`, and `jq` are also required by the customization steps below.

```bash
paru -S tar unzip unrar p7zip zip xz rclone rsync trash-cli \
    nfs-utils cifs-utils ntfs-3g exfat-utils gvfs udisks2 \
    pfetch btop socat jq yt-dlp tealdeer
```

#### Midnight Commander

Sometimes, I don't want to use Nautilus to navigate the filesystem... Definitely not because I messed up my system and now GUI programs don't work. Midnight Commander is a terminal-based file manager that can be used via keyboard.

Optionally, you can install it and copy the dotfiles.

```bash
paru -S mc
cp -r ~/Temp/SGDotfiles/mc ~/.config/mc
```

#### Flatpak

I use many [Flatpak](https://www.flatpak.org/) applications, so installing it is a must for me.

```bash
paru -S flatpak
flatpak install flathub com.github.tchx84.Flatseal  # Install FlatSeal to manage Flatpaks
```

#### Development Tools

I use my machine for software development so I install compilers and interpreters on my system.

```bash
# Install C/C++, .NET, and Python development tools
paru -S gcc dotnet-sdk python python-pip python-pipx
pipx install poetry jupyterlab

# Install Node Version Manager and the latest NodeJS version
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh" | bash
# Move new lines from .zshrc to user_env.sh and restart the terminal
nvm install node

# Install Java Development Kit and PHP development tools
paru -S jdk-openjdk php composer

# Android tools
paru -S android-tools android-udev
usermod -aG adbusers "$(whoami)"

# Other useful stuff
pipx install howdoi magika
```

##### Neovim

[[Neovim]] is the best text editor and IDE on Linux btw (fight me). If I installed the packages from the [[#Development Tools]] section, might as well use Neovim to write code. We'll have to install some packages that are required by the plugins first.

```bash
paru -S neovim tree-sitter tree-sitter-cli
# Customize Neovim using my Neovim dotfiles
bash <(curl -sSf https://raw.githubusercontent.com/Chris1320/SetupGuides-Neovim/main/install)
```

##### Visual Studio Code

Sometimes, there are things that I cannot do on Neovim, such as Live Share/Pair Programming with classmates on coding sessions. Because of this, I have to use Visual Studio Code. I use the Flatpak version because it's what I use on my Fedora Workstation system.

```bash
flatpak install flathub com.visualstudio.code
```

#### Image and Video Viewers

I use [Mpv](https://mpv.io/) and [imv](https://sr.ht/~exec64/imv/) to view videos and images respectively.

With Mpv, we are going to use [tomasklaen](https://github.com/tomasklaen)'s [uosc](https://github.com/tomasklaen/uosc) config. These plugins are also used:

- [po5/evafast](https://github.com/po5/evafast): Mpv script for hybrid fast-forward and seeking.
- [rofe33/mpv-copyStuff](https://github.com/rofe33/mpv-copyStuff): Copy to clipboard the filename, full filename path, relative filename path, current video time, current displayed subtitle text, video duration/metadata.

```bash
paru -S imv mpv
cp -r ~/Temp/SGDotfiles/mpv ~/.config/mpv
```

## Setting Up SDDM

SDDM will be the display manager that our setup will use. It will be your
"login screen". Install and enable the SDDM service to start the display
manager on boot.

```bash
paru -S sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg
systemctl enable sddm.service
```

I use [Keyitdev](https://github.com/Keyitdev)'s [sddm-astronaut-theme](https://github.com/Keyitdev/sddm-astronaut-theme)
as my SDDM theme. Clone their SDDM configuration files to their designated
locations. I also changed the wallpaper included in their repository, so
we'll have to copy that from `~/Temp/ArchLinuxDotfiles` as well.

> [!NOTE]
>
> Make sure that git submodules are pulled before attempting to copy the files from `./dotfiles/sddm/sddm-astronaut-theme` directory.
>
> ```bash
> git submodule update --init --recursive --remote
> ```

```bash
sudo cp -r ./dotfiles/sddm/sddm-astronaut-theme /usr/share/sddm/themes/sddm-astronaut-theme
sudo mkdir -p /etc/sddm.conf.d
sudo cp -r ./dotfiles/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf
printf '[General]\nInputMethod=qtvirtualkeyboard' | sudo tee /etc/sddm.conf.d/virtualkbd.conf

sudo mkdir -p /usr/share/wallpapers
sudo cp "./assets/wallpapers/<your desired wallpaper>" /usr/share/wallpapers/sddm-bg
```

> [!TIP] Currently, I use `5am_Train_1920x1080.jpg` as my SDDM background.

Edit the `/usr/share/sddm/themes/sddm-astronaut-theme/Themes/theme1.conf` file
and change the following lines:

| Key            | Value                           |
| -------------- | ------------------------------- |
| `Background`   | `/usr/share/wallpapers/sddm-bg` |
| `FormPosition` | `left`                          |

Related Links:

- [Arch Linux Wiki > SDDM](https://wiki.archlinux.org/title/SDDM)
- [GitHub - Keyitdev/sddm-astronaut-theme: Modern looking sddm qt6 theme.](https://github.com/Keyitdev/sddm-astronaut-theme)

## Setting Up Hyprland

[Hyprland](https://hyprland.org/) will be our tiling compositor. I chose this over other DEs/WMs because it is easy to configure, has beautiful animations, and I really like its dynamic tiling. To start, install Hyprland by running the following command:

```bash
paru -S hyprland hyprpaper \
	brightnessctl fcitx5 \
	grim slurp swappy \
	polkit-gnome gnome-keyring \
	seahorse libsecret \
	nm-connection-editor \
	network-manager-applet \
	wl-clipboard cliphist \
	pavucontrol
```

> [!TIP] If you ever need help, Hyprland has their own wiki, so [read it](https://wiki.hyprland.org/Getting-Started/Master-Tutorial/)!

To start customizing Hyprland, just copy the dotfiles to `~/.config/`. Running Hyprland at this time is **not yet recommended** since we haven't customized the rest of the programs yet.

```bash
# Make sure you're still at the repository's root directory
cp -r ./dotfiles/hypr ~/.config/hypr
cp -r ./scripts ~/.config/scripts
```

Also copy your desired background image to `~/.config/background`.

```bash
cp "./assets/wallpapers/<your desired wallpaper>" ~/.config/background
# I personally use `evening-sky.png` as my wallpaper.
```

Now, Hyprland's configuration files are in place, but we still need to configure
the rest of the system for it to function properly.

> [!BUG] If you are having problems with Hyprland, see their [wiki](https://wiki.hyprland.org/Crashes-and-Bugs/).

### GTK Theme

Currently, this setup uses the [Everforest GTK theme](https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme).

```bash
paru -S everforest-gtk-theme-git gtk-engine-murrine
```

### Hyprcursors

Hyprland's author introduced a new cursor theme format, called _Hyprcursor_.
It is supposed to be a more efficient and faster cursor theme format. The Catppuccin cursors are already set up in Hyprland's config file, so we just need to update `gsettings` with the appropriate settings.

Run the following script and select/enter your preferred cursor and cursor size (I use the defaults).

```bash
~/.config/scripts/set-cursor.sh
```

## Setting Up Kitty

Kitty is my terminal emulator of choice. Install it via `paru` to begin.

```bash
paru -S kitty
```

Since [June 3, 2024](https://github.com/Chris1320/SetupGuides-ArchLinux/commit/edd1e5b5ea67c42c4da9cbb9d754c025210c652d), I moved dotfiles that are used across multiple operating systems to a separate repository. Because of this, the dotfiles for Kitty is not on [SetupGuides-ArchLinux](https://github.com/Chris1320/SetupGuides-ArchLinux), but rather on [SetupGuides-dotfiles](https://github.com/Chris1320/SetupGuides-dotfiles). You will have to clone the repository where it is located, copy the Kitty configuration file, and enable the Catppuccin colorscheme.

```bash
mkdir -p ~/.config/kitty
cp -r ~/Temp/SGDotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
kitty +kitten themes --reload-in=all Catppuccin-Mocha
```

> [!NOTE] You now have two SetupGuides repositories on your `~/Temp` directory.

### Setting Up ZSH

See [[ZSH]] for more information.

### Setting Up GPG and SSH

If you have an existing GPG and SSH keys, you can now start restoring them to your new system.

#### Importing Your GPG keys

First, import your GPG private key.

```bash
gpg --import your_gpg_key.gpg
```

Next, edit the key and trust it ultimately. You'll have to get the key ID first.

```bash
# List secret keys and show their key IDs.
gpg --list-secret-keys --keyid-format=SHORT
# Edit the key
gpg --edit-key <THE KEY ID>
# gpg> trust
# ...
# Your decision? 5
# Do you really want to set this key to ultimate trust? (y/N) y
# gpg> quit
```

##### Using GNOME Keyring as Secrets Manager

Use GNOME 3 pinentry when asking for GPG password. Edit `~/.gnupg/gpg-agent.conf` and insert the following line:

```text
pinentry-program /usr/bin/pinentry-gnome3
```

#### Importing Your SSH keys

First of all, you have to install OpenSSH.

```bash
paru -S openssh
```

Copy your private and public keys to `~/.ssh`, and adjust the permissions.

```bash
# Create ~/.ssh if it does not exist.
mkdir -p ~/.ssh

# Copy the public and private keys to the newly-created directory.
# Example 1: ED25519 keys
cp ~/Downloads/your_ed25519_ssh_key ~/.ssh/id_ed25519
cp ~/Downloads/your_ed25519_ssh_key.pub ~/.ssh/id_ed25519.pub
# Example 2: RSA keys
cp ~/Downloads/your_rsa_ssh_key ~/.ssh/id_rsa
cp ~/Downloads/your_rsa_ssh_key.pub ~/.ssh/id_rsa.pub

# Adjust permissions
chmod 600 ~/.ssh/*
chmod 700 ~/.ssh
```

#### Configuring SSH

You can also add a host configuration block in `~/.ssh/config` so that you can clone repositories using a shorter command.

```text
Host gh
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
```

If you add this line, all you have to do when cloning GitHub repositories is to
run `git clone gh:username/repo.git`. Make sure that you've set up your GitHub
account correctly first.

You can test your setup by running the command

```bash
ssh -T gh
```

It should print out something like this:

```text
Hi Chris1320! You've successfully authenticated, but GitHub does not provide shell access.
```

##### Using GNOME Keyring as Secrets Manager

```bash
systemctl enable --user gcr-ssh-agent.socket
systemctl start --user gcr-ssh-agent.socket
```

### Git

```bash
paru -S github-cli
git config --global credential.helper /usr/lib/git-core/git-credential-libsecret
```

## Setting Up Waybar

Waybar is a status bar for Wayland compositors. We will use it to show basic information about our machine at the top of our screen. Install it and copy its configuration file to its designated location.

```bash
paru -S waybar
cp -r ./dotfiles/waybar ~/.config/waybar
```

## Setting Up dunst

Dunst is a lightweight notification daemon for Linux and Unix-like operating systems. It is highly customizable, allowing us to adjust its appearance, behavior, and the types of notifications it handles.

To start, install `dunst` and copy its configuration file.

```bash
paru -S dunst libnotify
mkdir -p ~/.config/dunst
cp ./dotfiles/dunst/dunstrc ~/.config/dunst/dunstrc
```

### Battery Level Notifications

To enable battery level notifications, install `batsignal`, copy its dotfiles to its designated directory, and enable the service.

```bash
paru -S batsignal
cp -r ~/Temp/ArchLinuxDotfiles/batsignal ~/.config/batsignal
systemctl --user enable batsignal.service
```

## Setting Up Rofi

Rofi will be our launcher and interface for window switching, emoji panel, clipboard history panel, and much much more. Install it and copy its dotfiles to its designated locations.

```bash
paru -S rofi-wayland rofimoji
cp -r ./dotfiles/rofi ~/.config/rofi
```

## Setting Up Hyprlock

```bash
paru -S hyprlock
```

Since we've [[Setting Up Hyprland|set up Hyprland]], we wouldn't need any additional setup.

## Setting Up The Browsers

```bash
paru -S firefox brave-bin torbrowser-launcher
```

## Ricing Up GRUB

Our whole system mostly uses the [Catppuccin](https://catppuccin.com/) colorscheme, so we're going to use [Catppuccin's GRUB theme](https://github.com/catppuccin/grub) to rice our bootloader.

First, clone the `catppuccin/grub` repository and copy the themes to `/usr/share/grub/themes`.

```bash
git clone https://github.com/catppuccin/grub.git ~/Temp/grub && cd ~/Temp/grub
sudo cp -r src/* /usr/share/grub/themes/
```

Edit `/etc/default/grub` and edit the `GRUB_THEME` variable (uncomment if needed).

```toml
GRUB_THEME="/usr/share/grub/themes/catppuccin-mocha-grub-theme/theme.txt"
```

Save the file and update GRUB's configuration by running:

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

> [!TIP] You can now remove the cloned repository.
>
> ```bash
> cd ~ && rm -rf ~/Temp/grub
> ```

> [!ERROR] If you are having problems with theming GRUB, you can read the FAQs section in [catppuccin/grub](https://github.com/catppuccin/grub?tab=readme-ov-file#-faq).

## Final Touches

```bash
paru -S localsend-bin
```

---

- Previous: [[Automatic Customization]]
