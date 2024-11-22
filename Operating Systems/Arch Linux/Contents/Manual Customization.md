# Customization

Now that you have a new Arch Linux system, we will now start performing customizations in it.

## Setting Up Paru and Pacman (again)

### Installing An AUR Helper

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

### Hooks and Helpers

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
paru -S informant
sudo usermod -aG informant "$(whoami)"
informant read

paru -S overdue pacman-cleanup-hook rebuild-detector downgrade
```

## Downloading the Dotfiles

Clone the [Chris1320/SetupGuides-dotfiles](https://github.com/Chris1320/SetupGuides-dotfiles) and [Chris1320/SetupGuides-ArchLinux](https://github.com/Chris1320/SetupGuides-ArchLinux) repositories.

```bash
mkdir ~/Temp

git clone https://github.com/Chris1320/SetupGuides-dotfiles.git ~/Temp/SGDotfiles
git clone https://github.com/Chris1320/SetupGuides-ArchLinux.git ~/Temp/ArchLinuxDotfiles

cd ~/Temp/ArchLinuxDotfiles

# Initialize and pull submodules from remote
git submodule update --init --recursive
git lfs install       # Install LFS hooks
git lfs pull          # Download LFS files
```

## Installing Essential Packages

Install these packages to ensure that the system will work properly.

```bash
paru -S acpid avahi dkms net-tools
systemctl enable \
    acpid.service \
    avahi-daemon.service \
    systemd-timesyncd.service
```

If you have an SSD, enable TRIM:

```bash
systemctl enable fstrim.timer
```

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

> [!NOTE] Regarding PipeWire and the whole setup
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

### Development Tools

I use my machine for software development so I install compilers and interpreters on my system.

```bash
# Install development tools
paru -S \
    gcc go nvm \
    dotnet-sdk jdk-openjdk \
    php composer \
    python python-pip python-uv \
    android-tools android-udev

# Add user to adbusers group so that you can actually use it
sudo usermod -aG adbusers "$(whoami)"

# Install latest version of NodeJS and NPM via NVM
source /usr/share/nvm/init-nvm.sh
nvm install node

# Install Jupyterlab as a uv tool
uv tool install jupyterlab

# Other useful stuff
uv tool install howdoi
uv tool install magika
```

### Flatpak Support

I use many [Flatpak](https://www.flatpak.org/) applications, so installing it is a must for me.

```bash
paru -S flatpak
```

### Containers Support

I use [Podman](https://podman.io/) instead of [Docker](https://www.docker.com/) to manage and use containers.

```bash
paru -S podman podman-compose podman-docker
```

### Must-Have Programs

These are packages that I always keep in my machine installed. Some of these packages, such as `btop`, `socat`, and `jq` are also required by the customization steps below.

```bash
paru -S tar unzip unrar p7zip zip xz cpio rclone trash-cli \
    dmg2img nfs-utils cifs-utils ntfs-3g exfat-utils gvfs \
    udisks2 pfetch btop socat jq inxi yt-dlp tealdeer wget

cp -r ~/Temp/SGDotfiles/btop ~/.config
```

## Installing The Bare Minimum

### Setting Up The Desktop

[Hyprland](https://hyprland.org/) will be our tiling compositor. I chose this over other DEs/WMs because it is easy to configure, has beautiful animations, and I really like its dynamic tiling. To start, install Hyprland and the components that make up the desktop by running the following command:

```bash
paru -S hyprland hyprpaper \
	hyprlock hypridle \
	hyprsunset hyprpicker \
	xdg-desktop-portal-gtk \
	xdg-desktop-portal-hyprland \
	qt5-wayland qt6-wayland \
	brightnessctl \
	grim slurp swappy \
	wf-recorder \
	polkit-gnome gnome-keyring \
	seahorse libsecret \
	nm-connection-editor \
	network-manager-applet \
	wl-clipboard cliphist \
	rofi-wayland rofimoji \
	pavucontrol waybar \
	dunst libnotify \
	batsignal kitty \
	ttf-jetbrains-mono-nerd ttf-noto-nerd noto-fonts-cjk \
	ttf-opensans noto-fonts otf-apple-fonts ttf-ms-win11-auto \
	papirus-icon-theme papirus-folders-catppuccin-git \
	otf-font-awesome ttf-material-icons-git \
	catppuccin-cursors-mocha
