# Bash Scripting

Safe, reliable shell scripting for AI agents and human developers.

## Key Takeaways

- Always use `set -euo pipefail` for safety and error detection
- Quote all variables as `"${var}"` to prevent word splitting and globbing
- Use ShellCheck for static analysis and validation of all scripts
- Prefer built-in commands over external programs for better performance
- Validate all input data and handle errors explicitly
- Write POSIX-compliant code when portability is required
- Test scripts with modern frameworks like ShellSpec or BATS

## Concepts

### Safety-First Philosophy

Bash keeps running after errors by default. This breaks scripts silently. Use
these settings to catch problems early:

- `set -e`: Stop script if any command fails
- `set -u`: Stop script if using undefined variables
- `set -o pipefail`: Stop script if any part of a pipe fails
- `set -x`: Show each command before running (for debugging)

### Variable Handling

Bash variables split on spaces and expand wildcards unless quoted. Quote
everything to prevent bugs:

- Always quote variables: `"${var}"` not `$var`
- Set defaults safely: `"${var:-default}"`
- Check if set: `[[ -n "${var:-}" ]]`
- Use `local` in functions to avoid conflicts

### Error Handling

Bash ignores errors by default. Check every important command:

- Check return codes: `if ! command; then handle_error; fi`
- Clean up on exit: `trap cleanup_function EXIT`
- Log errors to stderr: `echo "Error: message" >&2`
- Give useful error messages with context

### Security Practices

Shell scripts run commands. Bad input can run bad commands:

- Check all input before using it
- Never use `eval` with user data
- Clean file paths and arguments
- Set strict permissions: `chmod 0700 script.sh`
- Store secrets in environment variables, not scripts

### Performance Optimization

Shell scripts are slow because each external command creates a new process:

- Use built-in commands: `[[` instead of `test`, parameter expansion instead of
  `sed`
- Avoid subshells: `var=$(<file)` instead of `var=$(cat file)`
- Batch operations: process multiple files in one command
- Use arrays to store data instead of files
- Measure with `time` before optimizing

### Testing and Validation

Test scripts to catch bugs before production:

- Run `shellcheck script.sh` to find common problems
- Write tests with BATS:
  `@test "function works" { run myfunction; [ "$status" -eq 0 ] }`
- Test on different systems if portability matters
- Mock external commands for reliable tests
- Add scripts to CI/CD pipelines

### Portability Considerations

Make scripts work on different Unix systems:

- Use `#!/bin/sh` and avoid bash features for maximum portability
- Avoid: arrays, `[[`, `$BASHPID`, process substitution
- Test with dash: `dash script.sh`
- Use short flags: `-f` not `--file`
- Handle OS differences in commands

## Rules

1. **Start every script with**: `#!/bin/bash` and `set -euo pipefail`
2. **Quote all variables**: Use `"${var}"` format always
3. **Run ShellCheck**: Execute `shellcheck script.sh` before deploying
4. **Check command results**: Use `if ! command; then` pattern
5. **Validate all input**: Check data before processing
6. **Use local in functions**: Declare with `local var="value"`
7. **Add error cleanup**: Use `trap cleanup_function EXIT`
8. **Write unit tests**: Use BATS or ShellSpec for testing
9. **Comment complex code**: Explain why, not what
10. **Keep scripts under 100 lines**: Split large scripts into functions
11. **Use built-in commands**: Avoid `cat`, `grep` when possible
12. **Store secrets externally**: Use environment variables or files
13. **Set script permissions**: Run `chmod 0700 script.sh`
14. **Profile with time**: Run `time ./script.sh` to measure
15. **Test on target systems**: Verify scripts work where deployed

## Examples

### Good: Safe Script Structure

```bash
#!/bin/bash
set -euo pipefail

# Global variables
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="${SCRIPT_DIR}/script.log"

# Error handling
cleanup() {
    local exit_code=$?
    echo "Cleaning up..." >&2
    # Cleanup operations here
    exit "${exit_code}"
}
trap cleanup EXIT

# Function with proper error handling
process_file() {
    local file="${1}"
    
    if [[ ! -f "${file}" ]]; then
        echo "Error: File ${file} does not exist" >&2
        return 1
    fi
    
    echo "Processing ${file}..."
    # Process the file
}

# Main logic
main() {
    local input_file="${1:-}"
    
    if [[ -z "${input_file}" ]]; then
        echo "Usage: $0 <input_file>" >&2
        exit 1
    fi
    
    process_file "${input_file}"
}

main "$@"
```

