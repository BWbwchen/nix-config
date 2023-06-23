{ config, pkgs, ... }:

with pkgs;
let
  default-python =
    python3.withPackages (python-packages: with python-packages; [ pip ]);
in {
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../modules/git.nix # git
    ../modules/zsh.nix
    ../modules/tmux
    ../modules/emacs
    ../modules/firefox
  ];
  home.packages = with pkgs; [
    # GUI utilities
    arandr # visual front end for xrandr
    libsForQt5.gwenview
    libsForQt5.kde-gtk-config

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
    wakatime

    # Programming languages
    gcc
    default-python
    nodejs
    nixfmt
    cargo
    rustc
    gnumake
    gdb
    cmake

    # Other
    google-chrome
    brave
    logseq
    # telegram-desktop # not work in 22.11 only work in 23.05
    tdesktop
  ];
}

