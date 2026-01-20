---
title: Neovim
description: My Neovim configuration for code editing.
draft: false
tags:
  - linux
  - text-editor
---

# Neovim

This guide will help you install [Neovim](https://neovim.io/) and plugins that I use. I frequently work with terminals and I find [Vim](https://www.vim.org/) really helpful when editing code and text without needing a GUI. However, I didn't have the time and motivation to learn VimScript, but then I heard about Neovim. I have some experience with Lua so I thought that I might give it a try, and this is the result. Note that I am not an experienced Neovim (and Lua) user so expect that there will be occasional bugs.

## Platform Compatibility

This setup has been tested on the following platforms:

- [[Arch Linux]]
- [[Fedora Workstation]] 39/40/41/42
- Kali Linux WSL
- Fedora Linux 42 WSL
- Linux Mint 21
- [[Termux]] Android Terminal Emulator

## Requirements

- [Neovim](https://neovim.io/) v0.11.2+
- [Git](https://git-scm.com/)
- [gcc](https://gcc.gnu.org/) or [clang](https://clang.llvm.org/)
- [make](https://www.gnu.org/software/make/)
- [NodeJS](https://nodejs.org/)
- [Tree-sitter](https://tree-sitter.github.io/tree-sitter)
- [composer](https://getcomposer.org/) (**Optional**; only needed for PHP LSPs and linters)
- [.NET SDK](https://dot.net/) (**Optional**; only needed for `omnisharp` LSP.)

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
