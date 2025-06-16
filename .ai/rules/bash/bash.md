---
description:
globs: *.sh,.bashrc
alwaysApply: false
---

# Modern Bash Scripting Rules

When writing bash scripts, follow these modern practices for robustness,
security, and maintainability.

## Grug-Approved Quick Start

> "grug want script that work, not break"

### Copy-Paste Template (Grug Tested)

```bash
#!/bin/bash
set -euo pipefail

# What this script does
# Usage: ./script.sh <required_thing>

main() {
    local thing="${1:-}"
    
    if [[ -z "$thing" ]]; then
        echo "Usage: $0 <thing>" >&2
        exit 1
    fi
    
    echo "Processing: $thing"
    # Your code here
    
    echo "Done!"
}

main "$@"
```

### Five Rules Grug Never Forget

1. **Always quote variables**: `"$var"` (prevents word splitting)
2. **Check commands work**: `cmd || exit 1` (fail fast)
3. **Use `local` in functions**: `local var="$1"` (no global mess)
4. **Test your script**: Run with weird filenames containing spaces
5. **Use shellcheck**: `shellcheck script.sh` (catches grug mistakes)

### Common Grug Mistakes (And Fixes)

```bash
# BAD - grug forget quotes
cp $file $dest

# GOOD - grug remember quotes  
cp "$file" "$dest"

# BAD - grug no check if command work
rm important_file.txt
echo "File deleted!"

# GOOD - grug check command
rm important_file.txt || {
    echo "Failed to delete file!" >&2
    exit 1
}

# BAD - grug use global variable in function
process_file() {
    result="$(some_command "$1")"
    echo "$result"
}

# GOOD - grug use local variable
process_file() {
    local result="$(some_command "$1")"
    echo "$result"
}
```

---

## When to Apply

Use this rule when:

- Creating or modifying shell scripts (`.sh`, `.bash` files)
- Working with system automation scripts
- Building deployment or CI/CD pipeline scripts
- Writing utility or wrapper scripts

**Cross-reference with**: @google-shellguide.mdc for enterprise-grade standards,
@git-commit-message.mdc for version control practices.

## Quick Start Essentials

### Mandatory Script Header

```bash
#!/bin/bash
set -euo pipefail

# Brief description of what this script does
# Usage: script_name.sh [options] arguments
```

### Core Safety Pattern

```bash
# Validation template
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <required_arg>" >&2
    exit 1
fi

# Error handling template
command_that_might_fail || {
    echo "Error: operation failed" >&2
    exit 1
}
```

## Script Structure & Safety

### Essential Safety Settings

- **ALWAYS** start scripts with: `#!/bin/bash`
- **ALWAYS** use strict mode: `set -euo pipefail`
  - `-e`: Exit on any command failure
  - `-u`: Exit on undefined variables
  - `-o pipefail`: Exit on pipe failures
- Add `set -x` for debugging when needed

### Script Template

```bash
#!/bin/bash
set -euo pipefail

# Script description and usage
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Global constants
readonly DEFAULT_TIMEOUT=30
readonly LOG_FILE="/tmp/${SCRIPT_NAME}.log"

# Functions here
main() {
    # Main logic here
    return 0
}

# Entry point
main "$@"
```

## Error Handling & Validation

### Robust Error Handling

- Check return values of all commands
- Use `|| { echo "Error message" >&2; exit 1; }` for critical commands
- Implement cleanup functions with `trap`
- Validate all inputs and arguments

### Example Error Handling

```bash
cleanup() {
    rm -f "${temp_file:-}"
    exit "${1:-1}"
}
trap cleanup EXIT INT TERM

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <required_arg>" >&2
    exit 1
fi

temp_file="$(mktemp)" || {
    echo "Failed to create temp file" >&2
    exit 1
}
```

## Variable and Function Best Practices

### Variable Handling

- Use `local` for all function variables
- Always quote variables: `"${var}"` not `$var`
- Use `readonly` for constants
- Declare arrays properly: `declare -a array_name=()`
- Use parameter expansion for defaults: `${var:-default}`

### Function Guidelines

- Keep functions small and focused (≤ 20 lines)
- Use descriptive names with underscores: `check_dependencies`
- Return meaningful exit codes (0 for success, 1-255 for errors)
- Document function parameters and return values

## Security Best Practices

### Critical Security Rules

