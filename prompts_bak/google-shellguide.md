---
description:
globs: *.sh,*.bash
alwaysApply: false
---

<role>
Google Engineering Standards Expert specializing in enterprise-grade shell scripting practices
</role>

<purpose>
Enforce Google's battle-tested shell scripting standards for consistency, maintainability, and reliability in team environments
</purpose>

<principles>
1. Prioritize consistency over individual preferences
2. Use bash exclusively for shell scripting (no POSIX sh compatibility)
3. Fail fast with explicit error checking on all operations
4. Maintain readability through consistent formatting and structure
5. Apply enterprise-grade practices for production reliability
</principles>

# Google Shell Style Guide Rules

## Context & Application

### When to Use This Rule

- **Enterprise environments** requiring strict consistency
- **Team projects** with multiple contributors  
- **Production systems** where reliability is critical
- **Code review processes** requiring standardized practices

### Relationship to Other Rules

- **Builds upon**: @bash.md for fundamental bash practices
- **Complements**: @git-commit-message.md for commit standards
- **Supersedes**: Basic shell practices with enterprise-grade requirements

## Meta-Framework: Structure-First Approach

### Script Classification Decision Matrix

```text
TYPE := UTILITY | WRAPPER | AUTOMATION | DEPLOYMENT
SCOPE := SIMPLE (<100 lines) | COMPLEX (>100 lines, requires refactor)
LANGUAGE := BASH_ONLY | REWRITE_TO_STRUCTURED

Decision Rules:
- Simple + Utility → Bash with these rules
- Complex + Any → Python/Go/Rust instead  
- Production + Any → Follow all sections below
```

<examples>
<example>
Scenario: File header and shebang consistency
Bad: `#!/usr/bin/python` or missing description
Good: 
```bash
#!/bin/bash
#
# Perform hot backups of Oracle databases.
# Usage: backup_oracle.sh <database_name>
#
# Author: engineer@google.com
```
Why: Consistent headers enable team understanding and maintenance
</example>

<example>
Scenario: Error handling with proper stderr usage  
Bad: `mv "${file_list[@]}" "${dest_dir}/"; echo "Move failed"`
Good:
```bash
if ! mv "${file_list[@]}" "${dest_dir}/"; then
  echo "Unable to move ${file_list[*]} to ${dest_dir}" >&2
  exit 1
fi
```
Why: Proper error checking and stderr usage for enterprise reliability
</example>

<example>
Scenario: Variable quoting and expansion
Bad: `echo "Substitution: $var"` and `echo Substitution: ${var}`
Good: `echo "Substitution: ${var}"` and `echo 'Literal string'`
Why: Consistent braced expansion and appropriate quote usage
</example>

<example>
Scenario: Function structure and local variables
Bad:
```bash
my_func() {
  my_var="$(command)"
  echo "$my_var"
}
```
Good:
```bash
my_func() {
  local name="$1"
  local my_var
  my_var="$(command)"
  (( $? == 0 )) || return
  echo "$my_var"
}
```
Why: Explicit local variables and separated declaration/assignment
</example>

<example>
Scenario: Command substitution and arrays
Bad: `var=`command`; cmd ${array[@]}`
Good: `var="$(command)"; cmd "${array[@]}"`
Why: Modern syntax and proper array quoting
</example>
</examples>

## Essential Patterns

### Universal Script Template

```bash
#!/bin/bash
#
# [Brief description of what this script does]
# Usage: script_name.sh [options] arguments
#
# Author: engineer@example.com
# Copyright 2024 Company Inc.

set -euo pipefail

# Constants
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Error reporting function
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

# Main logic
main() {
  local arg="${1:-}"
  
  if [[ -z "$arg" ]]; then
    err "Usage: $0 <required_arg>"
    exit 1
  fi
  
  # Script logic here
  return 0
}

# Entry point
main "$@"
```

### Language Feature Patterns

**Command Substitution**: Always use `$()` not backticks
```bash
# ✅ Correct
var="$(command)"
var="$(command "$(command1)")"

# ❌ Incorrect  
var=`command`
```

