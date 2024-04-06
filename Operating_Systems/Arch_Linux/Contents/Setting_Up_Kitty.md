# Setting Up Kitty

Copy the Kitty configuration file and enable the Catppuccin colorscheme.

```bash
cp -r ./dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
kitty +kitten themes --reload-in=all Catppuccin-Mocha
```

## Adding Kittens (Plugins)

Alias the following commands. You can change the aliases to whatever you like.

| Alias  | Command              |
| ------ | -------------------- |
| `icat` | `kitty +kitten icat` |

For bash-like terminals, run the following command.

```bash
echo 'alias icat="kitty +kitten icat"' >> ~/.bashrc  # For bash
echo 'alias icat="kitty +kitten icat"' >> ~/.zshrc  # For ZSH
```

> [!NOTE]
> 
> If you are going to use my [Custom ZSH Configuration](https://github.com/SetupGuides/ZSH), create a new file in `~/.config/zsh/custom/envs/` (e.g., `~/.config/zsh/custom/envs/kitty.env`) instead of pasting to `~/.zshrc`.

---

- Previous: [Setting_Up_Hyprland](Setting_Up_Hyprland.md)
- Next: [Setting_Up_SDDM](Setting_Up_SDDM.md)
