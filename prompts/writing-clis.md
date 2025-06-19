# Writing CLIs

Design and implement command-line interfaces that follow Unix philosophy while
providing modern user experiences and maintainable architectures.

## KEY TAKEAWAYS

- **Unix philosophy**: Build small, focused tools that do one thing well and
  compose together
- **Consistent syntax**: Follow `command [options] [arguments]` pattern with
  predictable behavior
- **Progressive disclosure**: Simple defaults for beginners, advanced options
  for power users
- **Error handling**: Provide clear, actionable error messages with proper exit
  codes
- **Human-first design**: Balance machine parseability with human readability
  using format flags
- **Help everywhere**: Generate comprehensive help automatically, make discovery
  easy
- **Plumbing and porcelain**: Separate low-level operations from user-friendly
  interfaces

## CONCEPTS

### Unix Philosophy and Composability

The Unix philosophy says build small programs that do one thing well. Each tool
reads text and writes text. This lets you connect tools with pipes to create
powerful workflows.

Programs work as filters. They transform input to output. They stay quiet unless
something goes wrong. Only errors need messages. This design lets you chain
commands together.

### Command Structure and Parsing

Modern CLIs use hierarchical commands:
`program command subcommand [options] [arguments]`. Git and Docker made this
pattern popular. It groups related functions and helps users find what they
need.

Options have short (`-v`) and long (`--verbose`) forms. You can combine short
options (`-xvf`). Long options make scripts readable. Arguments come after
options. Document which ones are required.

### Exit Codes and Error Handling

Exit codes tell scripts if a program worked. Zero means success. Non-zero means
failure. Use 1 for general errors, 2 for wrong usage, 126 for permission
problems, and 127 for missing commands.

Error messages must help users fix problems. Say what went wrong, why, and how
to fix it. Send errors to stderr. Keep stdout clean for program output.

### Output Formats and Interactivity

CLIs need readable output for humans and parseable output for machines.
Interactive users like colors, progress bars, and tables. Piped output should be
plain text that other tools can parse.

Check if output goes to a terminal or a pipe. Use TTY detection to pick the
right format. Add format flags like `--json` and `--csv` for scripts.

### Help and Documentation

Help text must be complete but easy to scan. Include usage patterns, command
descriptions, options, and examples. Generate help from your parsing code to
keep them in sync.

Offer different help levels. Use `-h` for quick help, `--help` for details, and
man pages for complete docs. Show version info with `-v` or `--version`.

### Configuration and Persistence

CLIs need settings beyond command-line arguments. Use platform conventions:
`~/.config/program/` on Linux, `~/Library/Application Support/` on macOS.
Support environment variables too.

Layer your config sources. Command-line flags beat environment variables.
Environment variables beat config files. Config files beat defaults. Document
this order.

## RULES

### Command Design

1. **Follow verb-noun pattern**: Use `docker run`, `git commit`, not
   `run-docker` or `commit-git`
2. **Provide command aliases**: Offer shortcuts like `k` for `kubectl` when
   appropriate
3. **Design for composability**: Ensure output from one command feeds naturally
   into another
4. **Group related commands**: Use subcommands to organize functionality
   logically
5. **Make dangerous operations explicit**: Require `--force` or confirmation for
   destructive actions

### Argument Handling

6. **Support standard conventions**: Implement `-h/--help`, `--version`,
   `-q/--quiet`, `-v/--verbose`
7. **Use consistent flag names**: Choose `--output` or `--format` and stick with
   it across commands
8. **Accept stdin when sensible**: Allow `-` to represent stdin/stdout in file
   arguments
9. **Validate arguments early**: Check all inputs before starting operations
10. **Provide sensible defaults**: Make common use cases work without flags

### Output and Feedback

11. **Write errors to stderr**: Keep stdout clean for program output
12. **Support multiple output formats**: Provide `--json`, `--yaml`, `--csv` for
    automation
13. **Show progress for long operations**: Use progress bars or status updates
    for operations over 1 second
14. **Respect output preferences**: Honor `--quiet` by suppressing non-essential
    output
15. **Use color judiciously**: Enhance readability but provide `--no-color`
    option

### Error Handling

16. **Return appropriate exit codes**: Use 0 for success, 1-125 for errors,
    126-127 for shell errors
17. **Provide actionable error messages**: Include what failed, why, and how to
    fix it
18. **Validate inputs comprehensively**: Check file existence, permissions, and
    format validity
19. **Handle interrupts gracefully**: Clean up resources on SIGINT/SIGTERM
20. **Suggest corrections**: Implement "did you mean?" for typos in commands

## EXAMPLES

### Command Structure

**GOOD**:

```bash
# Clear verb-noun pattern with logical grouping
docker container ls
docker container run nginx
docker image build -t myapp .
docker volume create data

# Composable output
docker ps -q | xargs docker stop
```

_Why: Hierarchical structure groups related commands, verb-noun pattern is
predictable, output designed for piping_

**BAD**:

```bash
# Inconsistent patterns
docker-ps
docker-run nginx
build-docker-image -t myapp .
create-volume data

# Non-composable output
docker list-containers --pretty
```

_Why: Inconsistent naming, flat command structure, formatted output breaks
piping_

### Error Messages

**GOOD**:

