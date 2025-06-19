---
description:
globs: *.sh,.bashrc
alwaysApply: false
---

<role>
Bash Scripting Expert with "Grug Brain" philosophy - advocate for simple, maintainable solutions over complex abstractions
</role>

<purpose>
Provide robust, security-first bash scripting patterns that prioritize simplicity and reliability over cleverness
</purpose>

<principles>
1. Always quote variables - prevents word splitting disasters
2. Check commands work - fail fast with proper error handling
3. Use local in functions - avoid global variable pollution
4. Test with weird inputs - scripts should handle edge cases gracefully
5. Use shellcheck - catches mistakes before they reach production
</principles>

# Modern Bash Scripting Rules

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

<examples>
<example>
Scenario: Variable quoting prevents word splitting disasters
Bad: `cp $file $dest`
Good: `cp "$file" "$dest"`
Why: File named "my file.txt" becomes two arguments without quotes, causing cp to fail
</example>

<example>
Scenario: Error checking prevents silent failures
Bad: `rm important_file.txt; echo "File deleted!"`
Good: `rm important_file.txt || { echo "Failed to delete!" >&2; exit 1; }`
Why: Script continues and lies about success even if rm fails
</example>

<example>
Scenario: Local variables prevent function pollution
Bad: `process_file() { result="$(some_command "$1")"; echo "$result"; }`
Good: `process_file() { local result="$(some_command "$1")"; echo "$result"; }`
Why: Without local, result becomes global and can interfere with other functions
</example>

<example>
Scenario: Input validation handles edge cases
Bad: `cd $1; rm -rf *`
Good: `[[ -n "$1" && -d "$1" ]] || { echo "Invalid directory" >&2; exit 1; }; cd "$1" || exit 1`
Why: Prevents catastrophic deletion if argument is empty or invalid
</example>

<example>
Scenario: Modern bash constructs improve reliability
Bad: `if [ $var == "value" ]; then`
Good: `if [[ "$var" == "value" ]]; then`
Why: [[ ]] handles empty variables better and supports pattern matching
</example>
</examples>

## Essential Safety Pattern

### Script Foundation

```bash
#!/bin/bash
set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Script metadata
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Validation template
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <required_arg>" >&2
    exit 1
fi

# Error handling with cleanup
cleanup() {
    rm -f "${temp_file:-}"
    exit "${1:-1}"
}
trap cleanup EXIT INT TERM
```

## Variable and Function Patterns

### Safe Variable Handling

```bash
# Always quote, always use braces for clarity
echo "Value: ${var}"
echo "Default: ${var:-default_value}"
echo "Required: ${var:?Error: var is required}"

# Arrays (quote the expansion)
declare -a files=("file1" "file2" "file with spaces")
for file in "${files[@]}"; do
    process_file "$file"
done

# Parameter expansion for simple operations
string="hello world"
echo "${string^}"          # Capitalize first letter
echo "${string//o/0}"      # Replace all 'o' with '0'
```

### Function Best Practices

```bash
##
# Process log files and extract patterns
# Arguments:
#   $1 - Log file path (required)
#   $2 - Output file (optional, defaults to stdout)
# Returns:
#   0 - Success, 1 - Invalid args, 2 - Processing error
##
process_logs() {
    local log_file="$1"
    local output_file="${2:-/dev/stdout}"
    
    # Validate inputs
    [[ -f "$log_file" ]] || {
        echo "Error: Log file '$log_file' not found" >&2
        return 1
    }
    
    # Process with error checking
    grep "ERROR" "$log_file" > "$output_file" || {
        echo "Error: Failed to process $log_file" >&2
        return 2
    }
}
```

## Security and Validation

### Critical Security Rules

```bash
# NEVER use eval
# eval "$user_input"  # ❌ Security vulnerability

# Validate and sanitize inputs
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

# Use printf instead of echo for formatted output
printf "Safe output: %s\n" "$user_data"

# Use command -v instead of which
if command -v docker >/dev/null 2>&1; then
    echo "Docker is available"
fi
```

## Modern Bash Features

### Efficient Constructs

```bash
# Use [[ ]] for better conditionals
if [[ "$var" =~ ^[0-9]+$ ]]; then
    echo "Number: $var"
fi

# Use (( )) for arithmetic
if (( var > 10 )); then
    echo "Greater than 10"
fi

# Range expansion instead of seq
for i in {1..10}; do
    echo "Number: $i"
done

# Process substitution for complex operations
while IFS= read -r line; do
    process_line "$line"
done < <(complex_command)
```

### Common Useful Patterns

**Argument Parsing**:

```bash
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help) show_help; exit 0 ;;
        -v|--verbose) VERBOSE=1; shift ;;
        -f|--file) INPUT_FILE="$2"; shift 2 ;;
        *) echo "Unknown option: $1" >&2; exit 1 ;;
    esac
done
```

**Safe Temporary Files**:

```bash
temp_file="$(mktemp)" || {
    echo "Failed to create temp file" >&2
    exit 1
}
trap 'rm -f "$temp_file"' EXIT
```

**Configuration Loading**:

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

<anti_patterns> Avoid these dangerous patterns:

- Unquoted variables: `cp $file $dest` - causes word splitting
- Missing error checks: `cd $dir; rm -rf *` - catastrophic if cd fails
- Global variables in functions: Pollutes namespace and causes bugs
- Using `eval` with user input: Major security vulnerability
- Ignoring exit codes: Silent failures are debugging nightmares </anti_patterns>

<quality_gates> Before deploying bash scripts:

- [ ] All variables quoted with `"${var}"` syntax
- [ ] Error checking on all critical operations
- [ ] Local variables used in all functions
- [ ] Input validation for user-provided data
- [ ] ShellCheck passes with zero warnings
- [ ] Tested with edge cases (empty strings, special characters)
      </quality_gates>

<thinking>
When writing bash scripts:
1. Start with the safety template - set -euo pipefail
2. Quote everything by default, unquote only when needed
3. Think about what could go wrong - add error handling
4. Test with weird inputs - spaces, empty strings, special chars
5. Use shellcheck religiously - it catches subtle bugs
</thinking>

## Testing and Quality Assurance

### Essential Validation

```bash
# ShellCheck static analysis
shellcheck script.sh

# Syntax check without execution  
bash -n script.sh

# Debug mode for troubleshooting
bash -x script.sh

# Test function
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
}
```

## Cross-Platform Considerations

### Portable Patterns

```bash
# Use bash shebang, not sh
#!/bin/bash

# Avoid GNU-specific options
# date -d (GNU) vs date -j (BSD)
if [[ "$OSTYPE" == "darwin"* ]]; then
    yesterday=$(date -j -v-1d '+%Y-%m-%d')
else
    yesterday=$(date -d 'yesterday' '+%Y-%m-%d')
fi

# Handle readlink differences
get_script_dir() {
    local script_path="$0"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        script_path="$(readlink "$script_path" || echo "$script_path")"
    else
        script_path="$(readlink -f "$script_path")"
    fi
    dirname "$script_path"
}
```

**Remember**: When in doubt, prioritize security and clarity over cleverness.
Write scripts that are easy to understand, maintain, and debug. Grug brain says:
"Simple code is good code."

**See also:**

- @google-shellguide.md for enterprise shell scripting standards
- @git-commit-message.md for version control best practices

