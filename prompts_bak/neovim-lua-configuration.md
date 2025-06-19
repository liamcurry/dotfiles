# Neovim Lua Configuration

Complete guide for building fast, maintainable Neovim configurations with Lua.
Covers lazy loading, plugin management, and performance optimization for
AI-assisted development workflows.

## Key Takeaways

- **Use lazy loading**: Load plugins and modules only when needed to keep
  startup fast
- **Separate concerns**: Split configuration into focused modules rather than
  one large file
- **Handle errors safely**: Use pcall() for require() calls to prevent config
  breakage
- **Follow vim.api patterns**: Use vim.opt, vim.wo, vim.bo for different setting
  scopes
- **Optimize for performance**: Profile startup time and defer non-essential
  loading

## Concepts

### Configuration Architecture

Neovim supports either `init.vim` (Vimscript) or `init.lua` (Lua) as the main
config file, but not both. The Lua approach provides better performance, type
safety, and modern language features.

The standard structure places the main `init.lua` file in your config directory
(`~/.config/nvim/` on Unix systems) with additional Lua modules in the `lua/`
subdirectory. This allows using `require()` to load modules on demand.

### API Scopes and Access Patterns

Neovim's Lua API provides different scopes for settings:

- `vim.opt`: General editor settings (equivalent to `:set`)
- `vim.wo`: Window-scoped options
- `vim.bo`: Buffer-scoped options
- `vim.g`: Global variables
- `vim.api`: Core Neovim API functions

The `vim` module is automatically loaded, so `require("vim")` is unnecessary.

### Plugin Management Systems

Modern Neovim uses lazy-loading plugin managers like lazy.nvim. These load
plugins only when needed, improving startup speed. The core principle is "load
on demand" - load autocompletion when editing starts, load language plugins for
specific file types only.

### Performance Considerations

Startup time directly affects productivity. Key optimization strategies include:

- Lazy loading plugins and modules
- Using LuaJIT instead of standard Lua
- Deferring syntax highlighting and filetype detection
- Caching compiled Lua modules
- Profiling with `--startuptime` flag

### Error Handling and Safety

Lua's `require()` function crashes if modules don't exist, breaking your entire
config. Using `pcall()` (protected call) prevents this by returning success
status and results, letting you handle missing modules gracefully.

## Rules

### Configuration Structure Rules

1. **Use init.lua only**: Never mix init.vim and init.lua in the same config
2. **Split by function**: Create separate modules for keymaps, options, plugins,
   LSP
3. **Use lua/ directory**: Place modules in lua/ directory for require() loading
4. **Handle require() safely**: Wrap require() calls in pcall() for optional
   modules
5. **Keep init.lua simple**: Use it only to require other modules, not for
   config details

### Plugin Management Rules

6. **Default to lazy loading**: Set lazy = true unless plugin must load at
   startup
7. **Use priority for critical plugins**: Set priority for essential non-lazy
   plugins
8. **Group related plugins**: Organize plugins by functionality (UI, LSP, git,
   etc.)
9. **Implement setup() methods**: Follow plugin convention with module.setup()
   pattern
10. **Version pin important plugins**: Lock critical plugins to specific
    versions

### Performance Rules

11. **Profile startup often**: Use nvim --startuptime startup.log to measure
    impact
12. **Defer heavy work**: Move expensive setup to after-startup events
13. **Use event loading**: Load plugins on specific events (BufRead,
    InsertEnter)
14. **Cache modules**: Use tools like impatient.nvim for module caching
15. **Avoid eager requires**: Only require() modules when actually needed

### API Usage Rules

16. **Use appropriate scopes**: Choose vim.opt, vim.wo, or vim.bo based on
    setting type
17. **Prefer vim.keymap.set**: Use modern keymap API instead of
    vim.api.nvim_set_keymap
18. **Handle nil values**: Check for nil before using values in configuration
    logic
19. **Use vim.schedule**: Defer operations that need to run after current event
20. **Follow naming conventions**: Use snake_case for Lua functions, PascalCase
    for plugins

## Examples

### Good vs Bad Configuration Structure

