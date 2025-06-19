return {
  'neovim/nvim-lspconfig',
  ---@type PluginLspConfigOpts
  opts = {
    -- Automatically format on save
    autoformat = true,
    -- Configure lua language server for neovim
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
    },
  },
}
