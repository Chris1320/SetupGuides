--[[
vars.lua

This module provides easy-access to variables to the end-user.
]]--

return {
    installed = false,             -- set this to true after running `:PluginSync` in neovim.

    -- Shortcuts
    leaderkey = ',',      -- Set leader key.

    -- Editor
    ctermfg = "grey",     -- The color of the line numbers.
    use_spaces = true,    -- Convert tabs to spaces.
    enable_list = false,  -- enable display of unprintable characters. (spaces, tabs, etc.)
    space_char = '⋅',      -- The character for a space when `list` is enabled.
    eol_char = '↴',       -- The character for EOLs when `list` is enabled.

    -- Plugin Configurations

    -- catppuccin (theme)
    catppuccin_flavour = "mocha",  -- Available flavors: `latte`, `frappe`, `macchiato`, `mocha`

    -- Gitsigns
    git_blame_format = "<author>, on <author_time:%Y-%m-%d> • <summary>",

    -- Treesitter
    languages = {                 -- [add|remove] languages you [don't] want to use.
        "c",                            -- Reference: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
        "css",
        "c_sharp",
        "html",
        "java",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        -- "rust"  -- This fails to compile in Termux so it will not be automatically installed.
        "toml",
        "yaml"
    }
}
