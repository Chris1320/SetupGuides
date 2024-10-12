# Setting Up dunst

Dunst is a lightweight notification daemon for Linux and Unix-like operating systems. It is highly customizable, allowing us to adjust its appearance, behavior, and the types of notifications it handles.

To start, install `dunst` and copy its configuration file.

```bash
paru -S dunst libnotify
mkdir -p ~/.config/dunst
cp ./dotfiles/dunst/dunstrc ~/.config/dunst/dunstrc
```

---

- Previous: [[Setting Up SDDM]]
- Next: [[Setting Up Waybar]]
