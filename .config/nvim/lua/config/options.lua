-- Leader key
vim.g.mapleader = '\\'

-- Cache vim.opt for better performance
local opt = vim.opt

-- General settings
opt.clipboard = 'unnamedplus' -- Use system clipboard
opt.cursorline = true -- Highlight the current line
opt.expandtab = true -- Convert tabs to spaces
opt.hlsearch = true -- Highlight search matches
opt.ignorecase = true -- Ignore case when searching
opt.incsearch = true -- Incremental search
opt.laststatus = 3 -- views can only be fully collapsed with the global statusline
opt.number = true -- Show line numbers
opt.relativenumber = false -- Show relative line numbers
opt.shiftwidth = 4 -- Spaces for auto-indent
opt.smartcase = true -- Case-sensitive if uppercase is present
opt.smartindent = true -- Enable smart indentation
opt.spell = true -- Enable spell checking
opt.splitbelow = true -- Open horizontal splits below
opt.splitright = true -- Open vertical splits to the right
opt.tabstop = 4 -- Number of spaces for a tab
opt.updatetime = 300 -- Faster UI updates
opt.wrap = false -- Disable line wrap

-- Whitespace characters
opt.list = true
opt.listchars = {
  tab = '→ ',
  trail = '·',
  eol = '¬',
  extends = '…',
  precedes = '…',
}

-- Undo and backup
opt.undofile = true -- Save undo history
opt.backup = false
opt.swapfile = false

-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
opt.splitkeep = 'screen'
