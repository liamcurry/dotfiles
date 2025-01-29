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

-- LSP Configuration
local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup {}

-- Function to format on save
local default_on_attach = function(client, bufnr)
    if client.supports_method("textDocument/inlayHint") then
        -- this isn't working
        vim.defer_fn(function()
            vim.lsp.inlay_hint.enable(true)
        end, 100)  -- Delay by 100ms to ensure LSP is fully ready
    end
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format { async = false }
            end,
        })
    end
end

-- Rust (via rust-analyzer)
lspconfig.rust_analyzer.setup {
    on_attach = default_on_attach,
}

-- YAML (via yamlls)
lspconfig.yamlls.setup {
    -- :h
    on_attach = default_on_attach,
    settings = { yaml = { format = { enable = true } } }
}

-- TOML (via Taplo)
lspconfig.taplo.setup { on_attach = default_on_attach }

-- JSON
lspconfig.jsonls.setup { on_attach = default_on_attach }

-- Lua (via stylua)
lspconfig.lua_ls.setup {
    on_attach = default_on_attach,
    settings = { Lua = { format = { enable = true } } }
}

-- Markdown (via prettier)
lspconfig.marksman.setup { on_attach = default_on_attach }
