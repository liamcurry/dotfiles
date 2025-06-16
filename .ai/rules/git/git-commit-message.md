---
description: 
globs: 
alwaysApply: true
---
# Cursor Rules for Beautiful, Consistent Git Commit Messages

## (Linux/Linus Style – Not Conventional Commits)

Use these rules in Cursor to ensure your commit messages follow the traditional, well-regarded Linux kernel and open source conventions—not Conventional Commits.

## When to Apply

### Universal Application
This rule applies to **all commits** in any project, ensuring consistent version control history across:
- Solo projects and team collaborations
- Open source and proprietary codebases  
- Any programming language or framework

### Context-Specific Adaptations
- **Team projects**: Include reviewer references and issue numbers
- **Open source**: Consider `Signed-off-by` for contribution tracking
- **Enterprise**: May require additional metadata per organization policy

**Integrates with**: @bash.mdc and @google-shellguide.mdc for script commit practices

---

## Rules for Commit Messages

### Subject Line
- Write a concise summary of the change in the **imperative mood**  
  (e.g., "Fix bug," not "Fixed bug" or "Fixes bug").
- **Capitalize** the first letter of the subject line.
- **Do not** end the subject line with a period.
- Keep the subject line to **50 characters or less** if possible; never exceed 72 characters.
- The subject line should be able to complete the sentence:  
  "If applied, this commit will…".
- Optionally, append an issue or ticket number at the end  
  (e.g., "Remove unused imports #123").

### Blank Line
- Always separate the subject from the body with a **single blank line**.

### Body
- Use the body to explain **what** and **why** the change was made;  
  avoid describing **how** (the code diff shows that).
- **Wrap** the body at **72 characters** per line.
- Use bullet points or paragraphs as needed; bullets should start with a hyphen or asterisk followed by a space.
- Reference related issues, tickets, or reviewers in the body as needed  
  (e.g., "Fixes #123").
- If applicable, include  
  `Signed-off-by: Name <email>`  
  at the end, preceded by a blank line.

### General Style
- Avoid unnecessary metadata in the subject line; keep it focused on the change.
- Be **clear, descriptive, and succinct**.
- **Never mix unrelated changes** in a single commit.

---

## Example Commit Message

```
Fix race condition in user session handler

A rare race condition could corrupt session state when multiple
requests are processed in parallel. This patch introduces a mutex
to guard session access.

- Resolves intermittent login failures reported in #456
- Adds unit tests for concurrent session creation

Signed-off-by: Jane Doe <jane@example.com>
```

---

## Common Pitfalls & Recovery

### Frequent Mistakes
- **Vague subjects**: "Fix issue" → "Fix database connection timeout in user auth"
- **Wrong mood**: "Fixed bug" → "Fix bug"  
- **Too long subject**: "Fix the really annoying bug that happens when users try to..." → "Fix user authentication timeout"
- **Missing context**: "Update code" → "Update API rate limiting to handle peak traffic"

### Recovery Strategies
```bash
# Fix last commit message
git commit --amend

# Fix multiple recent commits (interactive rebase)
git rebase -i HEAD~3

# Template for better messages
git config commit.template ~/.gitmessage
```

### Subject Line Templates
```
[ACTION] [COMPONENT]: [BRIEF_DESCRIPTION]

Examples:
- Fix auth: handle expired token refresh  
- Add tests: validate user input sanitization
- Refactor database: optimize query performance
- Remove deprecated: cleanup legacy API endpoints
```

## Validation & Quality Assurance

### Validation Commands
```bash
# Check commit message format
git log --oneline -n 10

# Validate message length
git log --pretty=format:"%h %s" | awk 'length($0) > 72 {print "Too long: " $0}'

# Setup commit message template
echo "# Subject (50 chars max)
#
# Body (72 chars per line)
# - What changed and why
# - Reference issues: Fixes #123
#
# Signed-off-by: Your Name <email@domain.com>" > ~/.gitmessage
git config --global commit.template ~/.gitmessage
```

### Pre-commit Hook Example
```bash
#!/bin/bash
# .git/hooks/commit-msg
commit_regex='^[A-Z][a-z].{0,49}$'
error_msg="Commit message format error. Use: 'Fix issue with user auth'"

if ! grep -qE "$commit_regex" "$1"; then
    echo "$error_msg" >&2
    exit 1
fi
```

## Context-Specific Guidelines

### Solo Projects
- Focus on clarity for future self
- Omit issue references unless using issue tracking
- Prioritize describing the "why" behind changes

### Team Collaboration  
- Always include issue/ticket references
- Consider reviewer mentions in body
- Use consistent terminology across team

### Open Source Contributions
- Include `Signed-off-by` for legal compliance
- Reference maintainer guidelines
- Be extra clear for external reviewers

### Emergency Fixes
```bash
# For critical hotfixes
git commit -m "Hotfix: patch security vulnerability in auth

Critical security fix for CVE-2024-XXXX. Immediate deployment
required to prevent unauthorized access.

- Validates input parameters in login endpoint
- Adds rate limiting to prevent brute force attacks

Reviewed-by: Security Team <security@company.com>"
```

---

## Summary Table

| Section      | Rule                                                                                     |
|--------------|------------------------------------------------------------------------------------------|
| Subject      | Imperative mood, capitalized, ≤50 chars, no period, blank line after, may add #issue     |
| Body         | Explain what/why, wrap at 72 chars, bullets ok, references ok, blank line before signoff |
| Style        | No unrelated changes, be clear and succinct, avoid metadata in subject                   |

---

## Integration with Development Workflow

### Code Review Process
- Commit messages become part of code review
- Good messages help reviewers understand intent
- Consider squashing related commits before merge

### Release Management
- Clear commit history aids in generating changelogs
- Issue references enable automated release notes
- Consistent format supports git log filtering

### Debugging & Maintenance
- Descriptive commits help with `git blame` and `git bisect`
- Clear history reduces time spent understanding changes
- Good messages become documentation over time

## References

- Linus Torvalds, Linux kernel documentation, and widely adopted open source practices.

**See also:**
- @bash.mdc for shell script commit practices
- @google-shellguide.mdc for enterprise development standards  
- @cursor-rules.mdc for rule authoring and maintenance
