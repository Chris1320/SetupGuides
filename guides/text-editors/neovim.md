# Neovim

This guide will install Neovim and the following plugins:

- [packer](https://github.com/wbthomason/packer.nvim): Plugin Manager for Neovim.
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

**Windows version of this guide will be available soon.**

## Customization Guide

1. Installing Neovim
    - Check if Neovim v0.7.2+ is available in your package manager. `$ apt show neovim`
    - If version 0.7.2 above is available, install it. `$ apt install neovim`
    - Otherwise, download it from [their GitHub repository](https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb) and install it. `$ dpkg -i nvim-linux64.deb`[^1]
2. Clone and install packer. `$ git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
3. Copy the contents of [neovim-lua/](../../resources/neovim-lua) to your `~/.config/nvim/`. The directory must look like this:

    ```
    $ tree ~/.config/nvim/
    /home/<user>/.config/nvim/
    ├── init.lua
    └── lua
        └── plugins.lua

    1 directory, 2 files
    ```

4. Install gcc. `$ sudo apt install gcc`[^2]
4. Run `nvim`, and an error will occur. This is because the plugins are not yet installed.
5. Type `:PackerSync` to update, install, and compile the plugins.
6. After installation, quit Neovim by entering `:q`.
7. To check if everything is installed correctly, open `nvim` and enter `:checkhealth` and `:PackerStatus`.

[^1]: To download and install using wget and dpkg: `wget -O ./nvim-linux64.deb https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && sudo dpkg -i ./nvim-linux64.deb`
[^2]: On Termux, install clang instead. `$ apt install clang` (explanation in [this GitHub issue comment](https://github.com/termux/termux-packages/issues/407#issuecomment-241251913))

-----

**References**:

- [Neovim configuration for beginners](https://medium.com/geekculture/neovim-configuration-for-beginners-b2116dbbde84)
- [Catppuccin for NeoVim](https://github.com/catppuccin/nvim)
- [Basic Neovim LSP Setup](https://codevion.github.io/#!vim/treelsp.md)
