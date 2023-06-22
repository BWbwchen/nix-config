{ config, pkgs, ... }:

with pkgs;
let
  default-python =
    python3.withPackages (python-packages: with python-packages; [ pip ]);
in {
  nixpkgs.config.allowUnfree = true;
  imports =
    [ ../modules/git.nix ../modules/zsh.nix ../modules/tmux ../modules/emacs ];
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
    firefox
    google-chrome
    brave
    logseq
  ];
}

