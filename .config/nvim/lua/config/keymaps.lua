-- Keymap configurations
local map = vim.keymap.set

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Buffer navigation
map('n', '<C-n>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<C-p>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })

-- Pane splitting
map('n', '<leader>-', '<cmd>split<CR>', { desc = 'Horizontal split' })
map('n', '<leader>\\', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Close pane' })

-- Search and replace
map('n', '<leader>r', '<cmd>%s///g<Left><Left><Left>', { desc = 'Search and replace' })

-- Copy to clipboard
map('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })

-- Save file
map('n', '<leader>s', '<cmd>w<CR>', { desc = 'Save file' })

-- Commenting
map('n', '<leader>c', '<cmd>norm gcc<CR>', { desc = 'Toggle comment on current line' })
map('v', '<leader>c', 'gc', { remap = true, desc = 'Toggle comment on selection' })
