-- LSP Configuration
--
--
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local cmp_lsp = require('cmp_nvim_lsp')

local function setup_cmp_lsp(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Custom keybindings for LSP actions
  vim.keymap.set('n', '<C-i>', vim.lsp.buf.definition, opts) -- Ctrl-i for go to definition
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- Hover documentation
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- Rename symbol
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions
end

-- Hook into LspAttach event to trigger retry-based inlay hint activation
local function default_on_attach(client, bufnr)
  setup_cmp_lsp(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end

  if client and client.supports_method('textDocument/inlayHints') then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

local function is_installed(bin)
  return vim.fn.executable(bin) == 1
end

-- Enable capabilities for nvim-cmp
local capabilities = cmp_lsp.default_capabilities()

if is_installed('rust-analyzer') then
  lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = default_on_attach,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = { command = 'clippy' },
        cargo = { loadOutDirsFromCheck = true },
        procMacro = { enable = true },
      },
    },
  })
end

if is_installed('clangd') then
  lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = default_on_attach,
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  })
end

if is_installed('yaml-language-server') then
  lspconfig.yamlls.setup({
    capabilities = capabilities,
    on_attach = default_on_attach,
    filetypes = { 'yaml', 'yml' },
    settings = {
      yaml = {
        format = {
          enable = false,
        },
        validate = true,
        hover = true,
        completion = true,
        schemas = {},
        schemaStore = {
          enable = true,
          url = 'https://www.schemastore.org/api/json/catalog.json',
        },
        customTags = {
          '!include scalar', -- Add custom tags if necessary
          '!reference sequence',
        },
      },
    },
  })
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.txt#lua_ls
if is_installed('lua-language-server') then
  -- Define a custom function to format with Stylua
  local function format_with_stylua()
    local filepath = vim.fn.expand('%:p')

    -- Run Stylua with stdin and capture the output
    local stylua_output = vim.fn.system({
      'stylua',
      '--config-path',
      vim.fn.expand('~/.config/stylua.toml'),
      '--stdin-filepath',
      filepath,
      '-',
    }, vim.api.nvim_buf_get_lines(0, 0, -1, true))

    -- Check if the command succeeded
    if vim.v.shell_error == 0 then
      -- Replace buffer content with Stylua output
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(stylua_output, '\n'))

      -- Mark the buffer as modified
      vim.bo.modified = true
    else
      print('Stylua formatting failed: ', stylua_output)
    end
  end

  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      setup_cmp_lsp(client, bufnr)
      -- Setup Stylua formatting on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          format_with_stylua()
        end,
      })
    end,
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            -- Depending on the usage, you might want to add additional paths here.
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          },
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
          -- library = vim.api.nvim_get_runtime_file("", true)
        },
      })
    end,
    settings = {
      Lua = {
        format = { enable = false },
      },
    },
    root_dir = util.root_pattern('.git', 'init.lua'),
  })
end

lspconfig.dprint.setup({
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'jsonc',
    'markdown',
    'python',
    'toml',
    'roslyn',
    'graphql',
    'yaml',
    'yml',
  },
  on_attach = default_on_attach,
})

lspconfig.harper_ls.setup({})

-- LSP servers that don't require any additional configuration

local servers = {
  ts_ls = 'typescript-language-server',
  gopls = 'gopls',
  buf_ls = 'buf',
  bashls = 'bash-language-server',
  gitlab_ci_ls = 'gitlab-ci-ls',
  marksman = 'marksman',
}

for server, binary in pairs(servers) do
  if is_installed(binary) then
    lspconfig[server].setup({

      on_attach = default_on_attach,
    })
  end
end

