# Claude Code

Use Anthropic's CLI tool to code faster with AI directly in your terminal.
Terminal-native tool with deep codebase understanding and direct code editing.

## Key Takeaways

- **Terminal integration**: Lives in your terminal, no separate editors needed
- **Codebase awareness**: Understands entire project structure automatically
- **Memory management**: CLAUDE.md files store context and preferences
- **Direct actions**: Edits files, runs tests, creates commits, handles PRs
- **Enterprise ready**: Works with Bedrock, Vertex AI, secure deployments
- **Multi-session**: Run multiple Claude instances for parallel work

## Concepts

### Core Architecture

**Terminal-First Design**: Claude Code runs directly in your terminal as an
interactive REPL. No web interfaces or separate applications needed.

**Agentic Tool Access**: Unlike chat-based tools, Claude Code can take direct
actions: edit files, run commands, search git history, create commits.

**Project Context**: Automatically discovers and understands your codebase
structure, build systems, and testing frameworks without manual configuration.

### Memory System

**Three Memory Levels**:

- **User Memory** (`~/.claude/CLAUDE.md`): Personal preferences across all
  projects
- **Project Memory** (`./CLAUDE.md`): Team-shared project standards and
  workflows
- **Command Library** (`.claude/commands/`): Custom slash commands for repeated
  tasks

**Import System**: Use `@path/to/file` syntax to include other files in memory.
Supports recursive imports up to 5 levels deep.

### CLI Interface

**Interactive Mode**: `claude` starts REPL session for back-and-forth
conversation

**Direct Query**: `claude -p "query"` runs single query and exits, perfect for
scripting

**Session Management**: `claude -c` continues last conversation,
`claude -r <id>` resumes specific session

## Rules

1. **Install globally**: `npm install -g @anthropic-ai/claude-code` for
   system-wide access
2. **Set API key**: Configure `ANTHROPIC_API_KEY` environment variable before
   first use
3. **Create memory files**: Add `CLAUDE.md` files for project context and
   personal preferences
4. **Use slash commands**: Store repeated workflows in `.claude/commands/`
   directory
5. **Clear context often**: Run `/clear` between unrelated tasks to prevent
   context drift
6. **Configure permissions**: Set allowed/disallowed tools in settings for
   security
7. **Enable verbose mode**: Use `--verbose` flag when debugging or learning
   Claude's process
8. **Manage sessions**: Use `--continue` and `--resume` flags to maintain
   conversation continuity
9. **Validate external links**: Test all URLs in memory files return valid
   responses
10. **Version control settings**: Check `.claude/settings.json` into git for
    team consistency

## Examples

### Installation and Setup

**GOOD**:

```bash
npm install -g @anthropic-ai/claude-code
export ANTHROPIC_API_KEY="your-key-here"
claude
```

_Why this is good: Global installation makes Claude available everywhere,
environment variable properly configured, starts interactive session for
immediate use_

**BAD**:

```bash
npm install @anthropic-ai/claude-code
claude -p "help me code"
```

_Why this is bad: Local installation limits access to current directory, no API
key configured will cause authentication errors, jumping straight to queries
without setup_

### Memory File Structure

**GOOD**:

```markdown
# CLAUDE.md

## Project Standards

- Use TypeScript strict mode
- Run `npm test` before commits
- Follow Prettier formatting

## Architecture

- API routes in `/api/`
- Components in `/components/`
- Utils in `/lib/utils/`

@../shared-rules/typescript.md
```

_Why this is good: Clear project standards, specific file structure, imports
shared rules for consistency, focuses on actionable guidelines_

**BAD**:

```markdown
# CLAUDE.md

This project is a web application that uses modern technologies and follows best
practices for software development in the JavaScript ecosystem.
```

_Why this is bad: Vague description without actionable guidance, no specific
standards or structure, missing imports, too general to be useful_

### CLI Usage Patterns

**GOOD**:

```bash
# Interactive development
claude

# Script automation
claude -p "fix all TypeScript errors" --output-format json

# Resume work
claude -c
```

