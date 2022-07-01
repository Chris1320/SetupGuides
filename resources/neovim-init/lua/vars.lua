--[[
vars.lua

This module provides easy-access to variables to the end-user.
]]--

local installed = false             -- set this to true after running `:PluginSync` in neovim.

-- Shortcuts
local leaderkey = ','      -- Set leader key.

-- Editor
local ctermfg = "grey"     -- The color of the line numbers.
local use_spaces = true    -- Convert tabs to spaces.
local enable_list = false  -- enable display of unprintable characters. (spaces, tabs, etc.)
local space_char = '⋅'      -- The character for a space when `list` is enabled.
local eol_char = '↴'       -- The character for EOLs when `list` is enabled.

-- Plugin Configurations

-- catppuccin (theme)
local catppuccin_flavour = "mocha"  -- Available flavors: `latte`, `frappe`, `macchiato`, `mocha`

-- LSP
local lsp_enable_csharp = false     -- Enable C# support; requires dotnet or mono.
local lsp_use_mono = false           -- Use mono instead of dotnet

-- Gitsigns
local git_blame_format = "<author>, on <author_time:%Y-%m-%d> • <summary>"

-- Treesitter
local languages = {                 -- [add|remove] languages you [don't] want to use.
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
