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

- **Primary Fonts**: `ttf-jetbrains-mono-nerd ttf-noto-nerd noto-fonts-cjk ttf-opensans noto-fonts otf-apple-fonts ttf-ms-win11-auto`
- **Primary Icons**: `papirus-icon-theme papirus-folders-catppuccin-git`
- **Icon Fonts**: `otf-font-awesome ttf-material-icons-git`
- **Cursor Icons**: `catppuccin-cursors-mocha`

```bash
paru -Syu ttf-jetbrains-mono-nerd ttf-noto-nerd noto-fonts-cjk \
    ttf-opensans noto-fonts otf-apple-fonts ttf-ms-win11-auto \
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
paru -S tar unzip unrar p7zip zip xz cpio rclone trash-cli \
    dmg2img nfs-utils cifs-utils ntfs-3g exfat-utils gvfs \
    udisks2 pfetch btop socat jq inxi yt-dlp tealdeer

cp -r ~/Temp/SGDotfiles/btop ~/.config/btop
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
paru -S gcc dotnet-sdk python python-pip python-uv
uv tool install jupyterlab

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
uv tool install howdoi
uv tool install magika
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

```bash
paru -S imv mpv
cp -r ~/Temp/SGDotfiles/imv ~/.config/imv  # Copy imv config
```

There two versions of the Mpv configuration file: one for high-end devices and the other for low-end machines. If your device can handle high CPU/GPU usage for better playback quality, copy the `profile-high` directory to `~/.config/mpv`; otherwise, copy the `profile-low` directory.

```bash
cp -r ~/Temp/SGDotfiles/mpv/profile-high ~/.config/mpv  # For high-end devices
cp -r ~/Temp/SGDotfiles/mpv/profile-low ~/.config/mpv   # For low-end devices
```

With Mpv, I am using [tomasklaen](https://github.com/tomasklaen)'s [uosc](https://github.com/tomasklaen/uosc) config together with these plugins:

- [po5/evafast](https://github.com/po5/evafast): Mpv script for hybrid fast-forward and seeking.
- [rofe33/mpv-copyStuff](https://github.com/rofe33/mpv-copyStuff): Copy to clipboard the filename, full filename path, relative filename path, current video time, current displayed subtitle text, video duration/metadata.
- [po5/thumbfast](https://github.com/po5/thumbfast): High-performance on-the-fly thumbnailer script for mpv.

The config also comes with the following shaders:

- [AMD FidelityFX Super Resolution (FSR) for mpv](https://gist.github.com/agyild/82219c545228d70c5604f865ce0b0ce5): Upscales content up to 4x the original size.
- [AMD FidelityFX CAS](https://gist.github.com/agyild/bbb4e58298b2f86aa24da3032a0d2ee6): AMD FidelityFX Contrast Adaptive Sharpening (CAS) for mpv.
- [SSimDownscaler](https://gist.github.com/igv/36508af3ffc84410fe39761d6969be10): High-quality downscaling of video content. (only available on `profile-high`)
- [KrigBilateral](https://gist.github.com/igv/a015fc885d5c22e6891820ad89555637): Bilateral filter. (only available on `profile-high`)

%%
#### Music Player

Soon™️
%%

#### Document Viewer

I use [Zathura](https://github.com/pwmt/zathura) as my primary document viewer. To start, install it together with the necessary dependencies and copy the configuration file.

```bash
paru -S zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps
cp -r ~/Temp/SGDotfiles/zathura ~/.config/zathura
```

> [!QUESTION]- Which language should I select for Tesseract data?
> 
> While installing the packages, Paru asked me this:
> 
> > "*There are 128 providers available for tessdata*"
> 
> Choose the language you need for OCR. I read mostly English documents, so I chose `tesseract-data-eng`.

## Setting Up Paru and Pacman (again)

Since we have Paru now, we can configure Pacman more now. Hooks are scripts that are executed automatically at certain points during the package management process. Create the `/etc/pacman.d/hooks` directory by running the following command:

```bash
sudo mkdir -p /etc/pacman.d/hooks
```

In the newly-created directory, create a new file named `orphans.hook` and paste the following:

```toml
[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = Package
Target = *

[Action]
Description = Searching for orphaned packages...
When = PostTransaction
Exec = /usr/bin/bash -c "/usr/bin/pacman -Qtd || /usr/bin/echo '==> no orphans found.'"
```

[informant](https://aur.archlinux.org/packages/informant) makes sure that you are aware of breaking changes in the updates that you'll get. [overdue](https://aur.archlinux.org/packages/overdue) lists daemons that reference outdated libraries. [pacman-cleanup-hook](https://aur.archlinux.org/packages/pacman-cleanup-hook) keeps your pacman cache clean. [rebuild-detector](https://github.com/maximbaz/rebuild-detector) detects which Arch Linux packages need to be rebuilt. [downgrade](https://aur.archlinux.org/packages/downgrade), while isn't a pacman hook, will still help you in case you have to downgrade a package.

```bash
paru -S informant overdue pacman-cleanup-hook rebuild-detector downgrade
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
	hyprlock hypridle \
	hyprsunset hyprpicker \
	xdg-desktop-portal-gtk \
	xdg-desktop-portal-hyprland \
	qt5-wayland qt6-wayland \
	brightnessctl \
	grim slurp swappy \
	polkit-gnome gnome-keyring \
	seahorse libsecret \
	nm-connection-editor \
	network-manager-applet \
	wl-clipboard cliphist \
	rofi-wayland rofimoji \
	pavucontrol waybar \
	dunst libnotify \
	batsignal
```

> [!TIP] If you ever need help, Hyprland has their own wiki, so [read it](https://wiki.hyprland.org/Getting-Started/Master-Tutorial/)!

To start customizing Hyprland, just copy the necessary dotfiles to `~/.config/` and start required services. Running Hyprland at this time is **not yet recommended** since we haven't customized the rest of the programs yet.

```bash
mkdir -p ~/.config/dunst

cp ~/Temp/ArchLinuxDotfiles/dotfiles/dunst/dunstrc ~/.config/dunst/dunstrc
cp -r ~/Temp/ArchLinuxDotfiles/dotfiles/waybar ~/.config/waybar
cp -r ~/Temp/ArchLinuxDotfiles/dotfiles/hypr ~/.config/hypr
cp -r ~/Temp/ArchLinuxDotfiles/dotfiles/rofi ~/.config/rofi
cp -r ~/Temp/ArchLinuxDotfiles/batsignal ~/.config/batsignal
cp -r ~/Temp/ArchLinuxDotfiles/scripts ~/.config/scripts

systemctl --user enable batsignal.service
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

### Input Methods

As of writing this, I am learning Japanese and Korean for 5 and 4 years, respectively. (I'm still not good at both btw) Because of this, I need Fcitx5 to allow me to use the Japanese and Korean input methods in Arch Linux.

```bash
paru -S fcitx5-im fcitx5-mozc-ut fcitx5-hangul
```

After installing the packages, create/edit the following files with their corresponding contents:

> [!NOTE]+ `~/.gtkrc-2.0`
> 
> ```bash
> gtk-im-module="fcitx"
> ```

> [!NOTE]+ `~/.config/gtk-3.0/settings.ini` and `~/.config/gtk-4.0/settings.ini`
> 
> ```toml
> [Settings]
> gtk-im-module=fcitx
> ```

After that, run `fcitx5-configtool` and uncheck "Only Show Current Language". Search for the following input methods and move them to the left "Current Input Method" column:

- Mozc
- Hangul

Go to "Global Options" tab and change the first entry of "Trigger Input Method" (should be initially set to `Control+Space`) to `Super+,`.

More information is available at:

- [Arch Wiki > Fcitx5](https://wiki.archlinux.org/title/Fcitx5)
- [Arch Wiki > Mozc](https://wiki.archlinux.org/title/Mozc)
- [Arch Wiki > Localization > Korean](https://wiki.archlinux.org/title/Localization/Korean).
- [Fcitx > Using Fcitx 5 on Wayland](https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland)

## Setting Up Kitty

Kitty is my terminal emulator of choice. Install it via `paru` to begin.

```bash
paru -S kitty
```

Copy the Kitty configuration file, and enable the Catppuccin colorscheme.

```bash
mkdir -p ~/.config/kitty
cp -r ~/Temp/SGDotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
kitty +kitten themes --reload-in=all Catppuccin-Mocha
```

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

I always sign-off my git commits so I have `commit.gpgsign` set to *true*. I also have a couple aliases on hand for my most-used commands. Also, I use [GitHub CLI](https://cli.github.com/) to manage my GitHub repositories.

```bash
paru -S github-cli
git config --global credential.helper /usr/lib/git-core/git-credential-libsecret

cp -r ~/Temp/SGDotfiles/git/gitconfig ~/.gitconfig
nvim ~/.gitconfig  # Edit gitconfig to replace username, email, and signing key.
```

## Setting Up The File Manager

I chose [Nautilus/GNOME Files](https://wiki.archlinux.org/title/GNOME/Files) as my GUI file manager. It just feels and looks better in my opinion.

```bash
paru -S nautilus \
    nautilus-admin-gtk4 nautilus-checksums \
    nautilus-open-any-terminal \
    file-roller sushi \
    tumbler ffmpegthumbnailer \
    raw-thumbnailer folderpreview \
    gnome-online-accounts \
    gvfs-gphoto2 gvfs-mtp gvfs-afc \
    gvfs-smb gvfs-dnssd gvfs-nfs \
    gvfs-goa gvfs-google gvfs-onedrive
```

Now, you should edit the settings of Nautilus by following [[Fedora Workstation#2. Configuring Nautilus]]. I usually hide some of the XDG directories. Follow [[Fedora Workstation#3. Update XDG Directories]] to do this.

## Setting Up The Browsers

```bash
paru -S firefox brave-bin torbrowser-launcher
```

## Gaming on Arch

I don't play many games on my laptop since I have my desktop computer. I get my games either from Steam or GOG, use MangoHud for performance monitoring, and Bottles for running Windows applications.

```bash
paru -S steam mangohud lib32-mangohud
flatpak install flathub com.usebottles.bottles
# Enable Steam Proton Integration
flatpak override --user com.usebottles.bottles --filesystem=~/.steam/steam
# Grant all flatpak applications read-only access to MangoHUD config
flatpak override --user --filesystem=xdg-config/MangoHud:ro

cp -r ~/Temp/SGDotfiles/MangoHud ~/.config/MangoHud
```

> [!WARNING]- Steam Dependencies
> 
> "If you are installing for the first time, you may be prompted for the 32-bit [Vulkan](https://wiki.archlinux.org/title/Vulkan "Vulkan") driver package. By default [pacman](https://wiki.archlinux.org/title/Pacman "Pacman") alphabetically chooses [lib32-amdvlk](https://archlinux.org/packages/?name=lib32-amdvlk), which can introduce issues like being unable to use Vulkan at all when you install it by accident for different GPU vendor or launch games on AMD GPUs if not installed alongside [amdvlk](https://archlinux.org/packages/?name=amdvlk). See [Vulkan#Installation](https://wiki.archlinux.org/title/Vulkan#Installation "Vulkan") to choose the proper driver for your GPU."
> 
> \- [Arch Wiki > Steam](https://wiki.archlinux.org/title/Steam#Installation)

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

I use LocalSend to transfer any files between my devices within the local network and GNOME Text Editor because for some reason [[#Neovim]] doesn't work properly when set as the default text editor. GNOME Disk Utility is used as a GUI front-end for disk management stuff.

```bash
paru -S cava gedit gnome-disk-utility localsend-bin

cp -r ~/Temp/SGDotfiles/cava ~/.config/cava

# Ensure that GNOME Text Editor does not add newlines at the end of files
gsettings set org.gnome.gedit.preferences.editor ensure-trailing-newline false
```

To set the default apps for common filetypes, run `set-defaults.sh` script from the `~/.config/scripts` directory:

```bash
~/.config/scripts/set-defaults.sh
```

---

- Previous: [[Automatic Customization]]
