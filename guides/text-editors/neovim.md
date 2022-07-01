# Neovim

This guide will install Neovim and the following plugins:

- Plugin Manager
    - [packer](https://github.com/wbthomason/packer.nvim): Plugin Manager for Neovim.
- Linting and Syntax Checking
    - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Language Server Protocol (LSP) configuration helper.
    - [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer): Make installation of LSP servers easier.
    - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Better syntax highlighting.
    - [trouble.nvim](https://github.com/folke/trouble.nvim): Error and status line manager.
    - [copilot.vim](https://github.com/github/copilot.vim): GitHub Copilot for Vim.
- Fuzzy Search
    - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): Fuzzy Finder.
- Theming and Visual Plugins
    - [catppuccin](https://github.com/catppuccin/nvim): A Neovim theme.
    - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Git Integration for buffers.
    - [feline.nvim](https://github.com/feline-nvim/feline.nvim): A customizable statusline.
    - [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim): Indentation guides
    - [auto-pairs](https://github.com/jiangmiao/auto-pairs): Bracket auto-pairing
    - [which-key.nvim](https://github.com/folke/which-key.nvim): Show available key bindings.
    - [twilight.nvim](https://github.com/folke/twilight.nvim): Dim inactive parts of your code.
- Code Completion
    - [coq_nvim](https://github.com/ms-jpq/coq_nvim/): Code completion.
    - [coq.artifacts](https://github.com/ms-jpq/coq.artifacts): COQ snippets.
    - [coq.thirdparty](https://github.com/ms-jpq/coq.thirdparty): COQ 3rd-party integration.
- File Explorer
    - [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua): File explorer tree
- Dependencies
    - [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons): Provides filetype icons.
    - [plenary.nvim](https://github.com/nvim-lua/plenary.nvim): A Lua library.

**Custom Key Bindings**:

| Key           | Resulting Command                      | Action                                     |
|---------------|----------------------------------------|--------------------------------------------|
| `,`           |                                        | Leader key                                 |
| `<leader>tt`  | `:Telescope`                           | Toggle Telescope                           |
| `<leader>tb`  | `:Telescope buffers`                   | Toggle Telescope Buffer Searcher           |
| `<leader>tF`  | `:Telescope find_files`                | Toggle Telescope File Searcher             |
| `<leader>ts`  | `:Telescope treesitter`                | Toggle Telescope treesitter explorer       |
| `<leader>tf`  | `:Telescope current_buffer_fuzzy_find` | Toggle fuzzy finder for current buffer     |
| `<leader>ewd` | `:TroubleToggle workspace_diagnostics` | Toggle Trouble workspace diagnostics panel |
| `<leader>edd` | `:TroubleToggle document_diagnostics`  | Toggle Trouble document diagnostics panel  |
| `<leader>eqf` | `:TroubleToggle quickfix`              | Toggle Trouble quick fix panel             |
| `<leader>elr` | `:TroubleToggle lsp_references`        | Toggle Trouble LSP References panel        |
| `<leader>elc` | `:TroubleToggle loclist`               | Toggle Trouble Location List panel         |
| `<leader>ff`  | `:NvimTreeToggle`                      | Toggle Nvim-tree file explorer.            |
| `<leader>cc`  | `:COQnow`                              | Enable code completion.                    |
| `<leader>z`   | `:Twilight`                            | Toggle Twilight.                           |

**Tested on the following platforms**:

- Kali Linux WSL
- Termux Android Terminal Emulator

*Windows version of this guide will be available soon.*

## Customization Guide

1. Installing Neovim
    - Check if Neovim v0.7.2+ is available in your package manager. `$ apt show neovim`
    - If version 0.7.2 above is available, install it. `$ apt install --upgrade neovim`
    - Otherwise, download it from [their GitHub repository](https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb) and install it. `$ dpkg -i nvim-linux64.deb`[^1]
2. Clone and install packer. `$ git clone --depth=1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
3. Copy the contents of [neovim-init/](https://github.com/Chris1320/SetupGuides/tree/main/resources/neovim-init) to your `~/.config/nvim/`. The directory must look like this:

    ```
    $ tree ~/.config/nvim/
    /home/<user>/.config/nvim/
    ├── init.lua
    └── lua
        └── plugins.lua
        └── vars.lua

    1 directory, 3 files
    ```

4. Install dependencies. `$ sudo apt install --upgrade clang curl python3 python3-pip python3-venv`[^2]
5. Run `nvim`. Packer will now update, install, and compile the plugins.
6. After installation, quit Neovim by entering `:q`.
7. Open `~/.config/nvim/vars.lua` and change the value of `installed` from `false` to `true`. (The resulting line must be `installed = true`)
8. Open `nvim`. nvim-treesitter will now install treesitter parsers. Run `:TSInstallInfo` to check if all languages you want to installed are now installed.[^3]
9. Run `:COQdeps` to install dependencies for COQ.
10. Enter `:PackerStatus` to verify all plugins are installed.
11. To check if everything is installed correctly, enter `:checkhealth`.
12. (*Optional*) Install LSP servers by running `:LspInstall <server>` inside Neovim.[^4] (Run `:LspInstallInfo` for more information.)
13. (*Optional*) Setup GitHub Copilot. `:Copilot setup`[^5]

[^1]: To download and install using wget and dpkg: `wget -O ./nvim-linux64.deb https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && sudo dpkg -i ./nvim-linux64.deb`
[^2]: You can also install optional additional packages used by Telescope and COQ: `$ sudo apt install --upgrade fd ripgrep bc`
[^3]: You can install a language by running `:TSInstall <language>` or editing the `languages` variable in `~/.config/nvim/lua/plugins.lua`. Read [the documentation](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages) for more information.
[^4]: Manual configuration is necessary for each LSP server.
[^5]: A GitHub account with Copilot subscription is required.

-----

**References**:

- [Neovim configuration for beginners](https://medium.com/geekculture/neovim-configuration-for-beginners-b2116dbbde84)
- [Catppuccin for NeoVim](https://github.com/catppuccin/nvim)
- [Basic Neovim LSP Setup](https://codevion.github.io/#!vim/treelsp.md)

