{ config, pkgs, ... }:

{
  imports = [
    ../modules/git.nix
    ../modules/zsh.nix
  ];
  home.packages = with pkgs; [
    # Command line utilities
    vim
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
    

    # Games
  ];
}

