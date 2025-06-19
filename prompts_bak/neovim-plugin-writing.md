# Neovim Plugin Writing

Build fast, maintainable Neovim plugins using modern Lua patterns and automated
testing. Ship plugins that start fast, work reliably, and distribute properly
through LuaRocks.

## Key Takeaways

- **Lua over Vimscript**: Use Lua for all new plugins - it's up to 1000x faster
  than Vimscript
- **Smart initialization**: Auto-initialize without forcing users to call
  setup() functions
- **Lazy loading**: Implement plugin-level lazy loading, don't rely on plugin
  managers
- **LuaRocks distribution**: Publish to LuaRocks for proper dependency
  management
- **Type safety**: Use LuaCATS annotations with lua-language-server for early
  bug detection

## Concepts

### Plugin Architecture

Neovim plugins follow a specific directory structure that separates
initialization from implementation:

```
example.nvim/
├── lua/example/init.lua    # Core plugin logic, loaded on-demand
├── plugin/example.lua      # Auto-executed on Neovim startup
├── doc/example.txt         # Vimdoc documentation
└── spec/example_spec.lua   # Tests
```

The `plugin/` directory contains files executed when Neovim starts. The `lua/`
directory holds your actual plugin code, loaded only when required. This
separation enables intelligent lazy loading.

### Lua API Layers

Neovim provides three API layers:

1. **Vim API**: Legacy Vimscript functions accessible from Lua
2. **Nvim API**: Modern C-based API (vim.api.nvim_*)
3. **Lua API**: Lua-specific wrappers (vim.keymap, vim.autocmd)

Use the highest-level API available. Prefer `vim.keymap.set()` over
`vim.api.nvim_set_keymap()`.

### Modern Plugin Patterns

Modern plugins follow these patterns:

- **Module-based structure**: Use `local M = {}` and `return M`
- **Configuration separation**: Keep config separate from initialization
- **Error handling**: Use result-or-message pattern `any|nil,nil|string`
- **User commands**: Provide scoped commands with subcommands, not individual
  commands

### Testing Approaches

Two main testing strategies exist:

1. **plenary.nvim**: Convenient but limited, mocked busted interface, runs tests
   in Neovim instances
2. **busted + luarocks**: Complete testing framework with better CI integration,
   requires rockspec setup

Choose plenary for simple plugins, busted for complex ones with dependencies.
Always run tests in CI/CD pipeline.

## Rules

### Structure and Organization

1. **Use proper directory structure**: Place core logic in
   `lua/pluginname/init.lua`, auto-execution code in `plugin/pluginname.lua`
2. **Target Lua 5.1**: This is Neovim's permanent Lua interface
3. **Implement module pattern**: Always use `local M = {}` and `return M` for
   modules
4. **Separate concerns**: Keep configuration, initialization, and core logic in
   different modules

### Initialization and Performance

5. **Auto-initialize smartly**: Don't force users to call setup() functions
6. **Minimize startup impact**: Defer `require()` calls until actually needed
7. **Use filetype-specific loading**: Load functionality only for relevant file
   types using `ftplugin/` directory
8. **Implement lazy loading**: Move expensive operations inside command
   implementations, not in plugin/ files

### User Interface Design

9. **Provide <Plug> mappings**: Don't create automatic keymaps, let users choose
10. **Use scoped commands**: Create one command with subcommands, not multiple
    commands
11. **Implement command completion**: Add tab completion for subcommands and
    arguments
12. **Follow result-or-message pattern**: Return `nil` for expected failures
    with optional error message

### Code Quality

13. **Use LuaCATS annotations**: Enable type checking with lua-language-server
    in development
14. **Handle errors gracefully**: Don't crash on expected failures, return nil
    with error message
15. **Version check compatibility**: Verify minimum Neovim version with
    `vim.version.cmp()`
16. **Follow naming conventions**: Use snake_case for functions, PascalCase for
    user commands

### Testing and Documentation

17. **Write tests first**: Use either plenary or busted for comprehensive
    testing
18. **Create vimdoc**: Users should access help with `:h pluginname`
19. **Document all configuration**: Include examples for every option
20. **Add usage examples**: Show both good and bad usage patterns

### Distribution

21. **Publish to LuaRocks**: Use automated GitHub Actions workflow with
    luarocks-tag-release
22. **Use semantic versioning**: Follow semver for releases (MAJOR.MINOR.PATCH)
23. **Automate releases**: Set up CI/CD pipeline that tests before publishing
24. **Manage dependencies**: Specify all dependencies in rockspec file with
    version constraints

## Examples

### Good vs Bad Plugin Structure

**Bad - Monolithic structure:**

```lua
-- plugin/myplugin.lua
local function complex_logic()
  -- 200 lines of code here
end

vim.api.nvim_create_user_command('MyPlugin', complex_logic, {})
```

