{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../modules/git # git
    ../modules/zsh.nix
    ../modules/tmux
    ../modules/emacs
    ../modules/wakatime
  ];
  home.packages = with pkgs; [
    # GUI utilities
    arandr # visual front end for xrandr

    # Command line utilities
    neovim
    wget
    curl
    htop
    neofetch
    zip
    unzip
    unrar
    ripgrep
    file
    appimage-run
    any-nix-shell # zsh support for nix-shell
    tree
    gnupg
    feh
    duf

    # Programming languages

    # Other
  ];
}

