---
description:
globs: *.sh,*.bash
alwaysApply: false
---

# Google Shell Style Guide Rules

Write shell scripts following Google's engineering standards. These rules ensure
consistency, maintainability, and reliability across the codebase.

## Context & Application

### When to Use This Rule

- **Enterprise environments** requiring strict consistency
- **Team projects** with multiple contributors
- **Production systems** where reliability is critical
- **Code review processes** requiring standardized practices

### Relationship to Other Rules

- **Builds upon**: @bash.mdc for fundamental bash practices
- **Complements**: @git-commit-message.mdc for commit standards
- **Supersedes**: Basic shell practices with enterprise-grade requirements

## Meta-Framework: Structure-First Approach

### Script Classification Pattern

```text
TYPE := UTILITY | WRAPPER | AUTOMATION | DEPLOYMENT
SCOPE := SIMPLE (<100 lines) | COMPLEX (>100 lines, requires refactor)
LANGUAGE := BASH_ONLY | REWRITE_TO_STRUCTURED
```

### Decision Matrix

- **Simple + Utility** → Bash with these rules
- **Complex + Any** → Python/Go/Rust instead
- **Production + Any** → Follow all sections below

## Script Foundation

### Shell Selection & Headers

- **ALWAYS** use bash: `#!/bin/bash` and minimal flags
- Use `set` to configure shell options for script reliability
- **NEVER** strive for POSIX compatibility - embrace "bashisms"
- Bash is the only permitted shell scripting language for executables

### When to Use Shell

**Use shell ONLY for:**

- Small utilities and simple wrapper scripts
- Calling other utilities with minimal data manipulation
- Scripts under 100 lines

**DO NOT use shell for:**

- Performance-critical code
- Complex control flow logic
- Scripts over 100 lines (rewrite in structured language)
- Complex data manipulation

## File Structure & Naming

### File Extensions

- **Executables**: No extension preferred (unless build system requires `.sh`)
- **Libraries**: Must use `.sh` extension and should NOT be executable
- Choose consistently based on deployment method

### File Headers

**ALWAYS** start files with a description:

```bash
#!/bin/bash
#
# Perform hot backups of Oracle databases.
# Usage: backup_oracle.sh <database_name>
#
# Author: engineer@google.com
# Copyright 2024 Google Inc.
```

## Error Handling & Output

### STDOUT vs STDERR

- **ALL** error messages go to STDERR (`>&2`)
- Create error reporting function:

```bash
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

if ! do_something; then
  err "Unable to do_something"
  exit 1
fi
```

### Return Value Checking

**ALWAYS** check return values:

```bash
# Preferred method
if ! mv "${file_list[@]}" "${dest_dir}/"; then
  echo "Unable to move ${file_list[*]} to ${dest_dir}" >&2
  exit 1
fi

# Alternative method
mv "${file_list[@]}" "${dest_dir}/"
if (( $? != 0 )); then
  echo "Unable to move ${file_list[*]} to ${dest_dir}" >&2
  exit 1
fi
```

## Formatting Standards

### Indentation & Structure

- Use **2 spaces** for indentation (NO tabs)
- Maximum line length: **80 characters**
- Break long lines logically, indent continuation lines

### Pipelines

```bash
# Long pipelines - each pipe on new line with 2-space indent
command1 \
  | command2 \
  | command3 \
  | command4
```

### Control Flow

```bash
# if statements
if [[ "${condition}" ]]; then
  do_something
fi

# for loops  
for dir in "${dirs_to_cleanup[@]}"; do
  if [[ -d "${dir}/${ORACLE_SID}" ]]; then
    log_date "Cleaning up old files in ${dir}/${ORACLE_SID}"
    rm "${dir}/${ORACLE_SID}/"*
    if (( $? != 0 )); then
      error_message
    fi
  else
    mkdir -p "${dir}/${ORACLE_SID}"
    if (( $? != 0 )); then
      error_message
    fi
  fi
done
```

### Case Statements

```bash
case "${expression}" in
  a)
    variable="..."
    some_command "${variable}" "${other_expr}" ...
    ;;
  absolute)
    actions="relative"
    another_command "${actions}" "${other_expr}" ...
    ;;
  *)
    error "Unexpected expression '${expression}'"
    ;;
esac
```

### Variable Expansion & Quoting

- **ALWAYS** quote variables: `"${var}"`
- Use braces: `"${var}"` not `"$var"`
- Quote strings containing variables, command substitutions, spaces, or shell
  meta characters
- Use single quotes for literal strings

```bash
# Correct
echo "Substitution: ${var}"
echo "Literal: don't expand this"

# Avoid
echo "Substitution: $var"
echo Substitution: ${var}
```

## Language Features

### Command Substitution

- **ALWAYS** use `$()` instead of backticks

```bash
# Correct
var="$(command)"
var="$(command "$(command1)")"

# Incorrect
var=`command`
var="`command \`command1\``"
```

### Testing & Conditionals

- Use `[[ ... ]]` for tests, not `[ ... ]`
- Use `(( ... ))` for arithmetic tests

```bash
# String tests
if [[ "${my_var}" == "some_string" ]]; then
  do_something
