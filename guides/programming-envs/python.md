# Python

This guide will help you install Python 3 in your system and install commonly-used modules.

## Installation

- Windows
    1. Navigate to the [Python download page](https://www.python.org/downloads/) and download the latest release of Python.
    2. Install the downloaded file.
    3. Open a terminal and run `$ python --version` to verify that Python is installed correctly.
- Linux
    1. Download Python via apt. `$ sudo apt install --upgrade python3 python3-pip python3-venv`[^1]
    2. Verify that the installation was successful by running `$ python --version`.

## Commonly-Used Modules

To install commonly-used modules, run the following commands in a terminal.[^1]

`$ sudo pip3 install --upgrade pip wheel build setuptools twine`
`$ sudo pip3 install --upgrade flake8 requests tqdm youtube-dl pytest`

[^1]: In termux, there's no need to use `sudo`.
