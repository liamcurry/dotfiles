-- lua/core/keymaps.lua
local map = vim.keymap.set

-- Leader key
vim.g.mapleader = '\\'

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Buffer navigation
map('n', '<C-n>', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '<C-p>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- File explorer (NERDTree equivalent using `nvim-tree`)
map('n', '<leader>w', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })

-- Pane splitting
map('n', '<leader>-', ':split<CR>', { desc = 'Horizontal split' })
map('n', '<leader>\\', ':vsplit<CR>', { desc = 'Vertical split' })
map('n', '<leader>q', ':q<CR>', { desc = 'Close pane' })

-- Search and replace
map('n', '<leader>r', ':%s///g<Left><Left>', { desc = 'Search and replace' })

-- Copy to clipboard
map('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })

-- Save file
map('n', '<leader>s', ':w<CR>', { desc = 'Save file' })

-- Commenting
map('n', '<leader>c', ':norm gcc<CR>', { desc = 'Toggle comment on current line' })
map('v', '<leader>c', 'gc', { remap = true, desc = 'Toggle comment on selection' })

