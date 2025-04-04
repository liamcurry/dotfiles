{ config, pkgs, ... }:

{
  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    git-lfs
  ];

  programs = {
    kitty = {
      enable = true;
      # kitty config from your dotfiles
    };
    
    neovim = {
      enable = true;
      defaultEditor = true;
      # neovim config from your dotfiles
    };

    tmux = {
      enable = true;
      # tmux config from your dotfiles
    };

    git = {
      enable = true;
      # git config from your .gitconfig
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  # For other dotfiles
  home.file = {
    ".config/kitty".source = ./dotfiles/.config/kitty;
    ".config/nvim".source = ./dotfiles/.config/nvim;
    ".config/tmux".source = ./dotfiles/.config/tmux;
    ".bashrc".source = ./dotfiles/.bashrc;
    ".zshrc".source = ./dotfiles/.zshrc;
  };

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    RUST_BACKTRACE = "1";
    DPRINT_CONFIG = "$HOME/.config/dprint/dprint.json";
  };

  # Fonts
  fonts.fontconfig.enable = true;
  home.file.".local/share/fonts" = {
    source = ./fonts;
    recursive = true;
  };
} 