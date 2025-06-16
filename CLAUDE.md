# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing development environment
configurations across Unix-like systems (Linux/macOS). It uses a hybrid approach
combining traditional symlink-based dotfile management with Nix for reproducible
development environments.

## Key Management Commands

### Installation and Setup

- **Install all dotfiles**: `./install.sh` (with options: `--dry-run`,
  `--skip-packages`, `--skip-vscode`, `--skip-zsh`)
- **Nix development shell**: `nix-shell` (basic setup) or
  `nix-shell --arg withSpotify true --arg withSteam true`
- **Home Manager**: `home-manager switch` (if using Home Manager configuration)

### Code Quality and Formatting

- **Format all files**: `dprint fmt` (uses `.config/dprint.json` configuration)
- **Check formatting**: `dprint check`
- **Shell script validation**: `shellcheck *.sh` or `shellcheck install.sh`

### Configuration Management

The repository uses multiple configuration approaches:

- **Symlink management**: Via `install.sh` script for `.bashrc`, `.tmux.conf`,
  etc.
- **Nix expressions**: `default.nix` for development environment, `home.nix` for
  Home Manager
- **Shell configurations**: Fish shell config in `.config/fish/`

## Architecture and Structure

### Core Components

**Configuration Management Stack:**

- **install.sh**: Main installation script with backup functionality and
  selective installation
- **Nix files**: `default.nix` provides development shell, `home.nix` for Home
  Manager integration
- **dprint**: Centralized code formatting for multiple languages (JSON,
  Markdown, TypeScript, Python, YAML, Jupyter)

**Shell Environment:**

- **Fish shell**: Primary shell with configuration in `.config/fish/config.fish`
- **Bash compatibility**: `.bashrc` maintained for compatibility
- **Tmux configuration**: `.tmux.conf` for terminal multiplexing

**Development Tools Integration:**

- **Neovim**: Configuration directory `.config/nvim/` with Lua-based setup
- **VS Code**: Automated extension installation and settings via `install.sh`
- **Git integration**: Custom gitignore and configuration management

### Important Patterns

**Environment Setup Pattern:** The repository supports both imperative
(install.sh) and declarative (Nix) approaches to environment setup, allowing
flexibility across different systems while maintaining reproducibility where Nix
is available.

**Backup and Safety:** All installation operations create timestamped backups
before making changes. The install script follows defensive programming
practices with extensive error handling.

## Development Guidelines

### AI Assistant Rules Integration

This repository includes comprehensive AI assistant rules in `.ai/rules/`:

- **Grug Brain Philosophy**: Emphasizes simplicity and maintainability over
  complexity
- **Git Commit Standards**: Linux kernel style commit messages (not Conventional
  Commits)
- **Bash Scripting**: Modern shell scripting practices with safety-first
  approach

### Shell Scripting Standards

When modifying shell scripts:

- Always use `set -euo pipefail` for safety
- Quote all variables: `"${var}"` not `$var`
- Use `local` for function variables
- Include proper error handling and cleanup
- Run `shellcheck` for validation

### Code Formatting

Run `dprint fmt` before committing changes. The configuration supports:

- JSON (4-space indentation)
- Markdown (always wrap text)
- TypeScript, Python, YAML, Jupyter notebooks

## System Dependencies

**Required for full functionality:**

- Bash 4.0+ (for install script)
- Nix package manager (optional, for reproducible environments)
- dprint (for code formatting)
- shellcheck (for shell script validation)

**Language servers and tools** (installed via Nix or package managers):

- yaml-language-server, bash-language-server, lua-language-server
- clangd, marksman, buf, harper-ls
- ripgrep, tinty, alacritty, kitty

The repository is designed to work incrementally - core functionality works with
just Bash, while additional features become available as more tools are
installed.

## Memory Management

This project uses Claude Code memory management with:

- **Project memory** (this file): Shared team instructions for repository
  architecture, coding standards, and workflows
- **User memory** (`~/.claude/CLAUDE.md`): Personal preferences across all
  projects
- **Rule imports**: Detailed domain-specific guidance in `.ai/rules/`

Memory files are automatically loaded when Claude Code launches and support
recursive imports (max 5 hops) using `@path/to/import` syntax.
