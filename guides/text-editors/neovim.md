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
2. Clone and install packer. `$ git clone --depth=1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
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
5. Run `nvim`. Packer will now update, install, and compile the plugins.
6. After installation, quit Neovim by entering `:q`.
7. Open `~/.config/nvim/plugins.lua` and change the value of `installed` from `false` to `true`. (The resulting line must be `local installed = true`)
8. Open `nvim`. nvim-treesitter will now install treesitter parsers. Run `:TSInstallInfo` to check if all languages you want to installed are now installed.[^3]

9. Enter `:PackerStatus` to verify all plugins are installed.
10. To check if everything is installed correctly, enter `:checkhealth`.

[^1]: To download and install using wget and dpkg: `wget -O ./nvim-linux64.deb https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && sudo dpkg -i ./nvim-linux64.deb`
[^2]: On Termux, install clang instead. `$ apt install clang` (explanation in [this GitHub issue comment](https://github.com/termux/termux-packages/issues/407#issuecomment-241251913))
[^3]: You can install a language by running `:TSInstall <language>` or editing the `languages` variable in `~/.config/nvim/lua/plugins.lua`. Read [the documentation](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages) for more information.

-----

**References**:

- [Neovim configuration for beginners](https://medium.com/geekculture/neovim-configuration-for-beginners-b2116dbbde84)
- [Catppuccin for NeoVim](https://github.com/catppuccin/nvim)
- [Basic Neovim LSP Setup](https://codevion.github.io/#!vim/treelsp.md)
