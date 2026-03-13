-- Core Neovim options

-- ───────────────────────────────
-- General
vim.o.encoding = "utf-8" -- Default file encoding
vim.o.fileencoding = "utf-8"
vim.o.mouse = "a" -- Enable mouse support
vim.o.updatetime = 300 -- Faster completion and CursorHold
vim.o.timeoutlen = 3000 -- Key sequence timeout

-- ───────────────────────────────
-- UI
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Relative line numbers
vim.o.cursorline = true -- Highlight current line
vim.o.termguicolors = true -- True color support
vim.o.signcolumn = "yes" -- Always show sign column
vim.o.scrolloff = 2 -- Keep 8 lines visible when scrolling
vim.o.sidescrolloff = 8 -- Horizontal scroll buffer

-- ───────────────────────────────
-- Tabs & Indentation
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.shiftwidth = 4 -- Shift 4 spaces when indenting
vim.o.tabstop = 4 -- A tab equals 4 spaces
vim.o.softtabstop = 4
vim.o.smartindent = true -- Auto-indent new lines
vim.o.autoindent = true

-- ───────────────────────────────
-- Search
vim.o.ignorecase = true -- Case insensitive search
vim.o.smartcase = true -- Case-sensitive if capital letters
vim.o.hlsearch = true -- Highlight matches
vim.o.incsearch = true -- Incremental search

-- ───────────────────────────────
-- Backup & Undo
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true -- Persistent undo
vim.o.undodir = vim.fn.stdpath("data") .. "/undo"

-- ───────────────────────────────
-- Splits
vim.o.splitright = true -- Vertical splits to the right
vim.o.splitbelow = true -- Horizontal splits below

-- ───────────────────────────────
-- Performance
vim.o.lazyredraw = true -- Faster macros
vim.o.showmode = false -- Disable mode since statusline shows it
vim.o.completeopt = "menuone,noselect" -- For completion plugins

-- ───────────────────────────────
-- File Explorer / Misc
vim.o.backspace = "indent,eol,start" -- Make backspace behave like normal
vim.o.wildmenu = true -- Command-line completion menu
vim.o.wildmode = "longest:full,full"

-- ───────────────────────────────
-- Folding (treesitter friendly)
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99 -- Open all folds by default
