-- LSP Configuration
local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup {}

-- Treesitter
require("nvim-treesitter.configs").setup {
    ensure_installed = "all", -- Install all supported languages
    highlight = { enable = true },
}

-- Telescope
require("telescope").setup {}

-- Git Signs
require("gitsigns").setup {}

-- File Explorer
require("nvim-tree").setup {}

-- Statusline
require("lualine").setup {
    options = { theme = "auto" }
}
