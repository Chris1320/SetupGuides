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

1. Update apt and install zsh, wget, and git if not yet installed. `$ sudo apt update && sudo apt install --upgrade zsh wget git`
2. Change the shell to zsh. `$ chsh -s $(which zsh)`[^1]
3. Reload your terminal.
4. Download Oh-My-Zsh. `$ sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
5. Install powerlevel10k. `$ git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k`
6. Find and edit the following lines in `~/.zshrc`:

    | Option          | New Value                                |
    |-----------------|------------------------------------------|
    | `ZSH_THEME`     | `powerlevel10k/powerlevel10k`            |
    | `plugins`       | `(command-not-found gh git python sudo)` |

7. Edit `.zshrc` and add the following lines at the end of the file:
    ```zsh
    export LANG=en_US.UTF-8  # Set language environment variable.
    export LESS="--no-init --quit-if-one-screen -R"  # Causes `less` to just write to stdout if the text can be viewed without scrolling.
    export GPG_TTY=$(tty)  # Fix GPG "gpg failed to sign data" error.
    ```
8. (*Optional*) Install Powerlevel10k's [recommended font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k).
9. Reload the terminal. `$ source ~/.zshrc`
10. Follow the on-screen instructions to set up Powerlevel10k.

[^1]: If you encounter an error `chsh: <zsh-path>: non-standard shell`, add the path to `/etc/shells`. `$ echo "$(which zsh)" >> /etc/shells`. In Termux, you might have to use `$ chsh -s zsh` instead.

-----

**References**:

- [GitHub | ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- [GitHub | romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)
