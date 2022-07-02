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

```
$ pip3 install --upgrade pip wheel build setuptools twine
$ pip3 install --upgrade flake8 requests tqdm yt-dlp pytest
```

- Package Management & Building
    - `pip`: Python package manager.
    - `wheel`: Install Python wheels.
    - `build`: PEP 517 build front-end.
    - `setuptools`: Python package manager.
    - `twine`: For publishing Python packages to PyPI.
- Linting
    - `flake8`: Python source code checker.
- Networking
    - `requests`: Python HTTP library.
- UI & Graphics
    - `tqdm`: A progress meter.
- Unit Testing
    - `pytest`: Test Python packages.
- Others
    - `youtube-dl`: YouTube video downloader.

[^1]: In Termux, there's no need to use `sudo`. You also need to `export CARGO_BUILD_TARGET=<arch>` to install cryptography successfully.
