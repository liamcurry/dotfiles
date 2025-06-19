return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },

  opts = function()
    ---@type conform.setupOpts
    local opts = {
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { 'dprint', 'prettierd', 'prettier', stop_after_first = true },
        dockerfile = { 'dprint' },
        json = { 'dprint' },
        markdown = { 'dprint' },
        toml = { 'taplo' },
      },
      -- Set default options
      default_format_opts = {
        lsp_format = 'fallback',
      },
      -- Customize formatters
      ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
      formatters = {
        dprint = {
          -- Custom function to determine arguments based on file location
          args = function()
            -- Cache frequently used functions
            local getcwd = vim.fn.getcwd
            local filereadable = vim.fn.filereadable
            local expand = vim.fn.expand

            -- Check for local dprint config
            local cwd = getcwd()
            local has_local = filereadable(cwd .. '/.dprint.json') == 1 or filereadable(cwd .. '/dprint.json') == 1

            if has_local then
              return { 'fmt', '--stdin', '$FILENAME' }
            else
              return { 'fmt', '--config', expand('~/.config/dprint.json'), '$FILENAME' }
            end
          end,
        },
        shfmt = {
          prepend_args = { '-i', '2' },
        },
        taplo = {
          args = { 'format', '--config', vim.fn.expand('~/.config/taplo.toml'), '-' },
        },
      },
    }
    return opts
  end,
  -- This will provide type hinting with LuaLS
  ---@module 'conform'
  ---@type conform.setupOpts
}
