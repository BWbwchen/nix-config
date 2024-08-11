{ config, lib, pkgs, pkgs-unstable, user, ... }:

{
  imports = [
    (import ../../sys-modules/home-manager.nix {
      inherit config lib pkgs user;
      state_version = "23.11";
    })
    # ../../modules/emacs
  ];

  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    # eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    neovim

    # misc
    file
    which
    tree
    gnutar
    gnupg
    duf

    htop

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring

    python3
    nixfmt-classic
    gnumake
    gdb
    cmake
    clang-tools_15

    man-pages
    man-pages-posix
    linux-manual
    stdmanpages
  ];
}
