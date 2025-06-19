# Development environment for my setup
# 
# NOTE: This file is maintained for backward compatibility.
# For the latest features, use the flake.nix configuration:
#   nix develop              # Development environment
#   nix develop .#personal   # Personal desktop environment
#
# Legacy usage:
#   nix-shell                                  # Basic setup
#   nix-shell --arg withPersonal true         # Include personal apps
#
# Requirements:
#   - Nix package manager
#   - Optional: .fonts directory for custom fonts

{ pkgs ? import <nixpkgs> {},
  withPersonal ? false
}:

let
  # Personal desktop applications
  personalApps = with pkgs; [
    # Creative tools
    blender
    krita
    inkscape
    
    # Media
    spotify
    vlc
    
    # Gaming
    steam
    
    # Communication
    discord
    
    # Productivity
    obsidian
    
    # File transfer
    filezilla
  ];
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # Version control
    git
    git-lfs
    gh  # GitHub CLI
    delta  # Better git diff
    
    # Editors and terminals
    neovim
    alacritty
    tmux
    
    # Shell integration
    direnv
    nix-direnv
    
    # Languages and runtimes
    rustup
    lua5_1  # Neovim-compatible Lua
    nodejs  # For fnm to manage
    python3  # For conda to manage
    
    # Language servers and tools
    lua-language-server
    bash-language-server
    yaml-language-server
    marksman  # Markdown LSP
    harper-ls  # Grammar checking LSP
    clang-tools
    markdownlint-cli
    shellcheck
    buf
    stylua
    
    # Build tools
    gnumake
    cmake
    pkg-config
    
    # Search and file tools
    fzf
    fd
    ripgrep
    bat
    eza
    tree
    
    # Network tools
    curl
    wget
    httpie
    
    # Data processing
    jq  # JSON processor
    
    # Formatting and themes
    dprint
    tinty  # Terminal theme manager
    
    # Container tools
    docker
    docker-compose
    
    # Nix tools
    nix
    nixpkgs-fmt
    nil  # Nix language server
    
    # Node version manager
    fnm
    
    # Password manager
    _1password
    _1password-gui
    
    # Browser for development
    google-chrome
    
    # Media (always included now)
    vlc
  ] ++ (if withPersonal then personalApps else [])
    ++ lib.optionals stdenv.isLinux [ appimage-run ];

  # Environment variables set directly in the shell
  EDITOR = "nvim";
  TERMINAL = "alacritty";
  DOCKER_BUILDKIT = "1";
  
  shellHook = ''
    echo "Legacy nix-shell environment loaded"
    echo ""
    echo "NOTE: Consider using the new flake-based configuration:"
    echo "  nix develop              # Development environment"
    echo "  nix develop .#personal   # Personal desktop environment"
    echo ""
    echo "Available tools:"
    echo "  - Editors: neovim, alacritty"
    echo "  - Languages: rust (via rustup), lua, node (via fnm), python"
    echo "  - Tools: git, docker, shellcheck, dprint, fzf, ripgrep"
    echo ""
    if [ "$withPersonal" = "true" ]; then
      echo "Personal apps included: Blender, Krita, Steam, Spotify, Discord, etc."
    else
      echo "Use 'nix-shell --arg withPersonal true' to include personal apps"
    fi
    
    # Initialize fnm if installed
    if command -v fnm &> /dev/null; then
      eval "$(fnm env --use-on-cd)"
    fi
  '';
}