### Bad: Unsafe Script Structure

```bash
#!/bin/bash
# No safety settings - dangerous!

# Unquoted variable - word splitting risk
file=$1
echo Processing $file

# No error checking - silent failures
cp $file /tmp/backup
rm $file

# No input validation - security risk
eval $user_input

# Global variables in functions
process_data() {
    result=$(complex_command)
    # No local variables or error handling
}
```

### Good: Variable Handling

```bash
#!/bin/bash
set -euo pipefail

# Proper variable declaration and usage
readonly CONFIG_FILE="/etc/myapp.conf"
readonly DEFAULT_TIMEOUT=30

# Safe parameter expansion
timeout="${TIMEOUT:-${DEFAULT_TIMEOUT}}"
user_home="${HOME:-/tmp}"

# Array usage (bash-specific)
declare -a files=("file1.txt" "file2.txt" "file3.txt")

# Safe iteration over array
for file in "${files[@]}"; do
    if [[ -f "${file}" ]]; then
        echo "Processing: ${file}"
    fi
done

# Conditional with proper quoting
if [[ -n "${user_home}" && -d "${user_home}" ]]; then
    echo "User home directory: ${user_home}"
fi
```

### Bad: Variable Handling

```bash
#!/bin/bash
# Dangerous variable usage

# Unquoted variables
files=*.txt
for file in $files; do
    echo Processing $file
    cp $file $backup_dir/$file
done

# Unset variable usage
if [ $undefined_var = "value" ]; then
    echo "This will fail"
fi

# Word splitting issues
path="/path with spaces/file.txt"
cat $path  # Will fail due to spaces
```

### Good: Error Handling

```bash
#!/bin/bash
set -euo pipefail

# Function with comprehensive error handling
backup_file() {
    local source="${1}"
    local dest="${2}"
    
    # Validate inputs
    if [[ ! -f "${source}" ]]; then
        echo "Error: Source file '${source}' not found" >&2
        return 1
    fi
    
    if [[ ! -d "$(dirname "${dest}")" ]]; then
        echo "Error: Destination directory doesn't exist" >&2
        return 1
    fi
    
    # Perform operation with error checking
    if ! cp "${source}" "${dest}"; then
        echo "Error: Failed to copy '${source}' to '${dest}'" >&2
        return 1
    fi
    
    echo "Successfully backed up '${source}' to '${dest}'"
    return 0
}

# Usage with error handling
if ! backup_file "/important/data.txt" "/backup/data.txt"; then
    echo "Backup failed, aborting" >&2
    exit 1
fi
```

### Bad: Error Handling

```bash
#!/bin/bash
# No error handling

backup_file() {
    # No input validation
    cp $1 $2
    # No error checking - silent failures possible
}

# No error checking in main code
backup_file "/important/data.txt" "/backup/data.txt"
rm "/important/data.txt"  # Could delete original even if backup failed!
```

### Good: API Integration with Error Handling

```bash
#!/bin/bash
set -euo pipefail

# API call with proper error handling
call_api() {
    local endpoint="${1}"
    local output_file="${2}"
    local max_retries=3
    local retry_count=0
    
    while [[ ${retry_count} -lt ${max_retries} ]]; do
        if curl -f -s -o "${output_file}" "${endpoint}"; then
            echo "API call successful"
            return 0
        else
            retry_count=$((retry_count + 1))
            echo "API call failed, retry ${retry_count}/${max_retries}" >&2
            sleep 2
        fi
    done
    
    echo "Error: API call failed after ${max_retries} retries" >&2
    return 1
}

# Usage with fallback
if ! call_api "https://api.example.com/data" "/tmp/api_data.json"; then
    echo "Using cached data instead" >&2
    cp "/var/cache/api_data.json" "/tmp/api_data.json"
fi
```

### Bad: API Integration