```

> Additionally, this command also installs the following fonts and icons since we are going to use them:
> 
> - **Primary Fonts**: `ttf-jetbrains-mono-nerd ttf-noto-nerd noto-fonts-cjk ttf-opensans noto-fonts otf-apple-fonts ttf-ms-win11-auto`
> - **Primary Icons**: `papirus-icon-theme papirus-folders-catppuccin-git`
> - **Icon Fonts**: `otf-font-awesome ttf-material-icons-git`
> - **Cursor Icons**: `catppuccin-cursors-mocha`

> [!TIP] If you ever need help, Hyprland has their own wiki, so [read it](https://wiki.hyprland.org/Getting-Started/Master-Tutorial/)!

To start customizing Hyprland, just copy the necessary dotfiles to `~/.config/` and start required services. Running Hyprland at this time is **not yet recommended** since we haven't customized the rest of the programs yet.

```bash
mkdir -p ~/.config/dunst
mkdir -p ~/.config/kitty

cp ~/Temp/ArchLinuxDotfiles/dotfiles/dunst/dunstrc ~/.config/dunst
cp ~/Temp/SGDotfiles/kitty/kitty.conf ~/.config/kitty

cp -r ~/Temp/ArchLinuxDotfiles/dotfiles/waybar ~/.config
cp -r ~/Temp/ArchLinuxDotfiles/dotfiles/hypr ~/.config
cp -r ~/Temp/ArchLinuxDotfiles/dotfiles/rofi ~/.config
cp -r ~/Temp/ArchLinuxDotfiles/batsignal ~/.config
cp -r ~/Temp/ArchLinuxDotfiles/scripts ~/.config

kitty +kitten themes --reload-in=all Catppuccin-Mocha
systemctl --user enable batsignal.service
```

Also copy your desired background image to `~/.config/background`.

```bash
cp "~/Temp/ArchLinuxDotfiles/assets/wallpapers/<your desired wallpaper>" ~/.config/background
# I personally use `evening-sky.png` as my wallpaper.
```

Now, Hyprland's configuration files are in place, but we still need to configure
the rest of the system for it to function properly.

> [!BUG] If you are having problems with Hyprland, see their [wiki](https://wiki.hyprland.org/Crashes-and-Bugs/).

### Setting Up The Display Manager

SDDM will be the display manager that our setup will use. It will be your
"login screen". Install and enable the SDDM service to start the display
manager on boot.

```bash
paru -S sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg
systemctl enable sddm.service
```

I use [Keyitdev](https://github.com/Keyitdev)'s [sddm-astronaut-theme](https://github.com/Keyitdev/sddm-astronaut-theme) as my SDDM theme.

```bash
sudo cp -r ~/Temp/ArchLinuxDotfiles/dotfiles/sddm/sddm-astronaut-theme /usr/share/sddm/themes
sudo mkdir -p /etc/sddm.conf.d
sudo cp -r ~/Temp/ArchLinuxDotfiles/dotfiles/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf
printf '[General]\nInputMethod=qtvirtualkeyboard' | sudo tee /etc/sddm.conf.d/virtualkbd.conf

