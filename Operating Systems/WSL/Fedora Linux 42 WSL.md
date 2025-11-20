# Fedora Linux 42 WSL

The **Windows Subsystem for Linux** (WSL) is a compatibility layer developed by Microsoft that allows you to run a Linux environment directly on Windows without the need for a virtual machine or dual-boot setup. This guide will show you how I set up my Fedora Linux WSL, which is my main general purpose WSL distribution.

## Requirements

- Windows 11 24H2

## 1. Installing Fedora Linux 42 WSL

First, enable or install Windows Subsystem for Linux. Install Fedora Linux WSL and set it as the default distribution.

```powershell
wsl --install --distribution FedoraLinux-42
wsl --set-default FedoraLinux-42
```

Run the newly-installed distribution. It will ask you to enter a username. By default it does not ask you to set a password so we'll set one ourselves. Obviously, replace `<yourusername>` with the username you've set earlier.

```bash
sudo passwd <yourusername>
```

Update the packages by performing an upgrade.

```bash
sudo dnf upgrade
```

## 2. Setting Up Fedora Linux 42 WSL

Create directories the I always have in my machines.

```bash
cd ~
mkdir Projects Temp
```

Edit DNF's configuration file to make it faster in general. I also added some settings that I find convenient.

```bash
echo 'defaultyes=True' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=True' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
```

Since we did not enable the *Third-Party Repositories* when we were asked earlier, we manually add [RPMFusion](https://rpmfusion.org/).

```bash
# Enable RPMFusion repositories
sudo dnf install \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

More setup information can be found in [this link](https://rpmfusion.org/Configuration).

> [!TIP]- Verifying results
> 
> Verify the results by checking the outputs of the following commands:
> 
> ```bash
> cat /etc/dnf/dnf.conf
> dnf repolist
> ```

Perform an upgrade again to make sure you have the latest updates.

```bash
sudo dnf upgrade -y --refresh
sudo dnf autoremove
```

Install Utilities

```bash
# install essential CLI utilities and libraries
sudo dnf install \
	git git-lfs gh \
	mc unrar p7zip \
    dmg2img trash-cli tmux \
    openssl inxi wl-clipboard

# use full ffmpeg package, if ffmpeg-free is installed
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
```

Install other utilities that I frequently use/nice to have.

```bash
sudo dnf install uv tealdeer
uv tool install howdoi
uv tool install yt-dlp
uv tool install magika
uv tool install jupyterlab
```

### Ricing Your New System

> [!QUESTION] Prerequisites
> 
> I recommend that you use the following customization
> guides first:
>
> - [[ZSH]]
> - [[Neovim]] (recommended only if you are going to use [Neovim](https://neovim.io/) as your main text editor in WSL)

Install `pfetch`

```bash
curl -Lo ~/.local/bin/pfetch "https://raw.githubusercontent.com/Un1q32/pfetch/refs/heads/master/pfetch" && chmod +x ~/.local/bin/pfetch
```
