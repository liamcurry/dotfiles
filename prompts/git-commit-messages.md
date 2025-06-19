# Git Commit Messages

Write clear, informative git commit messages that communicate changes
effectively and maintain a readable project history.

## KEY TAKEAWAYS

- **50/72 rule**: Subject line ~50 characters, body wrapped at 72 characters for
  optimal readability
- **Imperative mood**: Write commits as commands: "Fix bug" not "Fixed bug" or
  "Fixes bug"
- **Subject-body separation**: Always separate subject from body with a blank
  line
- **Explain why, not how**: Body should focus on motivation and context, not
  implementation details
- **Atomic commits**: Each commit should represent one logical change
- **Consistent format**: Follow team conventions for prefixes, structure, and
  metadata

## CONCEPTS

### The Purpose of Commit Messages

Git commit messages create a permanent record of your project's history. Diffs
show what changed; commit messages explain why. Good messages help future
developers understand the context and reasons behind each change.

### The 50/72 Rule

The 50/72 rule sets character limits for commit messages. Subject lines should
aim for 50 characters for readability in git logs and UI tools. Body text should
wrap at 72 characters, letting git indent while staying under 80 total. These
are strong guidelines, not absolute rules, based on terminal widths and
readability.

### Imperative Mood

Imperative mood means writing commits as commands. This matches git's own
messages like "Merge branch" or "Revert commit". Your subject line should
complete: "If applied, this commit will [your subject line]". This creates
consistency across the project history.

### Commit Atomicity

Each commit should be one logical change. This makes it easier to understand
changes, review code, revert problems, and use tools like git bisect. If your
message contains "and", split it into multiple commits.

### Conventional Commits

Conventional Commits adds structured prefixes to messages. Types like `feat:`,
`fix:`, `docs:`, and `BREAKING CHANGE:` enable automated versioning, changelog
generation, and clear communication. This approach works with semantic
versioning.

### Linux Kernel Style

The Linux kernel uses subsystem prefixes like `net/ipv4:` or `x86/build:` to
show which code changed. This style includes detailed explanations and metadata
tags like `Fixes:` and `Signed-off-by:` for distributed teams.

## RULES

### Subject Line Format

1. **Limit to ~50 characters**: Keep subject concise while remaining descriptive
2. **Capitalize first letter**: Start with uppercase for consistency
3. **No ending period**: Avoid unnecessary punctuation to save space
4. **Use imperative mood**: Write as command: "Add feature" not "Added feature"
5. **Be specific**: "Fix null pointer in user auth" not "Fix bug"

### Body Structure

6. **Separate with blank line**: Always leave empty line between subject and
   body
7. **Wrap at 72 characters**: Manual line breaks for consistent formatting
8. **Explain why, not what**: Focus on motivation, context, and consequences
9. **Include relevant details**: Error messages, issue numbers, design decisions
10. **Use bullet points if needed**: Organize multiple related changes clearly

### Writing Style

11. **Write for future readers**: Assume reader has no immediate context
12. **Reference issues properly**: Put issue numbers in body, not subject
13. **Mark breaking changes**: Use `BREAKING CHANGE:` for API or behavior
    changes
14. **Add co-author tags**: Credit collaborators with `Co-authored-by:`

### Repository Conventions

15. **Follow team standards**: Use agreed-upon prefixes and formats
16. **Maintain consistency**: Match existing commit style in the project
17. **Use proper metadata**: Include `Signed-off-by`, `Fixes:` tags when
    required

## EXAMPLES

### Basic Commit Structure

**GOOD**:

```
Fix race condition in user session handling

The session cleanup process could delete active sessions when multiple
requests arrived simultaneously. This change adds proper locking around
the session store to prevent concurrent modifications.

This issue was causing users to be randomly logged out during high
traffic periods.

Fixes: #1234
```

_Why: Clear subject, explains the problem and solution, provides context about
impact, references issue_

**BAD**:

