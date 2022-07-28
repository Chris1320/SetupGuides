# Firefox Nightly

This guide helps you install the following extensions:

- Tracking, Privacy, and Security
    - [Cookie AutoDelete](https://addons.mozilla.org/en-US/firefox/addon/cookie-autodelete/): Keeps your browser clean.
    - [Cookie Quick Manager](https://addons.mozilla.org/en-US/firefox/addon/cookie-quick-manager/): Browser Cookie Manager.
    - [DuckDuckGo Privacy Essentials](https://addons.mozilla.org/en-US/firefox/addon/duckduckgo-for-firefox/): [DuckDuckGo](https://duckduckgo.com/)'s browser extension.
    - [FastForward](https://addons.mozilla.org/en-US/firefox/addon/fastforwardteam/): Skip URL shorteners.
    - [KeePassXC-Browser](https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser/): [KeePassXC](https://keepassxc.org/) Password Manager Browser Extension.
    - [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/): An efficient wide-spectrum content blocker.
- Productivity
    - [BetterTTV](https://addons.mozilla.org/en-US/firefox/addon/betterttv/): [Twitch](https://twitch.tv/) and [YouTube](https://youtube.com/) enhancer.
    - [Dark Reader](https://addons.mozilla.org/en-US/firefox/addon/darkreader/): Provides dark mode for every website.
    - [Enhancer for YouTube™](https://addons.mozilla.org/en-US/firefox/addon/enhancer-for-youtube/): More features for YouTube.
    - [Firefox Multi-Account Containers](https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/): Separates cookies by container.
    - [LanguageTool](https://addons.mozilla.org/en-US/firefox/addon/languagetool/): Style and Grammar checker.
    - [Reddit Enhancement Suite](https://addons.mozilla.org/en-US/firefox/addon/reddit-enhancement-suite/): [Old Reddit](https://old.reddit.com/) enhancer.
    - [Return YouTube Dislike](https://addons.mozilla.org/en-US/firefox/addon/return-youtube-dislikes/): Returns YouTube Dislikes.
    - [SponsorBlock for YouTube](https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/): Skip YouTube video sponsors.
    - [XDM Browser Monitor](https://addons.mozilla.org/en-US/firefox/addon/xdm-browser-monitor/): Sends download URLs to XDM Download Manager.
- Themes
    - [Catppuccin](https://addons.mozilla.org/en-US/firefox/addon/catppuccin-mocha-teal/): Soothing pastel theme.

This installation guide has been tested on the following environments:

- **Firefox Nightly 104.0a1** (2022-07-24) on *Windows 11 Pro 21H2*.
- **Firefox Stable 102.0.1** on *Linux Mint 20.3 Cinnamon*.

## Customization Guide

1. Double-check your settings in `about:preferences`.
2. Install the [Catppuccin](https://addons.mozilla.org/en-US/firefox/addon/catppuccin-mocha-teal/) theme.
3. **uBlock Origin**

    1. Install [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/) ad blocking extension.[^1]
    2. Open uBlock Origin's dashboard and go to `Filter lists` tab.
    3. Add the following filter lists by checking `Custom > Import` and adding the following lines:

        ```text
        https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt
        https://raw.githubusercontent.com/llacb47/miscfilters/master/antipaywall.txt
        https://raw.githubusercontent.com/bogachenko/fuckfuckadblock/master/fuckfuckadblock.txt
        ```

    4. Enable more filter lists if you like.

4. **Firefox Multi-Account Containers**

    1. Install [Firefox Multi-Account Containers](https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/) extension.[^1]
    2. Restart Firefox and customize the containers to your liking.

5. Install [Dark Reader](https://addons.mozilla.org/en-US/firefox/addon/darkreader/).[^1]
6. Add [DuckDuckGo Privacy Essentials](https://addons.mozilla.org/en-US/firefox/addon/duckduckgo-for-firefox/) to Firefox.[^1]
7. Add [FastForward](https://addons.mozilla.org/en-US/firefox/addon/fastforwardteam/).[^1]
8. **Cookie AutoDelete**

    1. Install [Cookie AutoDelete](https://addons.mozilla.org/en-US/firefox/addon/cookie-autodelete/).[^1]
    2. Customize Cookie AutoDelete to whitelist/greylist websites.

9. Install [Return YouTube Dislike](https://addons.mozilla.org/en-US/firefox/addon/return-youtube-dislikes/).[^1]
10. **Enhancer for YouTube™**

    1. Get [Enhancer for YouTube](https://addons.mozilla.org/en-US/firefox/addon/enhancer-for-youtube/) for Firefox.[^1]
    2. Import the provided [settings file](https://github.com/Chris1320/SetupGuides/blob/main/resources/firefox/enhancer-for-youtube/config.json) or edit the settings to how you like it.

11. Install [SponsorBlock for YouTube](https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/)[^1] and customize it to your liking.
12. Install [BetterTTV](https://addons.mozilla.org/en-US/firefox/addon/betterttv/) and customize it if you want.
13. Add [Reddit Enhancement Suite](https://addons.mozilla.org/en-US/firefox/addon/reddit-enhancement-suite/) to Firefox.
14. Download and install [LanguageTool](https://addons.mozilla.org/en-US/firefox/addon/languagetool/) extension for Firefox.
15. Install [KeePassXC-Browser](https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser/) **if** you are using [KeePassXC](https://keepassxc.org/) as your password manager.
16. Get [Cookie Quick Manager](https://addons.mozilla.org/en-US/firefox/addon/cookie-quick-manager/).[^1][^2]
17. Add [XDM Browser Monitor](https://addons.mozilla.org/en-US/firefox/addon/xdm-browser-monitor/) **if** you are using [XDM Download Manager](https://xtremedownloadmanager.com/).

[^1]: If prompted, allow the extension to run in private windows.
[^2]: You can skip it since it is rarely used. (e.g., grabbing site cookies)
