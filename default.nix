# Development environment for my setup
#
# Usage:
#   nix-shell                                  # Basic setup
#   nix-shell --arg withSpotify true          # Include Spotify
#   nix-shell --arg withSteam true            # Include Steam
#
# Requirements:
#   - Nix package manager
#   - Optional: .fonts directory for custom fonts

{ pkgs ? import <nixpkgs> {},
  withSpotify ? false,
  withSteam ? false
}:

let
  cargoPackages = {
    dprint = {
      version = "0.49.1";
      hash = "sha256-BDqSKFxvvuGRA5liSPVWY1DFyQrgI4qPZSWw1ZaADrE=";
    };
    ripgrep = {
      version = "14.1.1";
      hash = "sha256-/LDTtXqVD7WEV7rqQVhEAkR1+CQGYGHvI8dxNBUYYDE=";
    };
  };

  # Font handling through Nix
  customFonts = pkgs.symlinkJoin {
    name = "custom-fonts";
    paths = [ ./fonts ];
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # Development shell features
    direnv
    nix-direnv
    
    # Terminal and shell tools
    kitty
    neovim
    tmux
    git
    git-lfs
    
    # Browsers and applications
    firefox
    _1password
    docker
    vlc
    
    # Optional applications
    (if withSpotify then spotify else null)
    (if withSteam then steam else null)
    
    # Development tools
    rustup
    lua51
    (if stdenv.isDarwin 
     then homebrew 
     else if stdenv.isLinux 
          then linuxbrew 
          else throw "Unsupported system")
    
    # Cargo packages
    (cargo.installFromCargoCratesIo {
      pname = "dprint";
      inherit (cargoPackages.dprint) version hash;
    })
    (cargo.installFromCargoCratesIo {
      pname = "ripgrep";
      inherit (cargoPackages.ripgrep) version hash;
    })
    
    # Other development dependencies
    tinty
    shellcheck
    yaml-language-server
    clang-tools
    lua-language-server
    buf
    nodePackages.bash-language-server
    marksman
    
    # Additional tools
    fzf
    fd
    bat
    delta

    # Fonts
    customFonts
  ];

  # Environment variables set directly in the shell
  EDITOR = "nvim";
  TERMINAL = "kitty";
  RUST_BACKTRACE = "1";
  DPRINT_CONFIG = "$PWD/.dprint.json";
}

