# Google Shell Style Guide

Write production-quality shell scripts following Google's engineering standards
for readability, maintainability, and reliability.

## KEY TAKEAWAYS

- **Bash as standard**: Use `#!/bin/bash` for all scripts requiring more than
  POSIX features
- **Defensive programming**: Start scripts with `set -euo pipefail` for safety
- **Consistent formatting**: 2-space indentation, 80-character lines,
  standardized control flow
- **Variable safety**: Always quote variables as `"${var}"` unless you need word
  splitting
- **Error handling first**: Check return values, validate inputs, handle
  failures gracefully
- **Prefer built-ins**: Use Bash built-ins over external commands for
  performance and reliability
- **Simple over clever**: If a script exceeds 100 lines, consider a structured
  language

## CONCEPTS

### Shell Script Philosophy

Shell scripts excel at gluing together system utilities and automating
command-line tasks. Google's approach emphasizes predictability over cleverness,
treating shell scripts as production code that requires the same rigor as any
other language. Scripts should be simple, well-documented, and fail safely.

### Bash vs POSIX Shell

While POSIX shell ensures maximum portability, Google standardizes on Bash for
its enhanced features like arrays, `[[` tests, and better string handling. This
trade-off provides consistency across Google's infrastructure while leveraging
Bash's safety features. Always declare Bash explicitly with `#!/bin/bash`.

### Error Handling Strategy

Production shell scripts must handle errors gracefully. The foundation is
`set -euo pipefail`: exit on error (`-e`), treat unset variables as errors
(`-u`), and propagate pipe failures (`-o pipefail`). Combined with trap handlers
and explicit error checking, this creates robust scripts that fail fast and
provide clear diagnostics.

### Code Organization

Well-structured shell scripts follow a consistent pattern: shebang, description,
strict mode settings, global variables, functions, and a main function. This
organization makes scripts predictable and testable. Functions should be small,
focused, and use local variables to avoid side effects.

## RULES

### File Structure and Headers

1. **Use .sh extension**: All shell scripts use `.sh` suffix for clarity
2. **Start with shebang**: Always `#!/bin/bash` on the first line
3. **Include file description**: Comment block explaining the script's purpose
4. **Set strict mode early**: `set -euo pipefail` immediately after headers
5. **Declare globals together**: Group all global variables near the top

### Formatting and Style

6. **Indent with 2 spaces**: Never use tabs, always 2-space indentation
7. **Limit line length**: Maximum 80 characters per line for readability
8. **Use consistent control flow**: Place `; then` and `; do` on same line as
   `if`/`while`
9. **Align case patterns**: Indent case alternatives by 2 spaces, commands by 4
10. **Group related code**: Use blank lines to separate logical sections

### Variables and Naming

11. **Quote all variables**: Use `"${var}"` unless word splitting is required
12. **Use lowercase for locals**: Local variables and functions use `snake_case`
13. **Use uppercase for globals**: Constants and environment variables use
    `UPPER_CASE`
14. **Declare locals explicitly**: Always use `local` for function variables
15. **Prefer ${var} syntax**: Use braces even when not required for consistency

### Command Substitution and Tests

16. **Use
    $() over backticks**: Modern syntax `$(command)`` instead of `` ``command`
    ``
