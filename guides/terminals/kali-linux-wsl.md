# Kali Linux WSL (Windows Subsystem for Linux)

Kali Linux is a Linux distribution that is mainly used for penetration testing. It is currently available as a [Windows Subsystem for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) (WSL) distribution.

## Installation

1. Install the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install).
2. Install Kali Linux WSL. `PS C:\> wsl --install -d kali-linux`
3. Follow the on-screen instructions.
4. Update packages. `$ sudo apt update && sudo apt upgrade`
5. (*Optional*) Remove Windows path in WSL.
    - Open `/etc/wsl.conf` and add the following lines:
        ```
        [interop]

        appendWindowsPath=false
        ```
    - Close the terminal and restart WSL. `PS C:\> wsl --shutdown kali-linux`

## Recommended Customizations

- [zsh](../shells/zsh.md)
- [neovim](../text-editors/neovim.md)
