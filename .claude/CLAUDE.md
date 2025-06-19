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

- Have a spartan tone
- Be concise and direct
- Focus on practical solutions
- Explain the reasoning behind technical decisions
- Don't over-engineer solutions

### Task Approach

- Understand existing patterns before making changes
- Follow established conventions in the codebase
- Create backups and test changes safely
- Run linting and formatting tools before considering tasks complete

## Claude Code Best Practices

### Memory Management

- **Both**: **Project Memory** (`./CLAUDE.md`): Team-shared instructions for
  project architecture, coding standards, and workflows
- **Both**: **User Memory** (`~/.claude/CLAUDE.md`): Personal preferences across
  all projects
- **User Actions**: Use `@path/to/import` syntax for recursive imports (max 5
  hops)
- **User Actions**: Start input with `#` to quickly add to memory
- **User Actions**: Use `/memory` command to edit memory files
- **Both**: Organize memories with structured markdown and descriptive headings
- **Both**: Periodically review and update memory files

**For AI Agents**: Recommend users create or update CLAUDE.md files when
encountering repetitive instructions or project-specific patterns.

### CLI Workflow Optimization

- **User Actions**: Use `claude` for extended coding sessions
- **User Actions**: Use `claude -p "query"` for scripting and automation
- **User Actions**: Use `claude -c` to resume recent conversations
- **User Actions**: Use `--model` flag for specific model requirements
- **User Actions**: Leverage `--output-format json` for programmatic parsing
- **User Actions**: Use `--verbose` for debugging and detailed insights

**For AI Agents**: Suggest appropriate CLI flags and modes based on the user's
workflow needs.

### Configuration Management

- **Settings Hierarchy**: Enterprise → CLI args → Local project → Shared project
  → User
- **User Actions**: Configure `~/.claude/settings.json` for global preferences
- **User Actions**: Configure `.claude/settings.json` for team-shared
  configuration
- **User Actions**: Configure `.claude/settings.local.json` for personal project
  customization
- **User Actions**: Set environment variables like `ANTHROPIC_API_KEY`,
  `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC`

**For AI Agents**: When encountering permission or configuration issues, guide
users to appropriate settings files and configuration options.

### Extended Thinking Techniques

- **AI Agent Capability**: Use "think" prompts for complex architectural
  planning
- **User Actions**: Request "think harder" or "think more" for intricate
  problems
- **Both**: Best applications include debugging complex issues, feature
  implementation planning, code refactoring
- **Both**: Break complex tasks into smaller, manageable steps

**For AI Agents**: Proactively use thinking techniques for complex problems and
inform users when deep analysis is being applied.

### Effective Interaction Patterns

- **Both**: Start with broad questions, then narrow to specifics
- **Both**: Use domain-specific language and terminology
- **User Actions**: Provide context about project architecture and constraints
- **Both**: Ask for/provide high-level overviews before diving into
  implementation details

**For AI Agents**: Guide users toward more effective prompting patterns when
requests lack sufficient context.

### Advanced Workflow Patterns

#### Explore-Plan-Code-Commit Methodology

- **Both**: Read relevant files and understand existing patterns
- **Both**: Use "think" prompts to create implementation strategy
- **Both**: Implement solution incrementally with verification at each stage
- **Both**: Create atomic commits with meaningful messages

**For AI Agents**: Follow this methodology consistently and explain the approach
to users for complex tasks.

#### Context Management

- **User Actions**: Use `/clear` frequently to prevent context drift and
  maintain focus
- **User Actions**: Start new threads for unrelated tasks
- **Both**: Stage git changes frequently as safety checkpoints
- **User Actions**: Use git worktrees for parallel development streams

**For AI Agents**: Recommend context management techniques when conversations
become unfocused or when working on multiple unrelated tasks.

#### Precision and Iteration

- **User Actions**: Provide extensive context, edge cases, and concrete examples
  in prompts
- **Both**: Break complex tasks into smaller, testable steps
- **User Actions**: Interrupt and redirect if output diverges from intent
- **Both**: Use test-driven approach when appropriate

**For AI Agents**: Request clarification when prompts lack sufficient detail,
and recommend iterative development approaches.

#### Multi-Agent Workflows

- **AI Agent Capability**: Use Task tool to spawn specialized sub-agents for
  complex problems
- **User Actions**: Consider multiple Claude instances for different aspects of
  large problems
- **User Actions**: Utilize headless mode (`claude -p`) for automation and
  scripting workflows

**For AI Agents**: Suggest multi-agent approaches for complex, multi-faceted
problems and explain when Task tool usage is beneficial.

#### Visual and Interactive Techniques

- **User Actions**: Provide screenshots and visual mocks for UI development
- **User Actions**: Take iterative screenshots to refine implementations
- **User Actions**: Use voice input for complex, nuanced prompts
- **User Actions**: Paste images directly for visual context and debugging

**For AI Agents**: Request visual context when working on UI/UX tasks and
suggest screenshot-based iteration workflows.

#### Permission and Tool Management

- **User Actions**: Start with conservative tool permissions
- **User Actions**: Use `/permissions` command to modify access during sessions
- **User Actions**: Curate allowed tools based on project security requirements
- **User Actions**: Consider session-specific permission flags for different
  workflows

**For AI Agents**: When encountering permission restrictions, guide users to
appropriate permission management commands and explain security implications.

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
