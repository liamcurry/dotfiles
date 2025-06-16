# Personal Development Preferences

This file contains my global preferences for AI assistants working with my
dotfiles repository.

## Philosophy and Approach

### Grug Brain Simplicity

- Prefer simple, maintainable solutions over complex abstractions
- "Grug brain" philosophy: if something is too complex to understand easily,
  it's probably wrong
- Choose boring, proven technologies over new, exciting ones

### Safety and Reliability First

- Always create backups before making changes
- Use defensive programming practices with proper error handling
- Test changes incrementally rather than big-bang deployments
- Fail fast and fail safely

## Code Quality Standards

### Shell Scripting

- Always use `set -euo pipefail` for safety
- Quote all variables: `"${var}"` not `$var`
- Use `local` for function variables
- Include proper error handling and cleanup
- Validate with `shellcheck`

### Git Practices

- Linux kernel style commit messages (not Conventional Commits)
- Meaningful, descriptive commit messages focusing on "why" not "what"
- Keep commits atomic and focused on single changes

### Code Formatting

- Use `dprint fmt` for consistent formatting across all file types
- Follow language-specific style guides when available
- Maintain consistency with existing codebase patterns

## Development Environment Preferences

### Tools and Technologies

- **Shell**: Fish as primary, Bash for compatibility
- **Editor**: Neovim with Lua configuration
- **Terminal**: Alacritty/Kitty with tmux
- **Package Management**: Nix for reproducible environments
- **Formatting**: dprint for multi-language support

### System Philosophy

- Hybrid approach: traditional dotfiles + Nix for reproducibility
- Incremental functionality - core features work with minimal dependencies
- Cross-platform compatibility (Linux/macOS focus)

## AI Assistant Guidelines

### Communication Style

- Be concise and direct
- Focus on practical solutions
- Explain the reasoning behind technical decisions
- Don't over-engineer solutions

### Task Approach

- Understand existing patterns before making changes
- Follow established conventions in the codebase
- Create backups and test changes safely
- Run linting and formatting tools before considering tasks complete

---

## Rule Imports

The following rules provide detailed guidance for specific domains. Import these
rules as needed for different types of work:

### Global Rules

| Rule File                            | Description                                       | When to Use                                                          |
| ------------------------------------ | ------------------------------------------------- | -------------------------------------------------------------------- |
| @../.ai/rules/global/grugbrain.md    | Simplicity-first philosophy for maintainable code | All development work - emphasizes simple solutions over complex ones |
| @../.ai/rules/global/google-style.md | Google's engineering style standards              | Enterprise projects requiring strict consistency                     |
| @../.ai/rules/global/12factor.md     | Twelve-factor app methodology                     | Building scalable, maintainable applications                         |

### Language-Specific Rules

| Rule File                                 | Description                               | When to Use                                               |
| ----------------------------------------- | ----------------------------------------- | --------------------------------------------------------- |
| @../.ai/rules/bash/bash.md                | Fundamental bash scripting best practices | Any shell script development                              |
| @../.ai/rules/bash/google-shellguide.md   | Google's comprehensive shell style guide  | Production shell scripts requiring enterprise standards   |
| @../.ai/rules/bash/shellcheck-warnings.md | Complete ShellCheck warning reference     | Debugging shell script issues and learning best practices |
| @../.ai/rules/docker/dockerfile.md        | Docker container best practices           | Building Docker images and containers                     |

### Documentation and Git

| Rule File                               | Description                               | When to Use                                   |
| --------------------------------------- | ----------------------------------------- | --------------------------------------------- |
| @../.ai/rules/docs/mermaid.md           | Mermaid diagram syntax and best practices | Creating technical diagrams and documentation |
| @../.ai/rules/git/git-commit-message.md | Linux kernel style commit message format  | All git commits - focuses on "why" not "what" |

### AI/Prompting

| Rule File                               | Description                                   | When to Use                                     |
| --------------------------------------- | --------------------------------------------- | ----------------------------------------------- |
| @../.ai/rules/prompting/cursor-rules.md | Best practices for writing AI assistant rules | Creating or modifying AI assistant instructions |
