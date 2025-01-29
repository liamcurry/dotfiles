-- lua/core/autocmds.lua
local api = vim.api

-- Highlight yanked text
api.nvim_create_autocmd("TextYankPost", {
  group = api.nvim_create_augroup("HighlightYank", {}),
  callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})

-- Automatically remove trailing whitespace on save
api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

-- Automatically open nvim-tree on startup
api.nvim_create_autocmd("VimEnter", {
  callback = open_nvim_tree
})

