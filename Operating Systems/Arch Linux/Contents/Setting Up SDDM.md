# Setting Up SDDM

SDDM will be the display manager that our setup will use. It will be your "login screen". Install and enable the SDDM service to start the display manager on boot.

```bash
paru -S sddm qt6-svg qt6-virtualkeyboard catppuccin-cursors-mocha ttf-opensans noto-fonts
systemctl enable sddm.service
```

I use [Keyitdev](https://github.com/Keyitdev)'s [sddm-astronaut-theme](https://github.com/Keyitdev/sddm-astronaut-theme) as my SDDM theme. Clone their SDDM configuration files to their designated locations.

```bash
sudo cp -r ./dotfiles/sddm/sddm-astronaut-theme /usr/share/sddm/themes/sddm-astronaut-theme
sudo mkdir -p /etc/sddm.conf.d
sudo cp -r ./dotfiles/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf
printf '[General]\nInputMethod=qtvirtualkeyboard' | sudo tee /etc/sddm.conf.d/virtualkbd.conf
```

> [!NOTE]
> 
> Make sure that git submodules are pulled before attempting to copy the files from `./dotfiles/sddm/sddm-astronaut-theme` directory.
>
> ```bash
> git submodule update --init --recursive --remote
> ```

Related Links:

- [Arch Linux Wiki > SDDM](https://wiki.archlinux.org/title/SDDM)
- [GitHub - Keyitdev/sddm-astronaut-theme: Modern looking sddm qt6 theme.](https://github.com/Keyitdev/sddm-astronaut-theme)

---

- Previous: [[Setting Up Kitty]]
- Next: [[Setting Up dunst]]