sudo mkdir -p /usr/share/wallpapers
sudo cp "~/Temp/ArchLinuxDotfiles/assets/wallpapers/<your desired wallpaper>" /usr/share/wallpapers/sddm-bg
```

> [!TIP] Currently, I use `5am_Train_1920x1080.jpg` as my SDDM background.

Edit the `/usr/share/sddm/themes/sddm-astronaut-theme/Themes/theme1.conf` file
and change the following lines:

| Key            | Value                           |
| -------------- | ------------------------------- |
| `Background`   | `/usr/share/wallpapers/sddm-bg` |
| `FormPosition` | `left`                          |
| `HeaderText`   | You can put anything here :>    |

Related Links:

- [Arch Linux Wiki > SDDM](https://wiki.archlinux.org/title/SDDM)
- [GitHub - Keyitdev/sddm-astronaut-theme: Modern looking sddm qt6 theme.](https://github.com/Keyitdev/sddm-astronaut-theme)

## Entering Hyprland

> [!CHECK] You have reached a checkpoint!

After installing the bare minimum requirements to run the setup, go ahead and type `reboot` to restart the system. You will be greeted by SDDM. Log in with your credentials and press `SUPER+SHIFT+T` to open a new terminal. You can now continue following the guide.

### Setting Up ZSH

See [[ZSH]] for more information.

### Neovim

[[Neovim]] is the best text editor and IDE on Linux btw (fight me). If I installed the packages from the [[#Development Tools]] section, might as well use Neovim to write code. We'll have to install some packages that are required by the plugins first.

```bash
paru -S neovim tree-sitter tree-sitter-cli
# Customize Neovim using my Neovim dotfiles
bash <(curl -sSf https://raw.githubusercontent.com/Chris1320/SetupGuides-Neovim/main/install)
```

### Setting Up GPG and SSH

If you have an existing GPG and SSH keys, you can now start restoring them to your new system.

#### Using GNOME Keyring as Secrets Manager

Edit `~/.gnupg/gpg-agent.conf` and insert the following line to use GNOME 3 pinentry when asking for GPG password: 

```text
pinentry-program /usr/bin/pinentry-gnome3
```

Run the following commands to use GNOME Keyring for SSH authentication.

```bash
systemctl enable --user gcr-ssh-agent.socket
systemctl start --user gcr-ssh-agent.socket
```

#### Importing Your GPG keys

First, import your GPG private key.

```bash
gpg --import your_gpg_key.gpg

chmod 700 ~/.gnupg
chmod 600 ~/.gnupg/*
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

#### Importing Your SSH keys

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

### Setting Up Git

I always sign-off my git commits so I have `commit.gpgsign` set to *true*. I also have a couple aliases on hand for my most-used commands. Also, I use [GitHub CLI](https://cli.github.com/) to manage my GitHub repositories.

```bash
paru -S github-cli

cp -r ~/Temp/SGDotfiles/git/gitconfig ~/.gitconfig
nvim ~/.gitconfig  # Edit gitconfig to replace username, email, and signing key.

git config --global credential.helper /usr/lib/git-core/git-credential-libsecret
```

We haven't set up any web browsers currently so we won't run `gh auth login` for now.

### Image and Video Viewers

I use [Mpv](https://mpv.io/) and [imv](https://sr.ht/~exec64/imv/) to view videos and images respectively.

```bash
paru -S imv mpv
cp -r ~/Temp/SGDotfiles/imv ~/.config
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

### Music Player

Soon™️

### Document Viewer

I use [Zathura](https://github.com/pwmt/zathura) as my primary document viewer. To start, install it together with the necessary dependencies and copy the configuration file.

```bash
paru -S zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps
cp -r ~/Temp/SGDotfiles/zathura ~/.config
```

> [!QUESTION]- Which language should I select for Tesseract data?
> 
> While installing the packages, Paru asked me this:
> 
> > "*There are 128 providers available for tessdata*"
> 
> Choose the language you need for OCR. I read mostly English documents, so I chose `tesseract-data-eng`.

For Microsoft Office documents, I use [OnlyOffice](https://www.onlyoffice.com/).

```bash
paru -S onlyoffice-bin
```

### Flatpak Manager

```bash
flatpak install flathub com.github.tchx84.Flatseal  # Install FlatSeal to manage Flatpaks
```

### Theming GTK Applications

Currently, this setup uses the [Everforest GTK theme](https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme). [refi64/stylepak](https://github.com/refi64/stylepak) helps us automatically install our GTK+ theme as a Flatpak.

```bash
paru -S everforest-gtk-theme-git gtk-engine-murrine stylepak-git

# Install system and user themes to Flatpak
stylepak install-system
stylepak install-user
```

### Using Hyprcursors

Hyprland introduced a new cursor theme format, called _Hyprcursor_. It is supposed to be a more efficient and faster cursor theme format. The Catppuccin cursors are already set up in Hyprland's config file, so we just need to update `gsettings` with the appropriate settings.

Run the following script and select/enter your preferred cursor and cursor size (I use the defaults).

```bash
~/.config/scripts/set-cursor.sh
```

### Input Methods

As of writing this, I am learning Japanese and Korean for 5 and 4 years, respectively. (I'm still not good at both btw) Because of this, I need Fcitx5 to allow me to use the Japanese and Korean input methods in Arch Linux.

```bash
paru -S fcitx5-im fcitx5-mozc-ut fcitx5-hangul
```

After installing the packages, run the following commands to create the configuration files with their corresponding contents:

```bash
printf 'gtk-im-module="fcitx"' > ~/.gtkrc-2.0
printf '[Settings]\ngtk-im-module=fcitx' > ~/.config/gtk-{3.0,4.0}/settings.ini
```

After that, run `fcitx5-configtool` and uncheck "Only Show Current Language". Search for the following input methods and move them to the left "Current Input Method" column:

- Mozc
- Hangul

Go to "Global Options" tab and change the first entry of "Trigger Input Method" (should be initially set to `Control+Space`) to `Super+,` so that they won't conflict with Hyprland's keybindings.

More information is available at:

- [Arch Wiki > Fcitx5](https://wiki.archlinux.org/title/Fcitx5)
- [Arch Wiki > Mozc](https://wiki.archlinux.org/title/Mozc)
- [Arch Wiki > Localization > Korean](https://wiki.archlinux.org/title/Localization/Korean).
- [Fcitx > Using Fcitx 5 on Wayland](https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland)

## Setting Up The File Explorer

I chose [Yazi](https://yazi-rs.github.io/) as my GUI file explorer. I used to use [Nautilus/GNOME Files](https://wiki.archlinux.org/title/GNOME/Files), but I found Yazi to suit my needs.

```bash
paru -S yazi ouch archivemount mediainfo
cp -r ~/Temp/SGDotfiles/yazi ~/.config/yazi
```

I usually hide some of the XDG directories. Follow [[Fedora Workstation#3. Update XDG Directories]] to do this.

## Setting Up The Browsers

```bash
paru -S firefox brave-bin torbrowser-launcher
```

## Gaming on Arch

I don't play many games on my laptop since I have my desktop computer. I get my games either from Steam or GOG, use MangoHud for performance monitoring, and Bottles for running Windows applications.

```bash
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.usebottles.bottles
flatpak install flathub org.freedesktop.Platform.VulkanLayer.MangoHud
flatpak install flathub net.davidotek.pupgui2
paru -S gamemode lib32-gamemode

sudo usermod -aG gamemode "$(whoami)"
 
# Enable Steam Proton Integration
flatpak override --user com.usebottles.bottles --filesystem=~/.var/app/com.valvesoftware.Steam/data/Steam
# Grant all flatpak applications read-only access to MangoHUD config
flatpak override --user --filesystem=xdg-config/MangoHud:ro
# Enable MangoHUD on all Steam games
flatpak override --user --env=MANGOHUD=1 com.valvesoftware.Steam

cp -r ~/Temp/SGDotfiles/MangoHud ~/.config/MangoHud
```

Install Proton-GE. Set `Steam Settings > Compatibility > Run other titles with` to `GE-Proton`.

> [!TIP]+
> 
> When you are going to play a game, enable *mangohud* and *gamemode* by adding the following to the launch options:
> 
> ```bash
> mangohud gamemoderun %command%
> ```

## Screen Recording

```bash
paru -S obs-studio v4l2loopback-dkms v4l2loopback-utils
```

## Btrfs Snapshots

Since we have set up our system to use Btrfs with a `@snapshots` subvolume, we will use [Snapper](https://snapper.io/) to create snapshots and [Btrfs Assistant](https://gitlab.com/btrfs-assistant/btrfs-assistant) as the frontend. [snap-pac](https://github.com/wesbarnett/snap-pac) is installed to create Btrfs snapshots before and after Pacman operations.

```bash
paru -S snapper snap-pac btrfs-assistant inotify-tools
systemctl enable snapper-boot.timer
```

To use `grub-btrfsd.service`, we'll have to edit the service to point to `/snapshots`.

```bash
sudo systemctl edit --full grub-btrfsd.service
```

Find the line where it shows:

```toml
ExecStart=/usr/bin/grub-btrfsd --syslog /.snapshots
```

and replace `/.snapshots` to `/snapshots`. Save and close the file and then run the following command to enable the service:

```bash
systemctl enable grub-btrfsd.service
```

Edit `/etc/mkinitcpio.conf` and add `grub-btrfs-overlayfs` to `HOOKS`:

```toml
HOOKS=(... grub-btrfs-overlayfs)
```

After saving and closing the file, run `mkinitcpio -P`.

### Setting Up Snapper

Start Btrfs Assistant and go to the *Snapper Settings* tab. Click *New* and name it `root` with backup path `/`. Enable *timeline snaphots*, adjust the snapshot retention times, and click *Save*. Click *New* again and name it `home` with backup path `/home`, enable *timeline snaphots*, adjust the snapshot retention times, and click *Save*. Lastly, enable *timeline*, *cleanup*, and *boot* in *systemd Unit Settings* section.

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
paru -S cava gedit gnome-disk-utility localsend-bin imhex-bin

cp -r ~/Temp/SGDotfiles/cava ~/.config/cava

# Ensure that GNOME Text Editor does not add newlines at the end of files
gsettings set org.gnome.gedit.preferences.editor ensure-trailing-newline false

# Authenticate GitHub CLI
gh auth login
```

Sometimes, there are things that I cannot do on Neovim, such as Live Share/Pair Programming with classmates on coding sessions. Because of this, I have to use Visual Studio Code. I use the Flatpak version because it's what I use on my Fedora Workstation system.

```bash
flatpak install flathub com.visualstudio.code
```

Mod Discord and Spotify

```bash
flatpak install flathub com.discordapp.Discord
# Install Vencord (https://vencord.dev/)
# Run two times to install OpenAsar and Vencord
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
```

```bash
flatpak install flathub com.spotify.Client
paru -S spicetify-cli
```

To set the default apps for common filetypes, run `set-defaults.sh` script from the `~/.config/scripts` directory:

```bash
~/.config/scripts/set-defaults.sh
```

---

- Previous: [[Automatic Customization]]
