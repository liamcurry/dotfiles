local opt = vim.opt

-- General settings
opt.number = true -- Show line numbers
opt.relativenumber = false -- Show relative line numbers
opt.wrap = false -- Disable line wrap
opt.tabstop = 4 -- Number of spaces for a tab
opt.shiftwidth = 4 -- Spaces for auto-indent
opt.expandtab = true -- Convert tabs to spaces
opt.smartindent = true -- Enable smart indentation
opt.clipboard = 'unnamedplus' -- Use system clipboard
opt.updatetime = 300 -- Faster UI updates
opt.incsearch = true -- Incremental search
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Case-sensitive if uppercase is present
opt.hlsearch = true -- Highlight search matches
opt.cursorline = true -- Highlight the current line
opt.splitright = true -- Open vertical splits to the right
opt.splitbelow = true -- Open horizontal splits below
opt.spell = true -- Enable spell checking

-- Whitespace characters
opt.list = true
opt.listchars = { tab = '→ ', trail = '·', eol = '¬', extends = '…', precedes = '…' }

-- Undo and backup
opt.undofile = true -- Save undo history
opt.backup = false
opt.swapfile = false

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup#netrw-hijacking
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

