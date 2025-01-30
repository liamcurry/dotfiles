-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all', -- Install all supported languages
  highlight = { enable = true },
}

-- Telescope
require('telescope').setup {}

-- Git Signs
require('gitsigns').setup {}

-- File Explorer
require('nvim-tree').setup {}

-- Statusline
require('lualine').setup {
  options = { theme = 'auto' },
}

-- require('codecompanion').setup {
--   settings = {
--     strategies = {
--       chat = {
--         adapter = 'ollama',
--       },
--       inline = {
--         adapter = 'ollama',
--       },
--     },
--   },
-- }

-- Setup for nvim-cmp and LuaSnip
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- Trigger completion menu with Ctrl+Space
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Confirm selection with Enter
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    -- Navigate through suggestions
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

    -- Scroll documentation in completion window
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
  performance = {
    fetching_timeout = 200,
  },
  completion = {
    completeopt = 'menu,menuone,noselect',
  },
})

