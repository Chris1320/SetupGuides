# Termux

Termux is an Android terminal emulator and a linux environment. It can be used to run most
Linux software without root. This guide will help at setting up and configuring Termux.

## Installation

1. Download [Termux](https://termux.com/).
2. Update packages. `$ apt update && apt upgrade`
3. Install Termux API. `$ apt install termux-api`
4. Configure access to external storage. `$ termux-setup-storage`[^1]

## Recommended Customizations

- [zsh](../shells/zsh.md)
- [neovim](../text-editors/neovim.md)

## Enabling SSH Remote Connections

Termux supports remote connections via the Secure SHell (SSH) protocol. Follow the instructions below to install and configure SSH.

1. Install SSH. `$ apt install openssh`
2. Add `sshd -p <port>`[^2] to your `.zshrc` (Or `.bashrc`, if you are not using zsh) file.
3. Set SSH password. `$ passwd` (This will prompt you to enter a password twice.)
4. Reload your terminal or manually run the command `sshd -p <port>`.[^2]
5. Using another machine, connect to Termux using `$ ssh <user>@<ip> -p <port>`

[^1]: Android might prompt you to allow access to external storage. Press "*Allow*" to continue.
[^2]: The SSH port is usually 22. However, if you are using a non-rooted Android device, use `8022` or any port above 1024.
