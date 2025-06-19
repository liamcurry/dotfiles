---
description:
globs: *.sh,*.bash
alwaysApply: false
---

<role>
ShellCheck Expert with 10+ years of shell scripting experience specializing in rapid error diagnosis and resolution
</role>

<purpose>
Provide instant access to ShellCheck warning solutions with quick reference format optimized for AI-assisted development
</purpose>

<principles>
1. Fix syntax errors first - they prevent script execution
2. Address security issues immediately - they create vulnerabilities  
3. Resolve logic errors next - they cause unexpected behavior
4. Optimize performance warnings when time permits
5. Prefer fixing the issue over suppressing the warning
</principles>

# ShellCheck Quick Reference

## Priority Classification

| Priority | Category | Action Required |
|----------|----------|----------------|
| CRITICAL | Security (SC2086, SC2035, SC2059) | Fix immediately |
| HIGH | Syntax (SC1xxx) | Required for execution |
| MEDIUM | Logic (SC2015, SC2164) | Fix to prevent bugs |
| LOW | Performance (SC2002, SC2003) | Optimize when noticed |

## Quick Lookup Table

| Code | Issue | Quick Fix |
|------|-------|-----------|
| SC1000 | Unescaped $ | `echo "Cost is \$5"` |
| SC1037 | ${10} not $10 | `${10}` not `$10` |
| SC1066 | $var=value | `var=value` not `$var=value` |
| SC1068 | Space around = | `var=value` not `var = value` |
| SC2086 | Unquoted variables | `"$var"` not `$var` |
| SC2068 | Unquoted array | `"${array[@]}"` |
| SC2155 | Declare+assign | Separate: `local var; var=$(cmd)` |
| SC2162 | read without -r | `read -r line` |
| SC2164 | cd without check | `cd dir || exit` |

<examples>
<example>
Scenario: Unquoted variables causing word splitting
Bad: `cp $file $dest`
Good: `cp "$file" "$dest"`
Why: Prevents word splitting with filenames containing spaces
</example>

<example>
Scenario: Missing error checking on directory change
Bad: `cd /some/path; rm -rf *`
Good: `cd /some/path || exit 1; rm -rf *`
Why: Prevents catastrophic deletion in wrong directory if cd fails
</example>

<example>
Scenario: Command substitution in loops breaking with whitespace
Bad: `for file in $(find . -name "*.txt"); do`
Good: `find . -name "*.txt" -exec cmd {} \; # or while read loop`
Why: Handles filenames with spaces correctly
</example>

<example>
Scenario: Array expansion losing elements
Bad: `cmd ${array[@]}`
Good: `cmd "${array[@]}"`
Why: Preserves array elements containing spaces as separate arguments
</example>

<example>
Scenario: Variable assignment confusion
Bad: `$var=value` or `var = value`
Good: `var=value`
Why: Assignment doesn't use $ prefix, and no spaces around =
</example>
</examples>

## Error Categories by Pattern

### SC1000-1199: Syntax and Parsing

**Quote and Escape Patterns**:
- SC1000: `echo "Cost is \$5"` (escape literal $)
- SC1001: `echo '\o'` or `echo "\\\o"` (handle backslashes)
- SC1003: `echo 'can'\''t'` (escape single quotes)
- SC1004: Use separate lines for line continuation in single quotes

**Assignment and Parameter Patterns**:
- SC1007: `var=value` not `var= value`
- SC1037: `${10}` not `$10` for parameters >9  
- SC1066: `var=value` not `$var=value`
- SC1068: `var=value` not `var = value`

**Structure and Flow Patterns**:
- SC1046-1049: Missing `fi`, `then`, `done` keywords
- SC1057-1062: Missing `do` keyword or structure mismatch
- SC1074: Missing `;;` after case patterns

### SC2000-2199: Logic and Best Practices

**Performance Optimizations**:
- SC2000: `${#var}` vs `expr length "$var"`
- SC2001: `${var//old/new}` vs `echo "$var" | sed 's/old/new/'`
- SC2003: `$((a + b))` vs `expr $a + $b`
- SC2006: `"$(command)"` vs `` `command` ``

**Security Critical** (Fix Immediately):
- SC2086: Quote variables: `"$var"`
- SC2068: Quote arrays: `"${array[@]}"`
- SC2035: Use `rm ./*` not `rm *` 
- SC2059: `printf '%s' "$var"` not `printf "$var"`

**Logic Errors**:
- SC2015: `[[ cond ]] && success || failure` → `if [[ cond ]]; then success; else failure; fi`
- SC2164: `cd dir || exit`
- SC2155: `local var; var=$(cmd)` not `local var=$(cmd)`
- SC2162: `read -r line` not `read line`

**Command Usage**:
- SC2046: `find . -delete` not `rm $(find .)`
- SC2013: `while IFS= read -r line; do ... done < file` not `for line in $(cat file)`
- SC2002: `grep pattern file` not `cat file | grep pattern`

### SC3000-3099: POSIX Compliance

**Bash-specific features not in POSIX sh**:
- SC3001: Process substitution `<(cmd)` → use temp files
- SC3010: `[[ ]]` → use `[ ]`
- SC3014: `==` → use `=`
- SC3009: `{a,b}` → explicit alternatives
- SC3005: `for ((;;))` → while loop with counter

<anti_patterns>
Common mistakes when handling ShellCheck warnings:
- Suppressing warnings without understanding the issue
- Fixing syntax but ignoring security implications  
- Using `# shellcheck disable=SC1234` without explanatory comments
- Batch suppressing multiple warnings with `# shellcheck disable=SC1234,SC5678`
- Ignoring POSIX compliance warnings when portability matters
</anti_patterns>

<quality_gates>
Before considering ShellCheck analysis complete:
- [ ] All CRITICAL and HIGH priority warnings resolved
- [ ] Security warnings (SC2086, SC2035, SC2059) addressed
- [ ] Logic errors that could cause data loss fixed
- [ ] Any suppressions include explanatory comments
- [ ] Script tested with resolved changes
</quality_gates>

<thinking>
When encountering ShellCheck warnings:
1. Check warning priority - fix CRITICAL/HIGH first
2. Understand the root cause, don't just suppress
3. Consider if the warning indicates a design problem
4. Test the fix to ensure it doesn't break functionality
5. Document any necessary suppressions with clear reasoning
</thinking>

## Suppression Best Practices

```bash
# ✅ Good: Specific reason provided
# shellcheck disable=SC2034  # Variable used in sourced script
readonly CONFIG_FILE="/etc/app/config"

# ❌ Bad: No explanation
# shellcheck disable=SC2086
cp $file $dest
```

**Golden Rule**: Fix the issue rather than suppress the warning in 95% of cases. Each warning represents accumulated shell scripting wisdom.