**Bad: Single large init.lua file**

```lua
-- init.lua (400+ lines)
vim.opt.number = true
vim.opt.relativenumber = true
-- ... 50 more options
require('packer').startup(function()
  use 'nvim-tree/nvim-tree.lua'
  -- ... 30 more plugins
end)
-- ... 200 lines of plugin configs
-- ... 100 lines of keymaps
```

**Good: Modular structure**

```lua
-- init.lua (clean entry point)  
require('config.options')
require('config.keymaps') 
require('config.plugins')
require('config.lsp')

-- lua/config/options.lua
local opt = vim.opt
opt.number = true
opt.relativenumber = true
```

### Good vs Bad Plugin Loading

**Bad: Eager loading everything**

```lua
require('lazy').setup({
  'nvim-tree/nvim-tree.lua',  -- loads at startup
  'lewis6991/gitsigns.nvim',  -- loads at startup  
  'hrsh7th/nvim-cmp',        -- loads at startup
})
```

**Good: Lazy loading by event**

```lua
require('lazy').setup({
  {
    'nvim-tree/nvim-tree.lua',
    cmd = 'NvimTreeToggle',  -- load on command
  },
  {
    'lewis6991/gitsigns.nvim', 
    event = 'BufRead',       -- load when reading files
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',   -- load when entering insert mode
  },
})
```

### Good vs Bad Error Handling

**Bad: Unsafe requires that break config**

```lua
local cmp = require('cmp')  -- errors if not installed
cmp.setup({
  -- configuration here
})
```

**Good: Safe requires with fallback**

```lua
local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  vim.notify('nvim-cmp not found', vim.log.levels.WARN)
  return
end

cmp.setup({
  -- configuration here  
})
```

### Good vs Bad API Usage

**Bad: Wrong scope and old API**

```lua
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>find<cr>', {})
vim.o.number = true  -- wrong scope for local setting
```

**Good: Correct scope and modern API**

```lua
vim.keymap.set('n', '<leader>f', '<cmd>find<cr>', { desc = 'Find files' })
vim.opt.number = true  -- correct scope
```

## Resources

1. **Official Neovim Lua Guide**: https://neovim.io/doc/user/lua-guide.html
2. **Neovim Best Practices**:
   https://github.com/nvim-neorocks/nvim-best-practices
3. **Lua Guide for Neovim**: https://github.com/nanotee/nvim-lua-guide
4. **Configuring Neovim with Lua**:
   https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
5. **Lazy.nvim Plugin Manager**: https://github.com/folke/lazy.nvim

## Checklist

### Initial Setup

- [ ] Choose init.lua over init.vim for new configurations
- [ ] Create lua/ directory structure for modules
- [ ] Set up plugin manager (lazy.nvim recommended)
- [ ] Profile baseline startup time with --startuptime

### Configuration Organization

- [ ] Split config into logical modules (options, keymaps, plugins, lsp)
- [ ] Use require() to load modules from init.lua
- [ ] Implement error handling with pcall() for optional modules
- [ ] Follow consistent naming conventions

### Plugin Management

- [ ] Default plugins to lazy loading (lazy = true)
- [ ] Use event-based loading (BufRead, InsertEnter, etc.)
- [ ] Set priority for essential non-lazy plugins
- [ ] Group plugins by functionality
- [ ] Pin versions for critical plugins

### Performance Optimization

- [ ] Measure startup time regularly
- [ ] Use lazy loading for non-essential plugins
- [ ] Defer heavy operations to after-startup events
- [ ] Consider module caching tools
- [ ] Profile and optimize bottlenecks

### API Usage

- [ ] Use vim.opt for general settings
- [ ] Use vim.wo for window-specific options
- [ ] Use vim.bo for buffer-specific options
- [ ] Use vim.keymap.set for key mappings
- [ ] Handle nil values safely in config logic

### Code Quality

- [ ] Use local variables in modules
- [ ] Implement .setup() methods for plugin configs
- [ ] Add type annotations where helpful
- [ ] Test configuration changes incrementally
- [ ] Document complex configuration decisions

