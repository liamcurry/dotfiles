{
  description = "Personal dotfiles with development and desktop environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Development tools - always included
        devTools = with pkgs; [
          # Version control
          git
          git-lfs
          gh  # GitHub CLI
          delta  # Better git diff
          
          # Editors and terminals
          neovim
          alacritty
          tmux
          
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
        ];
        
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
        
        # Linux-specific tools
        linuxTools = with pkgs; lib.optionals stdenv.isLinux [
          # AppImage management
          appimage-run
          # Note: Gear Lever is not in nixpkgs, but we can run AppImages
        ];
        
        # Create Conda environment setup
        condaSetup = pkgs.writeShellScriptBin "setup-conda" ''
          #!/usr/bin/env bash
          set -euo pipefail
          
          CONDA_PREFIX="$HOME/miniconda3"
          
          if [ ! -d "$CONDA_PREFIX" ]; then
            echo "Installing Miniconda..."
            INSTALLER_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-$(uname -s)-$(uname -m).sh"
            wget "$INSTALLER_URL" -O /tmp/miniconda.sh
            bash /tmp/miniconda.sh -b -p "$CONDA_PREFIX"
            rm /tmp/miniconda.sh
            
            # Initialize conda for bash and fish
            "$CONDA_PREFIX/bin/conda" init bash fish 2>/dev/null || true
            
            echo "Miniconda installed successfully!"
          fi
          
          # Activate conda
          source "$CONDA_PREFIX/etc/profile.d/conda.sh"
          
          # Create or update base environment with common packages
          echo "Setting up global Python environment..."
          conda activate base
          conda install -y python=3.11 pip ipython jupyter numpy pandas matplotlib seaborn scikit-learn
          
          echo ""
          echo "Conda setup complete! Python $(python --version) is now available."
          echo "Common packages installed: numpy, pandas, matplotlib, seaborn, scikit-learn, jupyter"
        '';
        
        # Create fnm Node.js setup
        fnmSetup = pkgs.writeShellScriptBin "setup-fnm" ''
          #!/usr/bin/env bash
          set -euo pipefail
          
          # Initialize fnm
          eval "$(fnm env --use-on-cd)"
          
          # Check if any Node version is installed
          if ! fnm list | grep -q "v"; then
            echo "Installing Node.js LTS..."
            fnm install --lts
            fnm default $(fnm list | grep -o 'v[0-9]*\.[0-9]*\.[0-9]*' | head -1)
            
            # Install common global packages
            echo "Installing common npm packages..."
            npm install -g yarn pnpm typescript ts-node nodemon prettier eslint
            
            echo ""
            echo "Node.js setup complete!"
            node --version
            npm --version
            echo "Global packages installed: yarn, pnpm, typescript, ts-node, nodemon, prettier, eslint"
          else
            echo "Node.js already installed:"
            node --version
          fi
        '';
        
      in {
        # Development shell (default)
        devShells.default = pkgs.mkShell {
          buildInputs = devTools ++ linuxTools ++ [ condaSetup fnmSetup ];
          
          shellHook = ''
            echo "Development environment loaded"
            echo ""
            echo "Available tools:"
            echo "  - Editors: neovim, alacritty"
            echo "  - Languages: rust (via rustup), lua, node (via fnm), python (via conda)"
            echo "  - Tools: git, gh, docker, shellcheck, dprint, fzf, ripgrep, jq, curl, wget"
            echo "  - Language servers: lua-language-server, bash-language-server, yaml-language-server, marksman, clang-tools"
            echo ""
            
            # Set up environment
            export EDITOR="nvim"
            export TERMINAL="alacritty"
            export DOCKER_BUILDKIT=1
            
            # Initialize fnm
            if command -v fnm &> /dev/null; then
              eval "$(fnm env --use-on-cd)"
              
              # Install Node.js if not already installed
              if ! fnm list | grep -q "v" 2>/dev/null; then
                echo "No Node.js version found. Run 'setup-fnm' to install Node.js LTS with common packages."
              fi
            fi
            
            # Initialize conda
            if [ -d "$HOME/miniconda3" ]; then
              source "$HOME/miniconda3/etc/profile.d/conda.sh" 2>/dev/null || true
            else
              echo "Conda not found. Run 'setup-conda' to install Miniconda with Python 3.11 and data science packages."
            fi
            
            echo ""
            echo "Quick setup commands:"
            echo "  - setup-fnm    : Install Node.js LTS with yarn, pnpm, typescript, etc."
            echo "  - setup-conda  : Install Miniconda with Python 3.11 and data science packages"
            echo ""
            echo "Run 'nix develop .#personal' for personal desktop applications"
          '';
        };
        
        # Personal desktop environment shell
        devShells.personal = pkgs.mkShell {
          buildInputs = devTools ++ personalApps ++ linuxTools ++ [ condaSetup fnmSetup ];
          
          shellHook = ''
            echo "Personal desktop environment loaded"
            echo ""
            echo "Includes all development tools plus:"
            echo "  - Creative: Blender, Krita, Inkscape"
            echo "  - Media: Spotify, VLC"
            echo "  - Gaming: Steam"
            echo "  - Communication: Discord"
            echo "  - Productivity: Obsidian, FileZilla"
            
            # Set up environment
            export EDITOR="nvim"
            export TERMINAL="alacritty"
            export DOCKER_BUILDKIT=1
            
            # Initialize fnm
            if command -v fnm &> /dev/null; then
              eval "$(fnm env --use-on-cd)"
              
              # Install Node.js if not already installed
              if ! fnm list | grep -q "v" 2>/dev/null; then
                echo ""
                echo "No Node.js version found. Run 'setup-fnm' to install Node.js LTS."
              fi
            fi
            
            # Initialize conda
            if [ -d "$HOME/miniconda3" ]; then
              source "$HOME/miniconda3/etc/profile.d/conda.sh" 2>/dev/null || true
            else
              echo ""
              echo "Conda not found. Run 'setup-conda' to install Miniconda with Python 3.11."
            fi
          '';
        };
        
        # Minimal shell for CI/CD or constrained environments
        devShells.minimal = pkgs.mkShell {
          buildInputs = with pkgs; [
            git
            neovim
            shellcheck
            dprint
            nixpkgs-fmt
          ];
          
          shellHook = ''
            echo "Minimal environment loaded"
          '';
        };
        
        # Home Manager configuration
        homeConfigurations.${system} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      });
}