17. **Prefer [[ over [**: Use `[[ ]]` for all tests, never `[ ]`
18. **Check command success**: Always verify critical commands with `if` or `||`
19. **Use arithmetic (( ))**: For numeric operations, use `(( ))` not `[[ ]]`
20. **Avoid eval**: Never use eval; find safer alternatives

### Functions and Main

21. **Define functions early**: Place all functions before main logic
22. **Use function keyword**: Declare as `function name() { }` for clarity
23. **Return meaningful values**: Functions return 0 for success, non-zero for
    failure
24. **Create main function**: Scripts over 20 lines should have `main "$@"`
25. **Handle arguments properly**: Validate and document all script parameters

## EXAMPLES

### Script Structure Template

**GOOD**:

```bash
#!/bin/bash
#
# backup_configs.sh: Safely backup configuration files
#
# Usage: backup_configs.sh [-v] [-d backup_dir] config_file...

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BACKUP_DIR="${BACKUP_DIR:-/var/backups}"
VERBOSE=0

function usage() {
  cat >&2 <<EOF
Usage: ${0##*/} [-v] [-d backup_dir] config_file...
  -v  Enable verbose output
  -d  Backup directory (default: ${BACKUP_DIR})
EOF
}

function backup_file() {
  local file="$1"
  local backup_path="${BACKUP_DIR}/$(basename "${file}").$(date +%Y%m%d_%H%M%S)"
  
  if [[ ! -f "${file}" ]]; then
    echo "Error: ${file} not found" >&2
    return 1
  fi
  
  cp -p "${file}" "${backup_path}" || return 1
  [[ "${VERBOSE}" -eq 1 ]] && echo "Backed up: ${file} -> ${backup_path}"
  return 0
}

function main() {
  local opt
  while getopts "vd:h" opt; do
    case "${opt}" in
      v) VERBOSE=1 ;;
      d) BACKUP_DIR="${OPTARG}" ;;
      h) usage; exit 0 ;;
      *) usage; exit 1 ;;
    esac
  done
  shift $((OPTIND - 1))
  
  if [[ $# -eq 0 ]]; then
    usage
    exit 1
  fi
  
  local exit_code=0
  for file in "$@"; do
    backup_file "${file}" || exit_code=$?
  done
  
  return "${exit_code}"
}

main "$@"
```

_Why: Complete structure with error handling, proper quoting, meaningful
functions, and clear organization_

**BAD**:

```bash
#!/bin/sh

for file in $*; do
  cp $file /backup/`basename $file`.`date +%Y%m%d`
done
```

_Why: No error handling, unquoted variables, backticks, no validation, uses sh
instead of bash_

### Variable Quoting and Expansion

**GOOD**:

```bash
readonly CONFIG_FILE="${HOME}/.myapp/config"
readonly BACKUP_PATH="${BACKUP_DIR}/${filename}.bak"

# Word splitting needed for options
readonly RM_OPTIONS="-f -r"
# shellcheck disable=SC2086
rm ${RM_OPTIONS} "${temp_dir}"

# Array for safety
declare -a files=("${HOME}"/Documents/*.txt)
for file in "${files[@]}"; do
  process_file "${file}"
done
```

_Why: Proper quoting prevents word splitting bugs, explicit when splitting is
needed, arrays for file lists_

**BAD**:

```bash
CONFIG_FILE=$HOME/.myapp/config
BACKUP_PATH=$BACKUP_DIR/$filename.bak

rm -rf $temp_dir

for file in $HOME/Documents/*.txt; do
  process_file $file
done
```

_Why: Unquoted variables can break with spaces, glob expansion happens at wrong
time_

### Error Handling Patterns

**GOOD**:

```bash
function download_file() {
  local url="$1"
  local dest="$2"
  
  if ! curl -fsSL "${url}" -o "${dest}"; then
    echo "Error: Failed to download ${url}" >&2
    return 1
  fi
  
  if [[ ! -s "${dest}" ]]; then
    echo "Error: Downloaded file is empty" >&2
    rm -f "${dest}"
    return 1
  fi
  
  return 0
}

# Cleanup on exit
temp_dir="$(mktemp -d)"
trap 'rm -rf "${temp_dir}"' EXIT

# Handle errors with context
if ! download_file "${URL}" "${temp_dir}/data.json"; then
  echo "Fatal: Cannot proceed without data file" >&2
  exit 1
fi
```

_Why: Explicit error checking, informative messages to stderr, cleanup
guarantees, meaningful exit codes_

**BAD**:

```bash
function download_file() {
  curl $1 > $2
}

temp_dir=/tmp/myapp.$$
mkdir $temp_dir

download_file $URL $temp_dir/data.json
# Continues even if download failed
```

_Why: No error checking, predictable temp directory, no cleanup, silent
failures_

### Function Design

**GOOD**:

```bash
function validate_email() {
  local email="$1"
  local regex='^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  
  if [[ -z "${email}" ]]; then
    return 1
  fi
  
  [[ "${email}" =~ ${regex} ]]
}

function process_user() {
  local username="$1"
  local email="$2"
  local status=0
  
  if ! validate_email "${email}"; then
    echo "Error: Invalid email for user ${username}" >&2
    return 1
  fi
  
  # Process user...
  return 0
}
```

_Why: Single responsibility, local variables, meaningful returns, input
validation_

**BAD**:

```bash
validate_email() {
  email=$1
  echo $email | grep -q '@'
}

process_user() {
  username=$1
  email=$2
  
  validate_email $email
  # Always continues regardless of validation
  
  # Process user...
}
```

_Why: Global variable pollution, poor validation, ignored return values, no
error messages_

## CHECKLIST

### Script Setup

1. [ ] **Add shebang line** - Start with `#!/bin/bash` for Bash scripts
2. [ ] **Include description** - Add comment block explaining script purpose and
       usage
3. [ ] **Set strict mode** - Add `set -euo pipefail` after headers
4. [ ] **Define script directory** - Use
       `SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"`

### Code Organization

5. [ ] **Group global variables** - Declare all globals together near the top
6. [ ] **Use readonly for constants** - Mark unchanging variables with
       `readonly`
7. [ ] **Define functions before use** - Place all function definitions before
       main logic
8. [ ] **Create main function** - Use `main "$@"` pattern for scripts over 20
       lines

### Safety and Reliability

9. [ ] **Quote all variables** - Use `"${var}"` unless word splitting is
       explicitly needed
10. [ ] **Check command returns** - Verify critical commands with `if` or `||`
11. [ ] **Validate inputs** - Check arguments and user input before use
12. [ ] **Handle temp files safely** - Use `mktemp` and trap cleanup

### Style Compliance

13. [ ] **Format with 2 spaces** - Ensure consistent 2-space indentation
        throughout
14. [ ] **Limit line length** - Keep lines under 80 characters
15. [ ] **Use modern syntax** - Prefer `$()` over backticks, `[[ ]]` over `[ ]`
16. [ ] **Run shellcheck** - Validate script with `shellcheck -x script.sh`