```
fixed the bug in sessions.js where users were getting logged out
```

_Why: Lowercase, no body explanation, vague description, includes implementation
details in subject_

### Imperative Mood Examples

**GOOD**:

```
Add caching layer to API responses
Remove deprecated authentication methods
Update dependencies to latest versions
Refactor database connection pooling
```

_Why: All use imperative mood, read as commands, complete the sentence "If
applied, this commit will..."_

**BAD**:

```
Added caching layer to API responses
Removing deprecated authentication methods
Updated dependencies to latest versions
Refactors database connection pooling
```

_Why: Mixed tenses, not imperative mood, inconsistent verb forms_

### Conventional Commit Examples

**GOOD**:

```
feat(auth): add OAuth2 support for Google login

Implements OAuth2 flow for Google authentication as an alternative
to username/password. This allows users to sign in with their
existing Google accounts.

The implementation follows RFC 6749 and includes proper CSRF
protection and state validation.

BREAKING CHANGE: The /api/auth endpoint now requires a 'provider'
parameter. Clients must update their authentication requests.
```

_Why: Clear type and scope, detailed explanation, properly formatted breaking
change notice_

**BAD**:

```
feat: authentication

added google login
```

_Why: Vague subject, no scope specified, minimal body, doesn't explain
implications_

### Linux Kernel Style Example

**GOOD**:

```
net/tcp: fix use-after-free in tcp_cleanup_rbuf()

tcp_cleanup_rbuf() can be called after a socket is closed and its
resources are freed, leading to a use-after-free condition when
high memory pressure triggers aggressive cleanup.

This was discovered when running stress tests with 10000 concurrent
connections under memory constrained conditions. The kernel log showed:

  BUG: KASAN: use-after-free in tcp_cleanup_rbuf+0x42/0x130
  Read of size 4 at addr ffff88801234abcd by task stress/1234

Add a check for sk_state before accessing socket buffer to prevent
accessing freed memory.

Reported-by: Jane Tester <jane@example.com>
Fixes: abc123def456 ("tcp: optimize buffer cleanup")
Signed-off-by: John Developer <john@kernel.org>
```

_Why: Subsystem prefix, detailed problem description, includes error output,
proper metadata tags_

### Multi-line Bullet Points

**GOOD**:

```
Refactor authentication middleware for better modularity

Split the monolithic auth middleware into focused components:

- Extract JWT validation into separate validator class
- Move role checking into dedicated RoleGuard
- Separate session management from auth logic
- Add proper TypeScript interfaces for all auth objects

This refactoring enables easier testing and allows teams to use
only the auth components they need. No changes to external API.
```

_Why: Clear structure, bullet points for related changes, explains benefits_

## CHECKLIST

### Before Writing

1. [ ] **Review changes** - Understand exactly what code changed and why
2. [ ] **Check commit scope** - Ensure changes represent one logical unit
3. [ ] **Identify breaking changes** - Note any API or behavior modifications

### Writing the Message

4. [ ] **Write subject line** - Imperative mood, ~50 chars, capitalized
5. [ ] **Add blank line** - Separate subject from body
6. [ ] **Explain why** - Focus on motivation and context in body
7. [ ] **Wrap at 72 chars** - Use manual line breaks in body text
8. [ ] **Include references** - Add issue numbers, related commits

### Quality Checks

9. [ ] **Verify imperative mood** - Subject completes "If applied, this commit
       will..."
10. [ ] **Check formatting** - No period on subject, proper capitalization
11. [ ] **Review completeness** - Would a developer understand this in 6 months?

### Team Conventions

12. [ ] **Follow prefix format** - Use team's chosen style (conventional,
        subsystem, etc.)
13. [ ] **Add required metadata** - Include Signed-off-by, Co-authored-by tags
14. [ ] **Validate with tools** - Run commitlint or similar if configured
15. [ ] **Match project style** - Align with existing commit message patterns

