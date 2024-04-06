# Termux

[Termux](https://termux.dev/) is an Android terminal emulator and a Linux environment. It can be used to run most
Linux software without root. This guide will help at setting up and configuring Termux.

## Installation

1. Download and install [Termux](https://termux.dev/). Installing [Termux-API](https://wiki.termux.com/wiki/Termux:API) is also recommended.
2. Run Termux and wait for it to download bootstrap packages.
3. Update packages.[^1]
	```bash
	pkg upgrade
	```
4. If you also installed Termux-API, install the Termux API package.[^1]
	```bash
	pkg install termux-api
	```
5. Configure access to external storage. When Android prompts you to allow access to external storage, press "*Allow*" to continue.
	```bash
	termux-setup-storage
	```

## Recommended Customizations

- [zsh](https://github.com/SetupGuides/ZSH)
- [Neovim](https://github.com/SetupGuides/Neovim)
- [Catppuccin Theme](https://github.com/catppuccin/termux)

## Enabling SSH Remote Connections

Termux supports remote connections via the *Secure SHell (SSH)* protocol. Follow the instructions below to install and configure SSH. More info can be found in [their wiki](https://wiki.termux.com/wiki/Remote_Access#SSH).

1. Install SSH and [termux-services](https://wiki.termux.com/wiki/Termux-services).
	```bash
	pkg install openssh termux-services
	```
2. Set SSH password. (This will prompt you to enter a password twice.)
	```bash
	passwd
	```
3. Enable the `sshd` service by enabling it via termux-services.
	```bash
	sv-enable sshd
	```
4. Using another machine, connect to Termux using the following command:
	```bash
	ssh user@device_ip -p 8022
	```
	Change `user` and `device_ip` with your Termux username and your device's IP address respectively. You can find them using the `whoami` and `ip -c addr` commands, respectively.

[^1]: If you encounter an error, run `$ termux-change-repo` to use a mirror and try again.
