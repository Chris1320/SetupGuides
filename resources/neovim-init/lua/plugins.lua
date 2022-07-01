----- Quick-change variables
local installed = false  -- set this to true after running `:PluginSync` in neovim.
local catppuccin_flavour = "mocha"
-- local git_blame_format = "<author>, on <author_time:%Y-%m-%d> • <summary>"
local git_blame_format = "<author>, on <author_time:%Y-%m-%d> • <summary>"
local languages = {  -- [add|remove] languages you [don't] want to use.
    "c",             -- Reference: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
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
----- Quick-change variables

local function fileExists(filepath)
    local ok, err, code = os.rename(filepath, filepath)
    if not ok then
        if code == 13 then
            return true
        end
    end
    return false
end

Packer = require("packer")

Packer.startup(
    function()
        use("wbthomason/packer.nvim")

        -- Visual plugins
        use(                                            -- Catppuccin theme
            {
                "catppuccin/nvim",
                as = "catppuccin"
            }
        )
        use(                                            -- Git signs
            {
                "lewis6991/gitsigns.nvim",
                -- tag = "release"
            }
        )
        use("feline-nvim/feline.nvim")                  -- Customizable statusline
        use("lukas-reineke/indent-blankline.nvim")      -- Indentation guides
        use("jiangmiao/auto-pairs")                     -- Bracket auto-pairing
        use("folke/which-key.nvim")                     -- Displays possible key bindings

        -- Fuzzy Search
        use(                                            -- Fuzzy finder
            {
                "nvim-telescope/telescope.nvim",
                requires = {{"nvim-lua/plenary.nvim"}}
            }
        )

        -- File explorer
        use(
            {
                "kyazdani42/nvim-tree.lua",
                requires = {{"kyazdani42/nvim-web-devicons"}},
                -- tag = "nightly"  -- optional
            }
        )

        -- Linting and syntax checkers
        use("neovim/nvim-lspconfig")                    -- Quickstart configs for Neovim LSP
        use("williamboman/nvim-lsp-installer")          -- Easy install LSP servers.

        use(                                            -- Treesitter
            {
                "nvim-treesitter/nvim-treesitter",
                run = ":TSUpdate"  -- Update parsers at startup.
            }
        )

        -- use("nvie/vim-flake8")                          -- Python syntax checker
        -- use("rust-lang/rust.vim")                       -- Rust syntax checker

    end
)

local function setupCatppuccin()
    local catppuccin = require("catppuccin")
    catppuccin.setup(
        {
            -- styles = {
            --     comments = "italic",
            --     conditionals = "italic",
            --     loops = "NONE",
            --     functions = "NONE",
            --     keywords = "NONE",
            --     strings = "NONE",
            --     variables = "NONE",
            --     numbers = "NONE",
            --     booleans = "NONE",
            --     properties = "NONE",
            --     types = "NONE",
            --     operators = "NONE",
            -- },
            integrations = {
                nvimtree = {
                    enabled = true,
                    show_root = true,
                    transparent_panel = true
                },
                -- feline = true,
                gitsigns = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false
                },
                telescope = true,
                treesitter = true,
                which_key = true
            }
        }
    )
    vim.g.catppuccin_flavour = catppuccin_flavour  -- Set catppuccin variation
    vim.cmd("colorscheme catppuccin")              -- Set theme
end

local function setupFeline()
    local feline = require("feline")
    feline.setup(
        {
            components = require('catppuccin.core.integrations.feline')
        }
    )
end

local function setupGitsigns()
    local gitsigns = require("gitsigns")
    gitsigns.setup(
        {
            current_line_blame = true,
            current_line_blame_opts = {
              virt_text = true,
              virt_text_pos = 'eol',
              delay = 1000,
              ignore_whitespace = false
            },
            current_line_blame_formatter = git_blame_format,
        }
    )
end

local function setupIndentBlankline()
    local indent_blankline = require("indent_blankline")
    indent_blankline.setup(
        -- {
        --     space_char_blankline = " ",
        --     char_highlight_list = {
        --         "IndentBlanklineIndent1",
        --         "IndentBlanklineIndent2",
        --         "IndentBlanklineIndent3",
        --         "IndentBlanklineIndent4",
        --         "IndentBlanklineIndent5",
        --         "IndentBlanklineIndent6",
        --     }
        -- }
    )
end

-- local function setupAutoPairs()
--     local auto_pairs = require("auto_pairs")
--     auto_pairs.setup()
-- end

local function setupWhichKey()
    local which_key = require("which-key")
    which_key.setup()
end

local function setupTelescope()
    local telescope = require("telescope")
    telescope.setup()
end

local function setupNvimTree()
    local nvim_tree = require("nvim-tree")
    nvim_tree.setup()
end

local function setupLspConfig()
    local lsp = require("lspconfig")
    local lsp_installer = require("nvim-lsp-installer")

    lsp_installer.on_server_ready(
        function(server)
            server:setup(
                {
                    automatic_installation = true,
                    -- ui = {
                    --     icons = {
                    --         -- you can change these icons to whatever you want.
                    --         server_installed = "✓",
                    --         server_pending = "➜",
                    --         server_uninstalled = "✗"
                    --     }
                    -- }
                }
            )
        end
    )
end

local function setupTreesitter()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup(
        {
            ensure_installed = languages,
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            }
        }
    )
end

if installed then
    -- run setup functions
    setupCatppuccin()
    setupFeline()
    setupGitsigns()
    setupIndentBlankline()
    -- setupAutoPairs()
    setupWhichKey()
    setupTelescope()
    setupNvimTree()
    setupLspConfig()
    setupTreesitter()

else
    vim.cmd(":PackerSync")

end