```bash
$ myapp deploy production
Error: Configuration file not found at /home/user/.config/myapp/config.yml

To fix this issue:
  1. Run 'myapp init' to create a default configuration
  2. Or copy an existing config: cp example.yml ~/.config/myapp/config.yml
  
For more help, run: myapp help deploy
```

_Why: Clearly states problem, provides specific solutions, offers next steps_

**BAD**:

```bash
$ myapp deploy production
Error: missing config
```

_Why: Vague error, no indication of which config or where it should be, no
guidance on resolution_

### Output Formats

**GOOD**:

```bash
# Human-readable default
$ todo list
✓ Write CLI guide
○ Review pull requests
○ Update documentation

# Machine-readable on request
$ todo list --json
[{"id":1,"task":"Write CLI guide","done":true},
 {"id":2,"task":"Review pull requests","done":false},
 {"id":3,"task":"Update documentation","done":false}]

# Silent when piped
$ todo list | grep Review
○ Review pull requests
```

_Why: Pretty output for humans, structured data for machines, pipe-friendly
behavior_

**BAD**:

```bash
# Only pretty output
$ todo list
╭────────────────────────╮
│ YOUR TODOS FOR TODAY!  │
├────────────────────────┤
│ [DONE] Write guide     │
│ [    ] Review PRs      │
╰────────────────────────╯

# Breaks when piped
$ todo list | grep Review
│ [    ] Review PRs      │
```

_Why: Overly decorated output, no machine-readable option, decorations leak into
pipes_

### Help Documentation

**GOOD**:

```bash
$ myapp --help
Usage: myapp [command] [options]

A tool for managing deployments

Commands:
  init        Initialize a new project
  deploy      Deploy application to environment
  rollback    Rollback to previous version
  status      Check deployment status

Options:
  -h, --help      Show help
  -v, --version   Show version
  -c, --config    Config file path (default: ./myapp.yml)
  --dry-run       Preview changes without applying

Examples:
  # Initialize new project
  myapp init --template node

  # Deploy to production
  myapp deploy production --tag v1.2.3

  # Check status of staging
  myapp status staging

Run 'myapp [command] --help' for command details
```

_Why: Clear usage pattern, organized sections, practical examples, pointer to
more help_

**BAD**:

```bash
$ myapp --help
myapp v1.0.0

init|deploy|rollback|status [-h] [-v] [-c CONFIG] [--dry-run]

For more information, see the man page.
```

_Why: Cryptic syntax, no descriptions, no examples, unhelpful reference to
possibly non-existent man page_

### Configuration Layering

**GOOD**:

```bash
# Clear precedence and transparency
$ myapp config show
Configuration sources (highest priority first):
  1. Command line:     --timeout=30
  2. Environment:      MYAPP_RETRIES=5
  3. Project config:   ./myapp.yml
  4. User config:      ~/.config/myapp/config.yml
  5. System defaults:  /etc/myapp/defaults.yml

Effective configuration:
  timeout: 30        # from command line
  retries: 5         # from environment
  endpoint: prod.api # from ./myapp.yml
  loglevel: info     # from ~/.config/myapp/config.yml
  color: auto        # from system defaults
```

_Why: Shows configuration sources, indicates precedence, displays effective
values with origins_

**BAD**:

```bash
$ myapp config
timeout=30
retries=5
endpoint=prod.api
loglevel=info
color=auto
```

_Why: No indication of where values come from, precedence unclear, hard to debug
configuration issues_

## CHECKLIST

### Design Phase

1. [ ] **Define command hierarchy** - Plan verb-noun structure and logical
       command groupings
2. [ ] **Choose parsing library** - Select framework (Cobra, Click, argparse)
       matching language ecosystem
3. [ ] **Design configuration layers** - Plan precedence: CLI flags > env vars >
       config files > defaults
4. [ ] **Plan output formats** - Design human-readable and machine-parseable
       output structures
5. [ ] **Map exit codes** - Define specific codes for different error scenarios

### Implementation Phase

6. [ ] **Implement help generation** - Create comprehensive help with examples
       for all commands
7. [ ] **Add input validation** - Validate arguments, check file permissions,
       verify formats
8. [ ] **Handle signals properly** - Implement cleanup for SIGINT/SIGTERM
9. [ ] **Support standard flags** - Include --help, --version, --quiet,
       --verbose, --no-color
10. [ ] **Detect terminal capabilities** - Check TTY, color support, terminal
        width

### User Experience

11. [ ] **Add progress indicators** - Show progress bars or spinners for
        operations over 1 second
12. [ ] **Implement shell completion** - Generate completion scripts for bash,
        zsh, fish
13. [ ] **Create helpful error messages** - Include problem, reason, and
        solution in errors
14. [ ] **Support output formats** - Implement --json, --yaml, --csv for
        automation
15. [ ] **Write man pages** - Create comprehensive documentation for system-wide
        installation

### Testing and Quality

16. [ ] **Test argument parsing** - Verify all flag combinations and edge cases
17. [ ] **Validate exit codes** - Ensure consistent, meaningful exit codes
18. [ ] **Test pipe behavior** - Verify proper behavior when stdout/stderr are
        redirected
19. [ ] **Check cross-platform compatibility** - Test on Linux, macOS, Windows
        if applicable
20. [ ] **Measure performance** - Ensure fast startup time and responsive
        operation

