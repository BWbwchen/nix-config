{ config, pkgs, ... }:

{
  imports = [
    ../modules/git.nix
    ../modules/zsh.nix
    ../modules/tmux
  ];
  home.packages = with pkgs; [
    # Command line utilities
    neovim
    wget
    curl
    htop
    neofetch
    unzip
    ripgrep
    

    # Programming languages
    gcc
    python3
    nodejs
    cargo
    rustc
    gnumake
    gdb
    cmake
    

    # Games
  ];
}

