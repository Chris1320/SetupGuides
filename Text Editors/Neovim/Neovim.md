---
title: Neovim
description: My Neovim configuration for code editing.
draft: false
---

# Neovim

This guide will help you install [Neovim](https://neovim.io/) and plugins that I use. I frequently work with terminals and I find [Vim](https://www.vim.org/) really helpful when editing code and text without needing a GUI. However, I didn't have the time and motivation to learn VimScript, but then I heard about Neovim. I have some experience with Lua so I thought that I might give it a try, and this is the result. Note that I am not an experienced Neovim (and Lua) user so expect that there will be occasional bugs.

## Plugins List

This setup now uses [LazyVim](https://www.lazyvim.org/) as its base. Older versions of the dotfiles are built up from scratch.

> The following [extras](https://www.lazyvim.org/extras) are enabled:
> 
> - Coding
> 	- [Copilot](https://www.lazyvim.org/extras/coding/copilot)
> - [DAP](https://www.lazyvim.org/extras/dap/core)
> - Language Support
> 	- [Clangd](https://www.lazyvim.org/extras/lang/clangd)
> 	- [Java](https://www.lazyvim.org/extras/lang/java)
> 	- [JSON](https://www.lazyvim.org/extras/lang/json)
> 	- [Markdown](https://www.lazyvim.org/extras/lang/markdown)
> 	- [Omnisharp](https://www.lazyvim.org/extras/lang/omnisharp)
> 	- [Python](https://www.lazyvim.org/extras/lang/python)
> 	- [Tailwind](https://www.lazyvim.org/extras/lang/tailwind)
> 	- [Typescript](https://www.lazyvim.org/extras/lang/typescript)

> The following base plugins are disabled:
> 
> - [flash.nvim](https://github.com/folke/flash.nvim)
> - [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)

> The following plugins are added in addition to the base plugins:
> 
> - [gitignore.nvim](https://github.com/wintermute-cell/gitignore.nvim): A neovim plugin for generating `.gitignore` files.
> - [lsp_lines.nvim](https://git.sr.ht/~whynothugo/lsp_lines.nvim): Show LSP diagnostics in a separate line.
> - [numb.nvim](https://github.com/nacro90/numb.nvim): Peek lines just when you intend.
> - [presence.nvim](https://github.com/andweeb/presence.nvim): [Discord](https://discord.com/) Rich Presence for Neovim.
> - [smartcolumn.nvim](https://github.com/m4xshen/smartcolumn.nvim): A Neovim plugin hiding your colorcolumn when unneeded.
> - [twilight.nvim](https://github.com/folke/twilight.nvim): Dim inactive portions of the code you're editing using TreeSitter.
> - [vim-arduino](https://github.com/stevearc/vim-arduino): Vim plugin for compiling and uploading arduino sketches.
> - [zen-mode.nvim](https://github.com/folke/zen-mode.nvim): Distraction-free coding for Neovim.

## Platform Compatibility

This setup has been tested on the following platforms:

- [[Arch Linux]]
- Kali Linux WSL
- Linux Mint 21
- [[Termux]] Android Terminal Emulator

## Requirements

- [Neovim](https://neovim.io/) v0.9.2+
- [Git](https://git-scm.com/)
- [gcc](https://gcc.gnu.org/) or [clang](https://clang.llvm.org/)
- [make](https://www.gnu.org/software/make/)
- [NodeJS](https://nodejs.org/)

## Installation

### Automatic Customization Guide

1. Install the [[#Requirements|requirements]].
2. Run the installer.
   - Using *curl*:
	   ```bash
	   bash <(curl -sSf https://raw.githubusercontent.com/Chris1320/SetupGuides-Neovim/main/install)
	   ```
   - Using *wget*:
	   ```bash
	   bash <(wget -q -O - https://raw.githubusercontent.com/Chris1320/SetupGuides-Neovim/main/install)
	   ```
3. Run `nvim` and wait for Lazy to install the plugins.
4. Check for errors by running `:checkhealth`.

### Manual Customization Guide

1. Install the [[#Requirements|requirements]].
2. Clone the repository.
	```bash
	git clone https://github.com/Chris1320/SetupGuides-Neovim.git
	```
3. Copy the contents of [src/](https://github.com/Chris1320/SetupGuides-Neovim/tree/main/src) to your `~/.config/nvim/`. The directory must look like this:

   ```text
   $ tree ~/.config/nvim/

   /home/<user>/.config/nvim/
   ├── init.lua
   └── lua
	   ├── config
	   │   ├── autocmds.lua
	   │   ├── keymaps.lua
	   │   ├── lazy.lua
	   │   ├── misc.lua
	   │   ├── options.lua
	   │   └── vars.lua
	   └── plugins
	       └── <plugin-name>.lua

   4 directories, 33 files
   ```

4. Run `nvim`. lazy.nvim will now update, install, and compile the plugins.
5. To check if everything is installed correctly, enter `:checkhealth`.
