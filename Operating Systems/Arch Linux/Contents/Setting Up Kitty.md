# Setting Up Kitty

Kitty is my terminal emulator of choice. Install it via `paru` to begin.

```bash
paru -S kitty
```

Since [June 3, 2024](https://github.com/Chris1320/SetupGuides-ArchLinux/commit/edd1e5b5ea67c42c4da9cbb9d754c025210c652d), I moved dotfiles that are used across multiple operating systems to a separate repository. Because of this, the dotfiles for Kitty is not on [SetupGuides-ArchLinux](https://github.com/Chris1320/SetupGuides-ArchLinux), but rather on [SetupGuides-dotfiles](https://github.com/Chris1320/SetupGuides-dotfiles). You will have to clone the repository where it is located, copy the Kitty configuration file, and enable the Catppuccin colorscheme.

```bash
git clone https://github.com/Chris1320/SetupGuides-dotfiles.git ~/Temp/SGDotfiles
mkdir -p ~/.config/kitty
cp -r ~/Temp/SGDotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
kitty +kitten themes --reload-in=all Catppuccin-Mocha
```

> [!NOTE] You now have two SetupGuides repositories on your `~/Temp` directory.

---

- Previous: [[Setting Up Hyprland]]
- Next: [[Setting Up SDDM]]
