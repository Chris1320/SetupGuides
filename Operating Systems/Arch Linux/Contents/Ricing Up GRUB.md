# Ricing Up GRUB

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
