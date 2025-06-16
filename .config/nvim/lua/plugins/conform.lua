return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
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
            -- First try to use local .dprint.json or dprint.json in project
            -- dprint automatically checks for these files
            local has_local = vim.fn.filereadable(vim.fn.getcwd() .. '/.dprint.json') == 1
              or vim.fn.filereadable(vim.fn.getcwd() .. '/dprint.json') == 1

            if has_local then
              -- If local config exists, let dprint use it automatically
              return { 'fmt', '--stdin', '$FILENAME' }
            else
              -- Fall back to global config
              return { 'fmt', '--config', vim.fn.expand('~/.config/dprint.json'), '$FILENAME' }
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
    -- local opts = {
    --   default_format_opts = {
    --     timeout_ms = 3000,
    --     async = false, -- not recommended to change
    --     quiet = false, -- not recommended to change
    --     lsp_format = "fallback", -- not recommended to change
    --   },
    --   formatters_by_ft = {
    --     lua = { "stylua" },
    --     fish = { "fish_indent" },
    --     sh = { "shfmt" },
    --   },
    --   -- The options you set here will be merged with the builtin formatters.
    --   -- You can also define any custom formatters here.
    --   ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
    --   formatters = {
    --     injected = { options = { ignore_errors = true } },
    --     -- # Example of using dprint only when a dprint.json file is present
    --     -- dprint = {
    --     --   condition = function(ctx)
    --     --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
    --     --   end,
    --     -- },
    --     --
    --     -- # Example of using shfmt with extra args
    --     -- shfmt = {
    --     --   prepend_args = { "-i", "2", "-ci" },
    --     -- },
    --   },
    -- }
    return opts
  end,
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  ---

  -- init = function()
  --   -- If you want the formatexpr, here is the place to set it
  --   -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  -- end,
}
