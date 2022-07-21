local vars = require("vars")

Packer = require("packer")

Packer.startup(
    function(use)
        use("wbthomason/packer.nvim")

        -- Linting and syntax checkers
        use("neovim/nvim-lspconfig")                    -- Quickstart configs for Neovim LSP
        use("williamboman/nvim-lsp-installer")          -- Easy install LSP servers.

        use("nvim-treesitter/nvim-treesitter")          -- Treesitter
        use(                                            -- diagnostics, quickfixes, etc.
            {
                "folke/trouble.nvim",
                requires = "kyazdani42/nvim-web-devicons"
            }
        )
        use("github/copilot.vim")                       -- GitHub Copilot

        -- Fuzzy Search
        use(                                            -- Fuzzy finder
            {
                "nvim-telescope/telescope.nvim",
                requires = {{"nvim-lua/plenary.nvim"}}
            }
        )

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
        use("folke/twilight.nvim")                      -- Dim inactive portions of the code

        -- Autocompletion
        use(                                            -- The main autocompletion tool
            {
                "ms-jpq/coq_nvim",
                branch = "coq"
            }
        )
        use(                                            -- coq autocompletion snippets
            {
                "ms-jpq/coq.artifacts",
                branch = "artifacts"
            }
        )
        use(                                            -- coq 3rd-party sources
            {
                "ms-jpq/coq.thirdparty",
                branch = "3p"
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

    end
)

local function setupCatppuccin()
    local catppuccin = require("catppuccin")
    catppuccin.setup(
        {
            --[[
            styles = {
                comments = "italic",
                conditionals = "italic",
                loops = "NONE",
                functions = "NONE",
                keywords = "NONE",
                strings = "NONE",
                variables = "NONE",
                numbers = "NONE",
                booleans = "NONE",
                properties = "NONE",
                types = "NONE",
                operators = "NONE",
            },
            --]]
            integrations = {
                nvimtree = {
                    enabled = true,
                    show_root = true,
                    transparent_panel = true
                },
                gitsigns = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false
                },
                telescope = true,
                treesitter = true,
                which_key = true,
                native_lsp = {
                    enabled = true
                }
            }
        }
    )
    vim.g.catppuccin_flavour = vars["catppuccin_flavour"]  -- Set catppuccin variation
    vim.cmd("colorscheme catppuccin")                   -- Set theme
end

local function setupFeline()
    local feline = require("feline")
    local catppuccin_integration = require("catppuccin.groups.integrations.feline")
    feline.setup(
        {
            components = catppuccin_integration.get()
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
            current_line_blame_formatter = vars["git_blame_format"],
        }
    )
end

local function setupIndentBlankline()
    local indent_blankline = require("indent_blankline")
    indent_blankline.setup(
        --[[
        {
            space_char_blankline = " ",
            char_highlight_list = {
                "IndentBlanklineIndent1",
                "IndentBlanklineIndent2",
                "IndentBlanklineIndent3",
                "IndentBlanklineIndent4",
                "IndentBlanklineIndent5",
                "IndentBlanklineIndent6",
            }
        }
        --]]
    )
end

local function setupWhichKey()
    local which_key = require("which-key")
    which_key.setup()
end

local function setupTwilight()
    local twilight = require("twilight")
    twilight.setup(
        {
            treesitter = true,
            expand = {  -- See https://github.com/folke/twilight.nvim#%EF%B8%8F-configuration for more information.
                "function",
                "method",
                "table",
                "if_statement"
            }
        }
    )
end

local function setupTrouble()
    local trouble = require("trouble")
    trouble.setup()
end

local function setupTelescope()
    local telescope = require("telescope")
    local trouble = require("trouble")
    telescope.setup(
        {
            defaults = {
                mappings = {
                    i = {["<C-t>"] = trouble.open_with_trouble},
                    n = {["<C-t>"] = trouble.open_with_trouble}
                }
            }
        }
    )
end

local function setupNvimTree()
    local nvim_tree = require("nvim-tree")
    nvim_tree.setup(
        {
            filters = {
                dotfiles = false
            }
        }
    )
end

local function setupLspConfig()
    local lsp = require("lspconfig")
    local lsp_installer = require("nvim-lsp-installer")

    -- Setup lspconfig
    lsp.clangd.setup({})  -- enable clangd because we're going to install clang anyway.

    -- Setup nvim-lsp-installer
    lsp_installer.on_server_ready(
        function(server)
            server:setup(
                {
                    automatic_installation = true,
                    --[[
                    ui = {
                        icons = {
                            -- you can change these icons to whatever you want.
                            server_installed = "✓",
                            server_pending = "➜",
                            server_uninstalled = "✗"
                        }
                    }
                    --]]
                }
            )
        end
    )
end

local function setupTreesitter()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup(
        {
            ensure_installed = vars["languages"],  -- Install parsers for languages defined in <languages>.
            highlight = {                  -- Use treesitter's syntax highlighting.
                enable = true
            },
            indent = {                     -- Use treesitter for indentation.
                enable = false             -- Disable indentation because it's currently broken.
            }
        }
    )
end

local function setupCoq()
    local coq = require("coq")
    local coq3p = require("coq_3p")
    coq3p(
        {
            {  -- Requires bc `$ sudo apt install bc`
                src = "bc",
                short_name = "MATH",
                precision = 4
            },
            {
                src = "copilot",
                short_name = "COP",
                accept_key = "<C-f>"
            }
        }
    )
end

if vars["installed"] then
    -- run setup functions
    setupCatppuccin()
    setupFeline()
    setupGitsigns()
    setupIndentBlankline()
    -- setupAutoPairs()
    setupWhichKey()
    setupTwilight()
    setupTrouble()
    setupTelescope()
    setupNvimTree()
    setupLspConfig()
    setupTreesitter()
    setupCoq()

else
    vim.cmd(":PackerSync")

end
