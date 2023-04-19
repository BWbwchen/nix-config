{ config, pkgs, ... }:

{
  imports = [
    ../modules/git
  ];
  home.packages = with pkgs; [
    # Command line utilities
    vim
    neovim
    wget
    curl
    htop

    # Programming languages
    gcc

    # Games
  ];
}