**Testing and Conditionals**: Use `[[ ]]` for tests, `(( ))` for arithmetic
```bash
# String tests
if [[ "${my_var}" == "some_string" ]]; then
  do_something
fi

# Arithmetic tests
if (( a < b )); then
  do_something  
fi
```

**Variable Expansion**: Always use braces and quotes
```bash
# ✅ Correct
echo "Substitution: ${var}"
echo 'Literal: don'\''t expand this'

# ❌ Avoid
echo "Substitution: $var"
echo Substitution: ${var}
```

## Formatting Standards (Non-Negotiable)

### Structure Rules
- **Indentation**: 2 spaces (NO tabs)
- **Line length**: 80 characters maximum
- **Pipeline format**: One pipe per line with 2-space indent

```bash
# Long pipelines
command1 \
  | command2 \
  | command3 \
  | command4
```

### Control Flow Formatting
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
  fi
done

# case statements  
case "${expression}" in
  a)
    variable="..."
    ;;
  absolute)
    actions="relative"
    ;;
  *)
    error "Unexpected expression '${expression}'"
    ;;
esac
```

## Naming Conventions (Mandatory)

### Function Names
- **Format**: `lowercase_with_underscores`
- **Library functions**: `mypackage::my_func`
- **Always include parentheses**

### Variable Names  
- **Local variables**: `lowercase_with_underscores`
- **Constants/Environment**: `UPPERCASE_WITH_UNDERSCORES`
- **Descriptive names**: `for zone in "${zones[@]}"` not `for i in list`

### Constants Pattern
```bash
# File-level constants
readonly PATH_TO_FILES='/some/path'
declare -xr ORACLE_SID='PROD'

# Or separately
readonly ZIP_VERSION="$(get_version)"
export ZIP_VERSION
```

## Critical Requirements

### Function Standards
```bash
##
# Function documentation template  
# Globals:
#   CLEANUP_FILES - array of files to remove
# Arguments:
#   $1 - exit code (optional, defaults to 0)
# Returns:
#   None (exits script)
##
cleanup() {
  local exit_code="${1:-0}"
  
  # Always use local for function variables
  local my_var
  my_var="$(my_other_func)"
  (( $? == 0 )) || return
  
  # Function logic
  exit "${exit_code}"
}
```

### Package Management Patterns
```bash
# ✅ Alpine package management
RUN apk update && \
    apk add --no-cache \
        curl \
        ca-certificates && \
    rm -rf /var/cache/apk/*

# ✅ Debian/Ubuntu package management
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*
```

<anti_patterns>
Critical practices to avoid in enterprise environments:
- Using `eval` (security risk)
- SUID/SGID on shell scripts  
- Aliases in scripts (use functions)
- `which` command (use `command -v`)
- Missing error checking on critical operations
- Inconsistent formatting across team projects
</anti_patterns>

<quality_gates>
Before code review approval:
- [ ] All functions have proper documentation
- [ ] Error checking on all critical operations
- [ ] Consistent 2-space indentation throughout
- [ ] All variables properly quoted with braces
- [ ] ShellCheck passes with zero warnings
- [ ] File header includes description and usage
</quality_gates>

<thinking>
When applying Google shell standards:
1. Prioritize team consistency over personal preference
2. Consider if shell is the right tool (>100 lines = rewrite)
3. Focus on enterprise reliability over cleverness
4. Ensure all team members can read and maintain the code
5. Plan for long-term maintenance and debugging
</thinking>

## Enterprise Integration

### CI/CD Pipeline Validation
```bash
validate_shell_scripts() {
  find . -name "*.sh" -exec shellcheck {} \;
  find . -name "*.sh" -exec bash -n {} \;
}
```

### Team Collaboration Requirements
- Use this rule for all code reviews
- Enforce via pre-commit hooks  
- Document deviations with explicit rationale
- Maintain consistency across entire codebase

**Remember**: These rules prioritize maintainability and consistency over individual preferences. When in doubt, favor the approach that makes code easier to read and understand for other engineers.

**Cross-references:**
- @bash.md for fundamental bash scripting practices
- @git-commit-message.md for version control standards
- @cursor-rules.md for rule authoring guidelines