_Why this is good: Uses interactive mode for complex tasks, structured output
for automation, session continuity for ongoing work_

**BAD**:

```bash
# Always in non-interactive mode
claude -p "help with my code"
claude -p "also fix the tests"
claude -p "and update documentation"
```

_Why this is bad: Loses context between queries, inefficient for related tasks,
misses benefits of conversation flow_

### Custom Command Organization

**GOOD**:

```bash
# .claude/commands/debug-api.md
Debug the API endpoint by:
1. Check server logs
2. Verify request format
3. Test database connection
4. Review authentication
```

_Why this is good: Specific, actionable workflow stored as reusable command,
clear step-by-step process, easily accessible via slash commands_

**BAD**:

```bash
# .claude/commands/help.md
Help me with general coding tasks and answer questions about the codebase.
```

_Why this is bad: Too vague to be useful, no specific workflow, doesn't leverage
Claude's capabilities effectively_

## Resources

| Name                                                                               | Fetch When                                    |
| ---------------------------------------------------------------------------------- | --------------------------------------------- |
| [Claude Code Overview](https://docs.anthropic.com/en/docs/claude-code/overview)    | Understanding basic concepts and capabilities |
| [CLI Usage Guide](https://docs.anthropic.com/en/docs/claude-code/cli-usage)        | Learning commands, flags, and usage patterns  |
| [Memory Management](https://docs.anthropic.com/en/docs/claude-code/memory)         | Setting up CLAUDE.md files and context        |
| [Settings Configuration](https://docs.anthropic.com/en/docs/claude-code/settings)  | Configuring permissions and preferences       |
| [Security Guide](https://docs.anthropic.com/en/docs/claude-code/security)          | Understanding permissions and tool access     |
| [Common Workflows](https://docs.anthropic.com/en/docs/claude-code/tutorials)       | Learning practical usage patterns             |
| [Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices) | Advanced tips and techniques                  |

### Local Resources

| Name                        | Fetch When                                |
| --------------------------- | ----------------------------------------- |
| @simple-writing.md          | Writing clear memory files and commands   |
| @markdown.md                | Formatting CLAUDE.md files properly       |
| @test-driven-development.md | Using Claude Code for TDD workflows       |
| @bash-scripting.md          | When Claude Code helps with shell scripts |

## Checklist

### 1. Installation Phase

1. [ ] **Install Claude Code** - Run `npm install -g @anthropic-ai/claude-code`
       successfully
2. [ ] **Configure API key** - Set `ANTHROPIC_API_KEY` environment variable with
       valid key
3. [ ] **Test installation** - Run `claude` and get interactive prompt without
       errors
4. [ ] **Update regularly** - Run `claude update` to get latest features and
       fixes

### 2. Project Setup Phase

5. [ ] **Create project memory** - Add `CLAUDE.md` file with project standards
       and architecture
6. [ ] **Configure settings** - Set up `.claude/settings.json` with team
       permissions and preferences
7. [ ] **Add custom commands** - Create `.claude/commands/` directory with
       workflow templates
8. [ ] **Test memory loading** - Verify Claude loads and uses project context
       correctly

### 3. Daily Usage Phase

9. [ ] **Use interactive mode** - Start `claude` for complex, multi-step tasks
10. [ ] **Clear context regularly** - Run `/clear` between unrelated tasks to
        prevent drift
11. [ ] **Resume sessions** - Use `claude -c` to continue previous conversations
12. [ ] **Validate outputs** - Review and test Claude's code changes before
        committing

### 4. Advanced Usage Phase

13. [ ] **Set up MCP integrations** - Configure `.mcp.json` for additional tool
        access
14. [ ] **Use parallel sessions** - Run multiple Claude instances for code
        review workflows
15. [ ] **Automate with scripts** - Use `claude -p` with `--output-format json`
        for automation
16. [ ] **Monitor performance** - Use `--verbose` flag to understand Claude's
        decision process

