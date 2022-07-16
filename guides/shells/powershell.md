# PowerShell

> "**PowerShell** is a task automation and configuration management program from Microsoft, consisting of a command-line shell and the associated scripting language. Initially a Windows component only, known as *Windows PowerShell*, it was made open-source and cross-platform on 18 August 2016 with the introduction of PowerShell Core. The former is built on the .NET Framework, the latter on .NET Core."

\- [Wikipedia](https://en.wikipedia.org/wiki/PowerShell)

## Customization Features

This customization guide will do the following changes:

- Enable autosuggestion like in [zsh](./zsh.md)'s customization guide.

## Customization

1. Install `PSReadLine`. `PS C:\> Install-Module PSReadLine`
2. Check if your profile already exists by running `PS C:\> Test-path $profile` or manually checking if `$profile` exists. If it doesn't, create it.
3. Open `$profile` and add the following lines:

    ```ps1
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete  # Show all suggestions when tab is pressed.

    # Autocompleteion for Arrow keys
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

    Set-PSReadLineOption -ShowToolTips
    Set-PSReadLineOption -PredictionSource History  # The auto-completion option.
    ```

4. Restart your terminal.

-----

**References**:

- [Fish-like Autosuggestion in Powershell](https://dev.to/animo/fish-like-autosuggestion-in-powershell-21ec)
- [How to add autocomplete to Powershell in 30 seconds](https://dev.to/dhravya/how-to-add-autocomplete-to-powershell-in-30-seconds-2a8p)
