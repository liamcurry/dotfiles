# Bash Scripting

Write safe, reliable bash scripts using modern defensive programming techniques
and Google's shell style standards.

## Key Takeaways

- **Safety first**: Use `set -euo pipefail` to catch errors early
- **Quote everything**: `"${var}"` prevents word splitting and globbing issues
- **ShellCheck validates**: Code checking catches bugs before execution
- **Keep it simple**: Bash for small utilities only, <100 lines total
- **Local variables**: Use `local` in functions to prevent variable conflicts

## Concepts

### Safe Programming Foundation

Modern bash scripting focuses on fail-fast principles. Scripts should exit right
away when errors happen rather than continue with bad state. This prevents
silent failures that cause production problems.

**Strict mode options** create a safety net:

- `set -e`: Exit on first command failure
- `set -u`: Exit on undefined variable access
- `set -o pipefail`: Fail when any pipe command fails

**Variable quoting** prevents common bugs. Unquoted variables get split into
multiple words and match file patterns, causing unexpected behavior with
filenames containing spaces or special characters.

**Input checking** stops bad data from causing damage. Always check user input,
command-line arguments, and environment variables before using them.

### Google Style Guide Essentials

Google's shell style guide defines industry standards for readable, maintainable
scripts. Key principles include proper naming conventions, consistent
formatting, and clear documentation.

**Script scope limitation**: Shell scripts work best for small utilities and
wrapper scripts. Complex logic belongs in structured languages like Python or
Go.

**Naming conventions** improve clarity:

- Executables: `.sh` extension or no extension
- Functions and variables: lowercase with underscores
- Constants: uppercase with underscores

**Documentation requirements**: Every script needs a top-level comment
explaining its purpose and usage.

### ShellCheck Code Checking

ShellCheck acts like a spell-checker for shell scripts, finding bugs, style
issues, and bad patterns. It supports sh, bash, dash, and ksh variants.

**Common issues found**:

- Unquoted variables causing word splitting
- Undefined variables used
- Wrong command substitution syntax
- Logic errors in conditionals
- Slow performance patterns

**Use options** include command-line usage, web interface, and editor plugins
for real-time feedback.

### Error Handling Patterns

**Exit codes** communicate success or failure to calling processes. Use 0 for
success, non-zero values for different error types.

**Error redirection** sends messages to stderr instead of stdout, allowing
proper separation of output streams.

**Trap signals** enable cleanup on script end, preventing resource leaks or
incomplete operations.

**Function-based error handling** creates consistent error reporting across
scripts.

## Rules

1. **Start with strict mode**: `set -euo pipefail` at the top of every script
2. **Quote all variables**: Use `"${var}"` syntax, never bare `$var`
3. **Use local in functions**: Prevent variable scope pollution with
   `local var="value"`
4. **Check ShellCheck**: Run static analysis before deploying scripts
5. **Keep scripts under 100 lines**: Rewrite longer scripts in structured
   languages
6. **Use meaningful exit codes**: 0 for success, 1-255 for different error types
7. **Send errors to stderr**: Use `echo "Error" >&2` for error messages
8. **Validate all input**: Check arguments and user input before processing
9. **Use builtins when possible**: Prefer bash built-ins over external commands
   for performance
10. **Document script purpose**: Include top-level comment explaining what
    script does

## Examples

### Example 1: Script Header and Strict Mode

**GOOD**:

```bash
#!/bin/bash
# Backup user configuration files to dated archive
set -euo pipefail

readonly BACKUP_DIR="/var/backups"
readonly TIMESTAMP=$(date +%Y%m%d_%H%M%S)
```

**BAD**:

```bash
#!/bin/bash
# This is a backup script

BACKUP_DIR=/var/backups
TIMESTAMP=`date +%Y%m%d_%H%M%S`
```

### Example 2: Variable Quoting and Function Usage

**GOOD**:

```bash
backup_file() {
    local source_file="${1}"
    local dest_dir="${2}"
    
    if [[ ! -f "${source_file}" ]]; then
        echo "Error: Source file '${source_file}' not found" >&2
        return 1
    fi
    
    cp "${source_file}" "${dest_dir}/$(basename "${source_file}")"
}
```

**BAD**:

```bash
backup_file() {
    if [ ! -f $1 ]; then
        echo "Error: Source file $1 not found"
        return 1
    fi
    
    cp $1 $2/`basename $1`
}
```

### Example 3: Error Handling and Exit Codes

**GOOD**:

```bash
error_exit() {
    echo "Error: ${1}" >&2
    exit "${2:-1}"
}

create_backup_dir() {
    local backup_path="${1}"
    
    if ! mkdir -p "${backup_path}" 2>/dev/null; then
        error_exit "Cannot create backup directory: ${backup_path}" 2
    fi
}

main() {
    local backup_path="${BACKUP_DIR}/${TIMESTAMP}"
    
    create_backup_dir "${backup_path}"
    backup_file "${HOME}/.bashrc" "${backup_path}"
    echo "Backup completed successfully"
}

main "$@"
```

**BAD**:

```bash
mkdir -p $BACKUP_DIR/$TIMESTAMP
cp $HOME/.bashrc $BACKUP_DIR/$TIMESTAMP/
echo "Done"
```

### Example 4: Input Validation

**GOOD**:

```bash
validate_arguments() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: $0 <source_dir> <dest_dir>" >&2
        exit 1
    fi
    
    local source_dir="${1}"
    local dest_dir="${2}"
    
    if [[ ! -d "${source_dir}" ]]; then
        error_exit "Source directory does not exist: ${source_dir}" 2
    fi
    
    if [[ ! -w "${dest_dir}" ]]; then
        error_exit "Destination directory not writable: ${dest_dir}" 3
    fi
}

main() {
    validate_arguments "$@"
    # Continue with validated arguments
}
```

**BAD**:

```bash
cp -r $1/* $2/
```

### Example 5: ShellCheck Integration

**GOOD**:

```bash
# Run before deployment:
# shellcheck script.sh

# Disable specific warnings when justified:
# shellcheck disable=SC2034
readonly UNUSED_VAR="value"  # Used by sourced script

# Use arrays for multiple values:
declare -a FILES=("file1.txt" "file2.txt" "file3.txt")
for file in "${FILES[@]}"; do
    process_file "${file}"
done
```

**BAD**:

```bash
# No ShellCheck validation
FILES="file1.txt file2.txt file3.txt"
for file in $FILES; do
    process_file $file
done
```

## Resources

- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html) -
  Official style standards
- [ShellCheck](https://www.shellcheck.net/) - Static analysis tool and web
  interface
- [Bash Manual](https://www.gnu.org/software/bash/manual/bash.html) - Complete
  bash reference
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/) -
  Comprehensive bash tutorial
- [Defensive Bash Programming](https://web.archive.org/web/20180917174959/http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming/) -
  Safety-first techniques

## Checklist

- [ ] Script starts with `#!/bin/bash` and `set -euo pipefail`
- [ ] All variables are quoted: `"${var}"` not `$var`
- [ ] Functions use `local` for all variables
- [ ] Script is under 100 lines (or rewritten in another language)
- [ ] All user input is validated before use
- [ ] Error messages go to stderr using `>&2`
- [ ] Exit codes are meaningful (0=success, non-zero=error)
- [ ] ShellCheck validation passes with no warnings
- [ ] Script has top-level comment explaining purpose
- [ ] Functions have single responsibility
- [ ] External commands are checked for existence before use
- [ ] Cleanup traps are set for temporary files/resources
- [ ] Script works with filenames containing spaces and special characters
- [ ] No hardcoded paths (use variables or command-line arguments)
- [ ] Script can be run multiple times safely

