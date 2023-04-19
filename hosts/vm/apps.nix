{ config, pkgs, ... }:

{
  imports = [
    ../../modules/git
  ];
  home.packages = with pkgs; [
    # Command line utilities
    vim
    wget
    git

    # Programming languages
    gcc

    # Games
  ];
}

