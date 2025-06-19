# Nix Development Environment Setup

This repository includes a comprehensive Nix configuration for reproducible development environments with all required tools and applications.

## Quick Start

### Prerequisites

1. Install Nix with flakes support:
```bash
curl -L https://nixos.org/nix/install | sh -s -- --daemon
```

2. Enable flakes (add to `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`):
```
experimental-features = nix-command flakes
```

### Usage

#### Development Environment (Default)

For the core development tools:

```bash
# Enter development shell
nix develop

# Or with direnv (recommended)
direnv allow
```

Includes:
- **Editors**: Neovim, Alacritty
- **Languages**: Rust (rustup), Lua 5.1, Node.js (fnm), Python (base for conda)
- **Language Servers**: lua-language-server, bash-language-server, clang-tools, nil (Nix LSP)
- **Tools**: Git, Git LFS, Docker, tmux, fzf, ripgrep, fd, bat, eza
- **Formatters**: dprint, stylua, shellcheck, markdownlint-cli
- **Build Tools**: make, cmake, pkg-config, buf
- **Security**: 1Password

#### Personal Desktop Environment

For development tools plus personal applications:

```bash
# Enter personal environment
nix develop .#personal

# Or with direnv
export NIXSHELL=personal
direnv allow
```

Additional applications:
- **Creative**: Blender, Krita, Inkscape
- **Media**: Spotify, VLC
- **Gaming**: Steam
- **Communication**: Discord
- **Productivity**: Obsidian, FileZilla

#### Minimal Environment

For CI/CD or constrained environments:

```bash
nix develop .#minimal
```

### Legacy Support

If you're on a system without flakes support:

```bash
# Basic development environment
nix-shell

# With personal applications
nix-shell --arg withPersonal true
```

## Environment Variables

The following are set automatically:
- `EDITOR=nvim`
- `TERMINAL=alacritty`
- `DOCKER_BUILDKIT=1`

## Initial Setup Scripts

The environment includes automated setup scripts for Node.js and Python:

### Node.js Setup (via fnm)

```bash
# Run the automated setup (installs Node.js LTS + global packages)
setup-fnm
```

This will:
- Install the latest Node.js LTS version
- Set it as the default version
- Install common global packages: yarn, pnpm, typescript, ts-node, nodemon, prettier, eslint

Manual fnm commands:
```bash
# Install a specific Node version
fnm install 20

# Use a specific version
fnm use 20

# List installed versions
fnm list
```

### Python Setup (via Conda)

```bash
# Run the automated setup (installs Miniconda + data science packages)
setup-conda
```

This will:
- Install Miniconda for your platform (Linux/macOS, x86_64/ARM)
- Set up Python 3.11 as the base environment
- Install common data science packages: numpy, pandas, matplotlib, seaborn, scikit-learn, jupyter, ipython

After setup, conda will be automatically initialized in your shell.

## Linux-Specific Features

### AppImage Support

On Linux systems, AppImage support is included automatically. You can run AppImages with:

```bash
appimage-run ./some-app.AppImage
```

Note: Gear Lever is not available in nixpkgs, but you can manage AppImages using the command line tools provided.

## Customization

### Adding Packages

To add packages to your local environment, create `.envrc.local`:

```bash
# Example .envrc.local
export NIXSHELL=personal  # Use personal environment by default
export CUSTOM_VAR=value
```

### Project-Specific Shells

Create a `shell.nix` in your project:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  inputsFrom = [ (import /path/to/dotfiles {}).devShells.default ];
  buildInputs = with pkgs; [
    # Additional project-specific tools
  ];
}
```

## Troubleshooting

### Direnv Not Loading

```bash
# Make sure direnv is allowed
direnv allow

# Check direnv status
direnv status
```

### Flakes Not Enabled

If you see errors about experimental features:

1. Check your Nix version: `nix --version` (should be 2.4+)
2. Ensure flakes are enabled in nix.conf
3. Restart the Nix daemon: `sudo systemctl restart nix-daemon`

### Package Conflicts

If you experience conflicts between Nix and system packages:

1. Ensure Nix paths take precedence in your shell
2. Use `nix-shell --pure` for isolated environments
3. Check `which <command>` to verify package sources

## Notes

- Packages are fetched from nixpkgs-unstable for the latest versions
- The configuration supports both x86_64 and aarch64 architectures
- All shells include Linux-specific tools when running on Linux
- Personal applications are separated to keep the default development environment lightweight