**Good - Modular structure:**

```lua
-- plugin/myplugin.lua
vim.api.nvim_create_user_command('MyPlugin', function()
  require('myplugin').run()
end, {})

-- lua/myplugin/init.lua
local M = {}
function M.run()
  -- Loaded only when actually used
end
return M
```

### Good vs Bad User Commands

**Bad - Multiple commands:**

```lua
vim.api.nvim_create_user_command('MyPluginUpdate', update_func, {})
vim.api.nvim_create_user_command('MyPluginInstall', install_func, {})
vim.api.nvim_create_user_command('MyPluginDelete', delete_func, {})
```

**Good - Scoped command with subcommands:**

```lua
local commands = {
  update = { impl = update_func },
  install = { impl = install_func },
  delete = { impl = delete_func }
}

vim.api.nvim_create_user_command('MyPlugin', function(opts)
  local cmd = commands[opts.fargs[1]]
  if cmd then cmd.impl() end
end, {
  nargs = 1,
  complete = function() return vim.tbl_keys(commands) end
})
```

### Good vs Bad Initialization

**Bad - Forced setup:**

```lua
-- Breaks if user forgets to call setup
local config = nil

local function setup(opts)
  config = opts
end

local function run()
  if not config then error("Call setup() first!") end
  -- ... rest of function
end
```

**Good - Smart initialization:**

```lua
local config = { default_option = true }

local function setup(opts)
  config = vim.tbl_extend('force', config, opts or {})
end

local function run()
  -- Works with or without setup() call
  -- ... function logic using config
end
```

### Good vs Bad Error Handling

**Bad - Throwing errors for normal failures:**

```lua
local function find_file(name)
  local file = io.open(name, 'r')
  if not file then
    error("File not found: " .. name)
  end
  return file
end
```

**Good - Result-or-message pattern:**

```lua
local function find_file(name)
  local file = io.open(name, 'r')
  if not file then
    return nil, "File not found: " .. name
  end
  return file
end
```

### Good vs Bad Plugin Testing

**Bad - No tests or minimal coverage:**

```lua
-- No test files, or:
-- spec/plugin_spec.lua
describe('plugin', function()
  it('works', function()
    assert.truthy(true)
  end)
end)
```

**Good - Comprehensive test coverage:**

```lua
-- spec/plugin_spec.lua
describe('MyPlugin', function()
  before_each(function()
    -- Reset state
  end)
  
  it('handles valid input', function()
    local result = require('myplugin').process('valid_input')
    assert.equals('expected_output', result)
  end)
  
  it('handles invalid input gracefully', function()
    local result, err = require('myplugin').process('')
    assert.is_nil(result)
    assert.matches('Invalid input', err)
  end)
end)
```

## Resources

1. [nvim-best-practices](https://github.com/nvim-neorocks/nvim-best-practices) -
   Community best practices guide
2. [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html) - Official Lua
   development guide
3. [luarocks-tag-release](https://github.com/nvim-neorocks/luarocks-tag-release) -
   Automated LuaRocks publishing
4. [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Popular testing
   framework for plugins
5. [Test with busted](https://mrcjkb.dev/posts/2023-06-06-luarocks-test.html) -
   Advanced testing setup guide

## Checklist

### Project Setup

- [ ] Create proper directory structure (`lua/`, `plugin/`, `spec/`, `doc/`)
- [ ] Initialize git repository with good .gitignore
- [ ] Set up GitHub repository for distribution
- [ ] Create rockspec file for LuaRocks publishing

### Code Quality

- [ ] Use LuaCATS annotations for type safety
- [ ] Implement module pattern with `local M = {}`
- [ ] Add version compatibility checks
- [ ] Use result-or-message error handling pattern

### User Experience

- [ ] Provide <Plug> mappings instead of automatic keymaps
- [ ] Create scoped commands with subcommands
- [ ] Implement smart auto-initialization
- [ ] Add command completion functions

### Performance

- [ ] Defer `require()` calls until needed (move inside functions)
- [ ] Use filetype-specific loading when appropriate (`ftplugin/` directory)
- [ ] Minimize startup time impact (measure with `--startuptime`)
- [ ] Profile plugin loading time with `:profile` command

### Testing

- [ ] Choose testing framework (plenary vs busted)
- [ ] Write unit tests for all public functions
- [ ] Set up CI/CD pipeline for automated testing
- [ ] Test with multiple Neovim versions

### Documentation

- [ ] Create comprehensive vimdoc (`:h pluginname`)
- [ ] Document all configuration options with examples
- [ ] Add README with installation and usage instructions
- [ ] Include LuaRocks badge in README

### Distribution

- [ ] Set up automated LuaRocks publishing
- [ ] Use semantic versioning for releases
- [ ] Create GitHub Actions workflow
- [ ] Test installation from LuaRocks

