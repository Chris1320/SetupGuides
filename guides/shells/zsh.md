# Zsh

> "The [Z shell](https://www.zsh.org/) is a Unix shell that can be used as an interactive login shell and as a command interpreter for shell scripting. Zsh is an extended Bourne shell with many improvements, including some features of Bash, ksh, and tcsh."

\- [Wikipedia](https://en.wikipedia.org/wiki/Z_shell)

## Customization Features

This customization guide will do the following changes:

- Install zsh, wget, and git packages.
- Change your terminal shell to [zsh](https://www.zsh.org/).
- Install [oh-my-zsh](https://ohmyz.sh/), a zsh configuration manager.
- Install [powerlevel10k](https://github.com/romkatv/powerlevel10k), a custom theme for zsh.

## Installation & Customization

> [***NOTE***] This guide assumes that you are using `apt` as your package manager.

1. Update apt and install zsh, wget, and git if not yet installed. `$ sudo apt update && sudo apt install zsh wget git`
2. Change the shell to zsh. `$ chsh -s $(which zsh)`
3. Download Oh-My-Zsh. `$ sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
4. Install powerlevel10k. `$ git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k`
5. Find and edit the following lines in `~/.zshrc`:
    | Option          | New Value                                |
    |-----------------|------------------------------------------|
    | `ZSH_THEME`     | `powerlevel10k/powerlevel10k`            |
    | `plugins`       | `(command-not-found gh git python sudo)` |

6. Edit `.zshrc` and add the following lines at the end of the file:
    ```zsh
    export LANG=en_US.UTF-8  # Set language environment variable.
    export LESS="--no-init --quit-if-one-screen -R"  # Causes `less` to just write to stdout if the text can be viewed without scrolling.
    export GPG_TTY=$(tty)  # Fix GPG "gpg failed to sign data" error.
    ```
7. Reload the terminal. `$ source ~/.zshrc`
8. Follow the setup steps of Oh-my-zsh and Powerlevel10k.

-----

**References**:

- [GitHub | ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- [GitHub | romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)
