---
title: Installing Useful Software
description: My Arch Linux (btw) dotfiles.
draft: false
tags:
  - linux
  - linux/distro
---

# Installing Useful Software

## Installing Neovim

Neovim is the best text editor and IDE on Linux btw (fight me). We'll have to install some packages that are required by the plugins first.

```bash
# Install Node Version Manager
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh" | bash

# Move new lines from .zshrc to user_env.sh and restart the terminal

nvm install node
paru -S neovim tree-sitter tree-sitter-cli
# Customize Neovim
bash <(curl -sSf https://raw.githubusercontent.com/Chris1320/SetupGuides-Neovim/main/install)
```

## Others

```bash
paru -S localsend-bin pfetch trash-cli github-cli
```
