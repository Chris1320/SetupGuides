# Customization

Now that you have a new Arch Linux system, we will now start performing customizations in it.

## Installing An AUR Helper

[Install Paru](https://github.com/Morganamilo/paru). This is the AUR helper that we will use.

```bash
sudo pacman -S --needed base-devel rustup  # If it is not yet installed

# Install the latest stable version of Rust
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

Install `git` and `git-lfs`, and clone this repository.

```bash
paru -S git git-lfs
mkdir ~/Temp
git clone https://github.com/Chris1320/SetupGuides-ArchLinux.git ~/Temp/ArchLinuxDotfiles
cd ~/Temp/ArchLinuxDotfiles
git submodule init    # Initialize git submodules
git submodule update  # Pull submodules from remote
git lfs pull          # Download LFS files
```

> [!NOTE] From now on, this guide will assume that you are in `~/Temp/ArchLinuxDotfiles` directory unless specified.

## Custom Fonts and Icons

We are going to use the following fonts and icons, so it's best to install it now.

```bash
paru -Syu otf-font-awesome ttf-jetbrains-mono-nerd ttf-noto-nerd \
    papirus-icon-theme papirus-folders-catppuccin-git
```

> [!CAUTION] If `papirus-folders-catppuccin-git` fails to install, just re-login or reboot the system after installing `papirus-icon-theme`.

## Useful Packages

It is recommended to install and enable the following packages.

```bash
paru -S acpid avahi
systemctl enable acpid.service avahi-daemon.service
```

### Enable Bluetooth support

```bash
paru -S bluez bluez-utils blueman
systemctl enable bluetooth.service
systemctl start bluetooth.service
```

I also install required Bluetooth drivers in this part, if necessary. For example, my laptop has Broadcom devices, so I also install `broadcom-bt-firmware` from the AUR via `paru`.

### Enable Printer Support

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

## Next Steps

- [[Installing and Setting Up The Desktop]]

---

- Previous: [[Automatic Customization]]
- Next: [[Installing and Setting Up The Desktop]]
