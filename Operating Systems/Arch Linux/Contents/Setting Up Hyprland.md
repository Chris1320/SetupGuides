# Setting Up Hyprland

[Hyprland](https://hyprland.org/) will be our tiling compositor. I chose this over other DEs/WMs because it is easy to configure, has beautiful animations, and I really like its dynamic tiling. To start, install Hyprland by running the following command:

```bash
paru -S hyprland hyprpaper \
	brightnessctl btop fcitx5 \
	grim slurp swappy \
	polkit-gnome keepassxc \
	wl-clipboard cliphist \
	catppuccin-cursors-mocha \
	socat
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

> [!TIP] Previewing Images In The Terminal
>
> You can run `icat ./assets/wallpapers/<your desired wallpaper>` to
> preview the image in the terminal.

Now, Hyprland's configuration files are in place, but we still need to configure
the rest of the system for it to function properly.

> [!BUG] If you are having problems with Hyprland, see their [wiki](https://wiki.hyprland.org/Crashes-and-Bugs/).

## Hyprcursors

Hyprland's author introduced a new cursor theme format, called _Hyprcursor_.
It is supposed to be a more efficient and faster cursor theme format.

```bash
# TODO
```

---

- Previous: [[Installing and Setting Up The Desktop]]
- Next: [[Setting Up Kitty]]
