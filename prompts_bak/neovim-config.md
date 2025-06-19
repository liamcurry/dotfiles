# Neovim Configuration

Set up Neovim with modern Lua configuration for better editing experience and
development tools.

## Key Takeaways

- **Lua over Vimscript**: Use `init.lua` for modern, fast configuration
- **Modular structure**: Split config into focused modules in `lua/` directory
- **LSP integration**: Built-in language server support for smart editing
- **Plugin management**: Use lazy.nvim for smart plugin loading
- **Safe configuration**: Handle errors gracefully with pcall()

## Concepts

### Configuration Files

Neovim reads configuration from:

- `~/.config/nvim/init.lua` (modern Lua config)
- `~/.config/nvim/init.vim` (legacy Vimscript config)

Use only one file type, not both. Lua is faster and more powerful.

### Directory Structure

Organize configuration into modules:

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── user/                  # Personal modules
│   │   ├── options.lua        # Editor settings
│   │   ├── keymaps.lua        # Key bindings
│   │   ├── plugins.lua        # Plugin definitions
│   │   └── lsp.lua           # Language server setup
│   └── config/
│       └── lazy.lua          # Plugin manager config
```

### Core Configuration Elements

**Options**: Set editor behavior with `vim.opt` **Keymaps**: Create shortcuts
with `vim.keymap.set()` **Plugins**: Add functionality with plugin manager
**LSP**: Language servers for smart editing **Autocommands**: Automatic actions
on events

### Plugin Management

Modern plugin managers:

- **lazy.nvim**: Smart, lazy loading
- **packer.nvim**: Alternative option

lazy.nvim loads plugins when needed. This makes startup faster.

### LSP (Language Server Protocol)

Built-in LSP provides:

- Smart autocomplete
- Go to definition
- Error highlighting
- Code formatting
- Refactoring tools

Two setup options:

1. **nvim-lspconfig**: Simplified setup
2. **Manual setup**: More control

## Rules

1. **Use init.lua, not init.vim**: Lua is faster and more flexible
2. **Organize with modules**: Split large configs into focused files
3. **Use vim.opt for settings**: Modern Lua API over vim.cmd()
4. **Handle errors with pcall()**: Prevent crashes from missing plugins
5. **Configure LSP early**: Set up language servers first
6. **Use lazy loading**: Load plugins only when needed
7. **Set leader key first**: Define before creating mappings
8. **Create backup strategy**: Test changes safely
9. **Use consistent naming**: Follow lua module conventions
10. **Document complex configs**: Add comments for custom functions

## Examples

### Example 1: Basic init.lua Setup

**GOOD**:

```lua
-- ~/.config/nvim/init.lua
-- Load user modules
require('user.options')
require('user.keymaps')
require('user.plugins')
```

**BAD**:

```lua
-- ~/.config/nvim/init.lua
-- Everything in one file
vim.opt.number = true
vim.opt.mouse = 'a'
-- ... 500 more lines
```

### Example 2: Options Configuration

**GOOD**:

```lua
-- ~/.config/nvim/lua/user/options.lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
```

**BAD**:

```lua
-- ~/.config/nvim/lua/user/options.lua
vim.cmd('set number')
vim.cmd('set relativenumber')
vim.cmd('set mouse=a')
-- Using old Vimscript syntax
```

### Example 3: Keymap Configuration

**GOOD**:

```lua
-- ~/.config/nvim/lua/user/keymaps.lua
vim.g.mapleader = ' '

-- File operations
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save file'})
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', {desc = 'Quit'})

-- Buffer navigation
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', {desc = 'Previous buffer'})
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', {desc = 'Next buffer'})
```

**BAD**:

```lua
-- ~/.config/nvim/lua/user/keymaps.lua
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>')
-- No descriptions, harder to debug
```

### Example 4: Plugin Setup with lazy.nvim

**GOOD**:

```lua
-- ~/.config/nvim/lua/user/plugins.lua
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'folke/tokyonight.nvim',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end,
  },
})
```

**BAD**:

```lua
-- ~/.config/nvim/lua/user/plugins.lua
-- No lazy loading, no error handling
require('lualine').setup()
require('tokyonight').setup()
-- Plugins may not be installed
```

### Example 5: LSP Configuration

**GOOD**:

```lua
-- ~/.config/nvim/lua/user/lsp.lua
local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
  return
end

-- Setup language servers
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
    },
  },
})

lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
```

**BAD**:

```lua
-- ~/.config/nvim/lua/user/lsp.lua
local lspconfig = require('lspconfig')
-- No error handling if lspconfig not installed

lspconfig.lua_ls.setup({})
-- No custom settings for Lua
```

### Example 6: Error Handling

**GOOD**:

```lua
-- ~/.config/nvim/init.lua
local ok, user_config = pcall(require, 'user.options')
if not ok then
  vim.notify('Failed to load user config: ' .. user_config, vim.log.levels.ERROR)
  return
end
```

**BAD**:

```lua
-- ~/.config/nvim/init.lua
require('user.options')
-- Crashes if module doesn't exist
```

### Example 7: Autocommands

**GOOD**:

```lua
-- ~/.config/nvim/lua/user/autocmds.lua
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.lua',
  callback = function()
    vim.lsp.buf.format()
  end,
  desc = 'Format Lua files on save',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'python', 'javascript'},
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
  desc = 'Set tab width for Python and JavaScript',
})
```

**BAD**:

```lua
-- ~/.config/nvim/lua/user/autocmds.lua
vim.cmd('autocmd BufWritePre *.lua lua vim.lsp.buf.format()')
vim.cmd('autocmd FileType python,javascript setlocal tabstop=4 shiftwidth=4')
-- Using old Vimscript syntax
```

## Resources

- [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html) - Official
  documentation
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP
  configurations
- [Build Your First Lua Config](https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/) -
  Step-by-step guide
- [Mason.nvim](https://github.com/williamboman/mason.nvim) - Language server
  installer

## Checklist

- [ ] Use init.lua instead of init.vim
- [ ] Organize config into modules in lua/ directory
- [ ] Set leader key before creating mappings
- [ ] Use vim.opt for settings, not vim.cmd()
- [ ] Handle module loading with pcall()
- [ ] Configure LSP for your languages
- [ ] Use lazy loading for plugins
- [ ] Add descriptions to keymaps
- [ ] Test config changes incrementally
- [ ] Create backup before major changes
- [ ] Use consistent module naming
- [ ] Document complex configurations

