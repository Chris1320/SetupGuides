# Neovim

This guide will install Neovim and the following plugins:

- [vim-plug](https://github.com/junegunn/vim-plug): vim plugin manager
- [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim): Indentation guides
- [auto-pairs](https://github.com/jiangmiao/auto-pairs): Bracket auto-pairing
- [catppuccin](https://github.com/catppuccin/nvim): Catppuccin theme
- [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua): File explorer tree
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons): Icons for/dependency of nvim-tree
- [vim-flake8](https://github.com/nvie/vim-flake8): Python syntax checker
- [rust](https://github.com/rust-lang/rust.vim): Rust syntax checker

**Tested on the following platforms**:

- Kali Linux WSL
- Termux Android Terminal Emulator

## Customization Guide

1. Install Neovim. `$ sudo apt install neovim`
2. Download [vim-plug](https://github.com/junegunn/vim-plug). `$ sh -c "curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"`
3. Copy [init.vim]() to `~/.config/nvim/init.vim`.

-----

**References**:

- [Neovim configuration for beginners](https://medium.com/geekculture/neovim-configuration-for-beginners-b2116dbbde84)
- [Catppuccin for NeoVim](https://github.com/catppuccin/nvim)
