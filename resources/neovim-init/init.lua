-- This is an init.lua file for Neovim.
-- You can get this script from:
-- https://github.com/Chris1320/SetupGuides/tree/main/resources/neovim-init

-- Reminders:
-- vim.g    -- global variables (`let` command in vim)
-- vim.fn   -- functions
-- vim.cmd  -- commands
-- vim.opt  -- options (`set` command in vim)

local vars = require("vars")  -- load variables

vim.g.mapleader = vars["leaderkey"]                         -- Set leader key.
vim.cmd("filetype plugin on")                               -- enable loading plugins for specific file types.

-- Editor-related configuration
vim.opt.number = true                                       -- enable line numbers.
vim.opt.showmatch = true                                    -- show matching brackets.
vim.opt.cursorline = true                                   -- enable cursor line.
vim.opt.wrap = false                                        -- Disable line wrapping.
vim.opt.wildmode = {"longest", "list"}                      -- get bash-like tab completions.
vim.opt.mouse = 'a'                                         -- enable usage of mouse in all modes.
vim.opt.clipboard = "unnamedplus"                           -- enable usage of system clipboard.
vim.opt.ttyfast = true                                      -- indicate fast terminal connection to speed up scrolling.
vim.opt.termguicolors = true                                -- enable for consistent color scheme across terminals.
vim.cmd("syntax on")                                        -- enable syntax highlighting
vim.cmd("highlight LineNr ctermfg=" .. vars["ctermfg"])     -- Set the color of the line numbers

-- Search-related configuration
vim.opt.hlsearch = true                                     -- highlight search results.
vim.opt.incsearch = true                                    -- enable incremental search.
vim.opt.smartcase = true                                    -- smart case searching.
vim.opt.ignorecase = true                                   -- case insensitive when searching.
vim.opt.magic = true                                        -- enable regex.

-- Indentation-related configuration
vim.cmd("filetype plugin indent on")                        -- allow auto-indentation depending on file type.
vim.opt.autoindent = true                                   -- Enable auto indent.
-- vim.opt.smartindent = true                               -- Enable smart indent.
vim.opt.indentexpr = "nvim_treesitter#indentexpr()"         -- Use treesitter for indentation.
vim.opt.expandtab = vars["use_spaces"]                      -- converts tabs to white space.
vim.opt.shiftwidth = 4                                      -- width for autoindents.
vim.opt.tabstop = 4                                         -- number of columns occupied by a tab.
vim.opt.softtabstop = 4                                     -- see multiple spaces as tabstops so <BS> does the right thing.

vim.opt.foldmethod = "expr"                                 -- use treesitter to determine where to fold.
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"             -- the expression to use for folding.

vim.opt.foldlevel = 99                                      -- fold level.
vim.opt.list = true                                         -- enable display of unprintable characters.
if vars["show_eols"] then                                   -- Enable if you want to display spaces, trailing spaces, and EOLs.
    vim.opt.listchars:append("eol:" .. vars["eol_char"])
end
if vars["show_spaces"] then
    vim.opt.listchars:append("space:" .. vars["space_char"])
end
if vars["show_trails"] then
    vim.opt.listchars:append("trail:" .. vars["trail_char"])
end

-- Start packer
require("plugins")

-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

-- shortcuts
local cmd_opts = {noremap=true, silent=true}

-- Set Neovim shortcuts
vim.keymap.set('n', "<leader>/", ":nohlsearch<cr>", cmd_opts)

-- Barbar shortcuts
vim.keymap.set('n', "<A-,>", ":BufferPrevious<cr>", cmd_opts)      -- Navigate buffers
vim.keymap.set('n', "<A-.>", ":BufferNext<cr>", cmd_opts)

vim.keymap.set('n', "<A-1>", ":BufferGoto 1<cr>", cmd_opts)
vim.keymap.set('n', "<A-2>", ":BufferGoto 2<cr>", cmd_opts)
vim.keymap.set('n', "<A-3>", ":BufferGoto 3<cr>", cmd_opts)
vim.keymap.set('n', "<A-4>", ":BufferGoto 4<cr>", cmd_opts)
vim.keymap.set('n', "<A-5>", ":BufferGoto 5<cr>", cmd_opts)
vim.keymap.set('n', "<A-6>", ":BufferGoto 6<cr>", cmd_opts)
vim.keymap.set('n', "<A-7>", ":BufferGoto 7<cr>", cmd_opts)
vim.keymap.set('n', "<A-8>", ":BufferGoto 8<cr>", cmd_opts)
vim.keymap.set('n', "<A-9>", ":BufferGoto 9<cr>", cmd_opts)
vim.keymap.set('n', "<A-0>", ":BufferLast<cr>", cmd_opts)

vim.keymap.set('n', "<A-<>", ":BufferMovePrevious<cr>", cmd_opts)  -- Re-order buffers
vim.keymap.set('n', "<A->>", ":BufferMoveNext<cr>", cmd_opts)

vim.keymap.set('n', "<leader>bp", ":BufferPin<cr>")                -- More barbar shortcuts
vim.keymap.set('n', "<leader>bon", ":BufferOrderByBufferNumber<cr>")
vim.keymap.set('n', "<leader>bod", ":BufferOrderByDirectory<cr>")
vim.keymap.set('n', "<leader>bol", ":BufferOrderByLanguage<cr>")
vim.keymap.set('n', "<leader>bow", ":BufferOrderByWindowNumber<cr>")

vim.keymap.set('n', "<leader>be", ":BarbarEnable")                 -- Enable/disable barbar
vim.keymap.set('n', "<leader>bd", ":BarbarDisable")

-- Telescope shortcuts
vim.keymap.set('n', "<leader>tt", ":Telescope<cr>")
vim.keymap.set('n', "<leader>tb", ":Telescope buffers<cr>")
vim.keymap.set('n', "<leader>tF", ":Telescope find_files<cr>")
vim.keymap.set('n', "<leader>ts", ":Telescope treesitter<cr>")
vim.keymap.set('n', "<leader>tf", ":Telescope current_buffer_fuzzy_find<cr>")

-- Trouble shortcuts
vim.keymap.set('n', "<leader>ewd", ":TroubleToggle workspace_diagnostics<cr>")
vim.keymap.set('n', "<leader>edd", ":TroubleToggle document_diagnostics<cr>")
vim.keymap.set('n', "<leader>eqf", ":TroubleToggle quickfix<cr>")
vim.keymap.set('n', "<leader>elr", ":TroubleToggle lsp_references<cr>")
vim.keymap.set('n', "<leader>elc", ":TroubleToggle loclist<cr>")

-- nvim-tree shortcuts
vim.keymap.set('n', "<leader>fo", ":NvimTreeOpen<cr>")
vim.keymap.set('n', "<leader>fc", ":NvimTreeClose<cr>")
vim.keymap.set('n', "<leader>ff", ":NvimTreeFocus<cr>")
vim.keymap.set('n', "<leader>ft", ":NvimTreeToggle<cr>")

-- coq shortcuts
vim.keymap.set('n', "<leader>cc", ":COQnow --shut-up<cr>")

-- Gitsigns shortcuts
vim.keymap.set('n', "<leader>gdt", ":Gitsigns diffthis<cr>")

-- twilight shortcuts
vim.keymap.set('n', "<leader>z", ":Twilight<cr>")