```bash
#!/bin/bash
# Fragile API integration

# No error handling, no retries
curl https://api.example.com/data > /tmp/api_data.json

# Processing continues even if API call failed
process_data /tmp/api_data.json
```

### Good: Log Processing with Built-ins

```bash
#!/bin/bash
set -euo pipefail

# Process logs using bash built-ins for performance
process_logs() {
    local log_file="${1}"
    local error_count=0
    local warning_count=0
    
    # Validate input
    if [[ ! -f "${log_file}" ]]; then
        echo "Error: Log file ${log_file} not found" >&2
        return 1
    fi
    
    # Process with built-in read for performance
    while IFS= read -r line; do
        # Use parameter expansion instead of external grep
        if [[ "${line}" == *"ERROR"* ]]; then
            error_count=$((error_count + 1))
        elif [[ "${line}" == *"WARNING"* ]]; then
            warning_count=$((warning_count + 1))
        fi
    done < "${log_file}"
    
    echo "Errors: ${error_count}, Warnings: ${warning_count}"
}

# Process multiple log files
for log in /var/log/app*.log; do
    [[ -f "${log}" ]] || continue
    echo "Processing: ${log}"
    process_logs "${log}"
done
```

### Bad: Log Processing

```bash
#!/bin/bash
# Inefficient external command usage

process_logs() {
    # Multiple external commands - slow and fragile
    error_count=$(grep -c "ERROR" $1)
    warning_count=$(grep -c "WARNING" $1)
    echo "Errors: $error_count, Warnings: $warning_count"
}

# No error checking
for log in /var/log/app*.log; do
    process_logs $log
done
```

## Resources

| Name                                                                                                                                               | Fetch When                              |
| -------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)                                                                    | When writing enterprise bash scripts    |
| [GNU Bash Manual](https://www.gnu.org/software/bash/manual/)                                                                                       | When needing official bash reference    |
| [ShellCheck](https://www.shellcheck.net/)                                                                                                          | When validating script quality          |
| [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)                                                                                    | When learning advanced bash techniques  |
| [POSIX Shell Standard](https://pubs.opengroup.org/onlinepubs/9699919799/)                                                                          | When writing portable scripts           |
| [ShellSpec Testing Framework](https://shellspec.info/)                                                                                             | When implementing BDD testing           |
| [BATS Testing Framework](https://github.com/bats-core/bats-core)                                                                                   | When writing simple unit tests          |
| [Apple Shell Script Security](https://developer.apple.com/library/archive/documentation/OpenSource/Conceptual/ShellScripting/ShellScriptSecurity/) | When securing shell scripts             |
| [Bash Performance Optimization](https://codearcana.com/posts/2013/08/06/bash-performance-tricks.html)                                              | When optimizing script performance      |
| [Writing Safe Shell Scripts](https://sipb.mit.edu/doc/safe-shell/)                                                                                 | When implementing defensive programming |

### Local Resources

| Name | Fetch When |
|------|------------|
| @claude-code.md | Using AI assistance for bash scripting |
| @simple-writing.md | Writing clear script documentation |
| @code-comments-technical-documentation.md | Documenting shell scripts and functions |

## Checklist

1. [ ] **Add script header** - Start with `#!/bin/bash` and `set -euo pipefail`
2. [ ] **Quote all variables** - Use `"${var}"` format consistently
3. [ ] **Run ShellCheck** - Execute `shellcheck script.sh` and fix all warnings
4. [ ] **Validate input** - Check all external data before processing
5. [ ] **Handle errors** - Check return codes and provide cleanup with trap
6. [ ] **Use local variables** - Declare function variables with `local`
7. [ ] **Add cleanup trap** - Use `trap cleanup_function EXIT`
8. [ ] **Secure credentials** - Store secrets in environment variables or config
       files
9. [ ] **Set permissions** - Run `chmod 0700` for sensitive scripts
10. [ ] **Use built-ins** - Prefer shell built-ins over external commands
11. [ ] **Write tests** - Create unit tests with BATS or ShellSpec
12. [ ] **Document complex code** - Add comments explaining why, not what
13. [ ] **Test on targets** - Verify scripts work on deployment systems
14. [ ] **Measure performance** - Use `time` command for scripts processing
        large data
15. [ ] **Check portability** - Test with dash if POSIX compliance required
