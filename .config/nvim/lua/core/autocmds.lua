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

-- Automatically open nvim-tree on startup
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end
api.nvim_create_autocmd("VimEnter", {
  callback = open_nvim_tree
})

-- Automatically close nvim-tree when it's the last window
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#marvinth01
api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= '' then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end
})