- **NEVER** use `eval` - find alternatives
- **NEVER** use `source` on untrusted files
- Validate and sanitize all user inputs
- Use `printf` instead of `echo` for formatted output
- Avoid `which` command, use `command -v` instead
- Set restrictive permissions: `umask 077`

### Input Validation Example

```bash
validate_input() {
    local input="$1"
    
    # Check for dangerous characters
    if [[ "$input" =~ [;&|>] ]]; then
        echo "Input contains dangerous characters" >&2
        return 1
    fi
    
    # Length check
    if [[ ${#input} -gt 255 ]]; then
        echo "Input too long" >&2
        return 1
    fi
    
    return 0
}
```

## Modern Bash Features

### Use Modern Constructs

- Prefer `[[ ]]` over `[ ]` for conditionals
- Use `$(command)` instead of backticks
- Use `{1..10}` for ranges instead of `seq`
- Use associative arrays: `declare -A assoc_array`
- Use `mapfile` or `readarray` for reading files into arrays

### String Operations

```bash
# Modern string handling
string="hello world"
echo "${string^}"        # Capitalize first letter
echo "${string^^}"       # Uppercase all
echo "${string//o/0}"    # Replace all 'o' with '0'
echo "${string: -5}"     # Last 5 characters
```

## Documentation & Comments

### Documentation Standards

- Include header comment with purpose, usage, and author
- Comment complex logic and regex patterns
- Use `#` for comments, `##` for section headers
- Document all function parameters and return values

### Example Documentation

```bash
##
# Process log files and extract error patterns
# Arguments:
#   $1 - Log file path (required)
#   $2 - Output file path (optional, defaults to stdout)
# Returns:
#   0 - Success
#   1 - Invalid arguments
#   2 - File processing error
##
process_logs() {
    local log_file="$1"
    local output_file="${2:-/dev/stdout}"
    # Implementation here
}
```

## Testing & Validation

### Testing Guidelines

- Use `shellcheck` for static analysis
- Test with different inputs and edge cases
- Use `bash -n script.sh` to check syntax
- Test error conditions and cleanup
- Use temporary directories for testing: `mktemp -d`

### Example Test Function

```bash
run_tests() {
    local test_dir
    test_dir="$(mktemp -d)"
    
    # Test normal case
    if ! process_logs "test.log" "${test_dir}/output"; then
        echo "Test failed: normal case" >&2
        rm -rf "$test_dir"
        return 1
    fi
    
    # Test error case
    if process_logs "nonexistent.log" "${test_dir}/output" 2>/dev/null; then
        echo "Test failed: should have failed" >&2
        rm -rf "$test_dir"
        return 1
    fi
    
    rm -rf "$test_dir"
    echo "All tests passed"
    return 0
}
```

## Advanced Patterns

### Performance & Efficiency

- Avoid unnecessary subshells
- Use built-in commands over external tools when possible
- Process large files with `while read` loops
- Use arrays for collecting data instead of string concatenation
- Minimize I/O operations in loops

### Cross-Platform Considerations

- Use `/bin/bash` not `/bin/sh` for bash-specific features
- Avoid GNU-specific options (use portable alternatives)
- Test on different systems when possible
- Use `date` carefully (formats vary between systems)
- Use `readlink -f` alternatives for macOS compatibility

### Common Patterns

#### Argument Parsing

```bash
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=1
            shift
            ;;
        -f|--file)
            INPUT_FILE="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1" >&2
            exit 1
            ;;
    esac
done
```

#### Configuration File Handling

```bash
load_config() {
    local config_file="${1:-${HOME}/.config/myapp/config}"
    
    if [[ -f "$config_file" ]]; then
        # Source config safely
        source "$config_file" || {
            echo "Failed to load config: $config_file" >&2
            return 1
        }
    fi
}
```

## Quality Assurance

### Validation Commands

- `shellcheck script.sh` - Static analysis
- `bash -n script.sh` - Syntax check
- `bash -x script.sh` - Debug mode

### Common Pitfalls

- **Unquoted variables**: Always use `"${var}"` not `$var`
- **Missing error handling**: Check return values of all commands
- **Unsafe temp files**: Use `mktemp` and cleanup with `trap`
- **Path assumptions**: Use absolute paths or validate relative ones

Remember: When in doubt, prioritize security and clarity over cleverness. Write
scripts that are easy to understand, maintain, and debug.

**See also:**

- @google-shellguide.mdc for enterprise shell scripting standards
- @git-commit-message.mdc for version control best practices
