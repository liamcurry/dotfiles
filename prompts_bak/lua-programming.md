# Lua Programming

A guide for writing efficient, readable Lua code following established patterns
and performance best practices.

## Key Takeaways

- **Tables are everything** - Lua's only data structure handles arrays, objects,
  and modules
- **Local variables are fast** - Store in registers, avoid global variable hash
  lookups
- **Simple beats complex** - Lua's strength is simplicity and embeddability
- **Performance through profiling** - Measure before optimizing, use LuaJIT for
  speed
- **Explicit error handling** - Return nil + error message pattern over
  exceptions

## Concepts

### Core Language Design

Lua has 8 basic types: nil, boolean, number, string, function, userdata, thread,
and table. Tables serve as the universal data structure, functioning as arrays
with numeric indices and hash tables with string keys. This unified approach
keeps the language small yet powerful.

Functions are first-class values with closure support. Variables are dynamically
typed with garbage collection. The design prioritizes simplicity and
embeddability over complex features.

### Module System

Lua modules return a table of functions and values. The `require()` function
loads modules and caches results. Local functions provide private implementation
while the returned table exposes the public API.

```lua
-- Module structure
local M = {}

local function private_helper()
    -- Internal implementation
end

function M.public_function()
    return private_helper()
end

return M
```

### Table Semantics

Tables have array and hash parts internally. Numeric indices from 1 to n
(consecutive integers) use the fast array part. Other keys use the slower hash
part. This distinction directly impacts performance.

### Error Handling Philosophy

Lua prefers explicit error handling over exceptions. Functions should return nil
as the first value and an error message as the second value when errors occur.
This pattern makes errors visible and hard to ignore.

## Rules

### Variable Declaration

- Always use `local` for new variables
- Declare variables in smallest possible scope
- Cache frequently accessed global values in locals
- Use descriptive names for variables with larger scope
- Prefix boolean variables and predicates with `is_`

### Function Definition

- Use `local function name()` for private functions
- Place all `require()` calls at the top of files
- Sort require statements alphabetically
- Document function signatures with parameter types
- Return nil + error message for error conditions

### Table Usage

- Use `ipairs()` for array iteration, `pairs()` for hash tables
- Pre-allocate tables when size is known
- Prefer `t[#t+1] = value` over `table.insert(t, value)` for performance
- Cache `#table` in locals if used repeatedly in loops
- Reuse tables instead of creating new ones in loops
- Keep tables small for faster lookups

### Performance Optimization

- Profile before optimizing - measure actual bottlenecks
- Move expensive operations outside of loops
- Use table lookups instead of multiple conditionals
- Cache method lookups: `local insert = table.insert`
- Avoid string concatenation in loops - use `table.concat()`

### Code Organization

- Name files in lowercase
- Place source files in `src/` directory
- Place tests in `spec/` directory
- Use 2-4 spaces for indentation (be consistent)
- Prefer double quotes for strings

### Resource Management

- Add explicit `close()` methods for resources
- Do not rely on `__gc` metamethod for cleanup
- Clean up file handles, network connections explicitly
- Use to-be-closed variables in Lua 5.4+ when available

## Examples

### Good vs Bad Variable Usage

**Bad - Global variables:**

```lua
counter = 0
function increment()
    counter = counter + 1  -- Slow global lookup
    return counter
end
```

**Good - Local variables:**

```lua
local counter = 0
local function increment()
    counter = counter + 1  -- Fast register access
    return counter
end
```

### Good vs Bad Table Iteration

**Bad - Wrong iterator:**

```lua
local items = {"a", "b", "c"}
for k, v in pairs(items) do  -- Slower for arrays
    print(k, v)
end
```

**Good - Correct iterator:**

```lua
local items = {"a", "b", "c"}
for i, v in ipairs(items) do  -- Faster for arrays
    print(i, v)
end
```

### Good vs Bad Error Handling

**Bad - No error information:**

```lua
function divide(a, b)
    if b == 0 then
        return nil  -- What went wrong?
    end
    return a / b
end
```

**Good - Explicit error message:**

```lua
function divide(a, b)
    if b == 0 then
        return nil, "division by zero"
    end
    return a / b
end
```

### Good vs Bad Module Structure

**Bad - Global pollution:**

```lua
-- mymodule.lua
function helper()  -- Global function
    return "help"
end

function public_api()
    return helper()
end
```

**Good - Proper encapsulation:**

```lua
-- mymodule.lua
local M = {}

local function helper()  -- Private function
    return "help"
end

function M.public_api()  -- Public function
    return helper()
end

return M
```

### Good vs Bad Performance Patterns

**Bad - Inefficient string building:**

```lua
local result = ""
for i = 1, 1000 do
    result = result .. tostring(i) .. " "  -- Creates many strings
end
```

**Good - Efficient string building:**

```lua
local parts = {}
for i = 1, 1000 do
    parts[#parts + 1] = tostring(i)
end
local result = table.concat(parts, " ")  -- Single concatenation
```

### Good vs Bad Loop Optimization

**Bad - Repeated expensive lookups:**

```lua
for i = 1, #items do
    table.insert(results, string.upper(items[i]))  -- Function lookup each time
end
```

**Good - Cached function references:**

```lua
local insert = table.insert
local upper = string.upper
for i = 1, #items do
    insert(results, upper(items[i]))  -- Fast local access
end
```

## Resources

- [Lua Official Documentation](https://www.lua.org/docs.html) - Reference
  manuals and language specification
- [Programming in Lua](https://www.lua.org/pil/) - Comprehensive book by
  language creator
- [LuaRocks Style Guide](https://github.com/luarocks/lua-style-guide) -
  Production coding conventions
- [lua-users Optimization Tips](http://lua-users.org/wiki/OptimisationTips) -
  Community performance wisdom
- [LuaJIT](https://luajit.org/) - High-performance JIT compiler for Lua

## Checklist

- [ ] **Variables declared local** - No accidental globals
- [ ] **Appropriate iterators used** - ipairs for arrays, pairs for hashes
- [ ] **Error handling implemented** - Functions return nil + error message
- [ ] **Tables pre-allocated** - Known sizes allocated upfront
- [ ] **Expensive operations cached** - Table lookups, function references
      stored in locals
- [ ] **Resources explicitly managed** - Files, connections closed manually
- [ ] **Module structure clean** - Private functions local, public API in
      returned table
- [ ] **Performance measured** - Profiling done before optimization
- [ ] **Code style consistent** - Indentation, naming, formatting standardized
- [ ] **Dependencies explicit** - All require() calls at file top, sorted
      alphabetically