fi

# Arithmetic tests  
if (( a < b )); then
  do_something
fi

# File tests
if [[ -f "${file}" ]]; then
  do_something
fi
```

### Arrays

- Use arrays for multiple values
- Properly quote array expansions

```bash
# Array declaration
declare -a files
files=("file1" "file2" "file3")

# Array usage
for file in "${files[@]}"; do
  do_something "${file}"
done

# Pass all elements
some_command "${files[@]}"
```

### Arithmetic

- Use `(( ... ))` for arithmetic operations
- Variables don't need `${}` inside `(( ... ))`

```bash
# Arithmetic assignment
(( i = 10 * j + 400 ))

# Arithmetic comparison
if (( a < b )); then
  do_something
fi

# Increment/decrement
(( i += 3 ))
(( i -= 5 ))
```

## Naming Conventions

### Function Names

- **Lowercase with underscores**: `my_func()`
- Use `::` for library separation: `mypackage::my_func()`
- Parentheses required after function name
- `function` keyword optional but use consistently

```bash
# Single function
my_func() {
  local name="$1"
  # function body
}

# Library function
mypackage::my_func() {
  # function body
}
```

### Variable Names

- **Lowercase with underscores** for local variables and functions
- Descriptive loop variable names

```bash
for zone in "${zones[@]}"; do
  something_with "${zone}"
done
```

### Constants & Environment Variables

- **UPPERCASE with underscores**
- Declare at top of file
- Use `readonly` or `export`

```bash
# Constant
readonly PATH_TO_FILES='/some/path'

# Exported constant
declare -xr ORACLE_SID='PROD'

# Or separately
readonly ZIP_VERSION="$(get_version)"
export ZIP_VERSION
```

### Source Filenames

- **Lowercase with underscores**: `maketemplate` or `make_template`
- **NOT** `make-template`

## Function Standards

### Local Variables

- **ALWAYS** use `local` for function variables
- Separate declaration from assignment when using command substitution

```bash
my_func() {
  local name="$1"
  
  # Separate declaration from assignment
  local my_var
  my_var="$(my_other_func)"
  (( $? == 0 )) || return
  
  # Use the variable
  do_something_with "${my_var}"
}
```

### Function Organization

- Put all functions together near top of file (after constants)
- Don't hide executable code between functions
- Use `main` function for scripts with multiple functions

```bash
#!/bin/bash
# File header...

# Constants
readonly CONSTANT_VAR="value"

# Functions
helper_func() {
  # helper code
}

main() {
  # main program logic
  helper_func
  return 0
}

# Entry point
main "$@"
```

## Command Execution

### Builtin vs External Commands

- **Prefer builtins** over external commands when possible
- Use parameter expansion instead of `sed` for simple substitutions
- Use `[[ =~ ]]` for regex matching

```bash
# Preferred - using builtins
addition="$(( X + Y ))"
substitution="${string/#foo/bar}"
if [[ "${string}" =~ foo:([0-9]+) ]]; then
  extraction="${BASH_REMATCH[1]}"
fi

# Avoid - external commands
addition="$(expr "${X}" + "${Y}")"
substitution="$(echo "${string}" | sed -e 's/^foo/bar/')"
```

## Code Quality

### ShellCheck Integration

- **ALWAYS** run `shellcheck` on all shell scripts
- Fix all shellcheck warnings before committing
- Use shellcheck directives only when necessary with explanations

### Comments

- Document function purpose, parameters, and return values
- Comment complex logic and regex patterns
- Use TODO comments with assigned owner and date

```bash
##
# Cleanup function called on script exit
# Globals:
#   CLEANUP_FILES - array of files to remove
# Arguments:
#   $1 - exit code (optional, defaults to 0)
# Returns:
#   None (exits script)
##
cleanup() {
  local exit_code="${1:-0}"
  
  # Remove temporary files
  if [[ -n "${CLEANUP_FILES:-}" ]]; then
    rm -f "${CLEANUP_FILES[@]}"
  fi
  
  exit "${exit_code}"
}
```

### Prohibited Practices

- **NEVER** use `eval` (security risk)
- **NEVER** use SUID/SGID on shell scripts
- Avoid aliases in scripts (use functions instead)
- Don't use `which` (use `command -v` instead)

## Consistency Rules

When multiple approaches are valid:

1. Choose the approach that's more explicit
2. Follow existing code patterns in the project
3. Prioritize readability over cleverness
4. Be consistent within the same script

## Enterprise Integration

### CI/CD Pipeline Integration

```bash
# Validation pipeline example
validate_shell_scripts() {
  find . -name "*.sh" -exec shellcheck {} \;
  find . -name "*.sh" -exec bash -n {} \;
}
```

### Team Collaboration

- Use this rule for code reviews
- Enforce via pre-commit hooks
- Document deviations with explicit rationale

**Remember**: These rules prioritize maintainability and consistency over
individual preferences. When in doubt, favor the approach that makes code easier
to read and understand for other Google engineers.

**Cross-references:**

- @bash.mdc for fundamental bash scripting practices
- @git-commit-message.mdc for version control standards
- @cursor-rules.mdc for rule authoring guidelines
