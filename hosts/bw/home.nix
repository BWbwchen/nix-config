{ config, lib, pkgs, pkgs-unstable, pkgs-gitkraken, user, ... }:

with pkgs;
let
  default-python =
    python3.withPackages (python-packages: with python-packages; [ pip ]);
  primaryMonitor = "HDMI-1-3";
  secondaryMonitor = "VGA-1";
in {
  imports = [
    (import ../../sys-modules/home-manager.nix {
      inherit config lib pkgs user;
      state_version = "22.11";
    })
    (import ../../modules/polybar ({
      inherit config lib pkgs primaryMonitor secondaryMonitor;
    })) # polybar
    (import ../../modules/i3 ({
      inherit config lib pkgs primaryMonitor secondaryMonitor;
      outputOption =
        "--output ${secondaryMonitor} --mode 1920x1080 --pos 1920x0 --output ${primaryMonitor} --primary --mode 1920x1080 --pos 0x0";
    })) # i3
    ../../modules/redshift
    ../../modules/custom-font
    ../../modules/firefox
    ../../modules/alacritty
    ../../modules/emacs
    ../../modules/wakatime
    ../../modules/vscode
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "nvidia-x11" ];
  home.packages = with pkgs; [
    # RDP
    remmina

    # GUI utilities
    arandr # visual front end for xrandr

    # archives
    zip
    unzip
    unrar
    xz
    p7zip

    # utils
    ripgrep
    appimage-run
    any-nix-shell # zsh support for nix-shell
    openvpn
    vlc
    ledger

    # misc
    file
    tree
    gnutar
    feh
    tig

    # For i3
    pulseaudioFull # for pacmd, voice control
    # Command line utilities
    gtk3
    libsForQt5.gwenview
    libsForQt5.kde-gtk-config
    lm_sensors

    # GPU
    pciutils
    nvtopPackages.full

    # Programming languages
    gcc11
    default-python
    nixfmt-classic
    gnumake
    gdb
    cmake

    # Clang and Clang tool
    # llvmPackages_15.stdenv # clang
    # llvmPackages_15.openmp # clang
    clang-tools_15 # for clangd

    # Developement tools
    pkgs-gitkraken.gitkraken
    pkgs-unstable.code-cursor

    # Other
    pkgs-unstable.brave
    pkgs-unstable.logseq
    # pkgs-unstable.obsidian
    pkgs-unstable.telegram-desktop
    # pkgs-unstable.zulip
    # pkgs-unstable.slack
    barrier
    # zotero
    libreoffice
    evince # pdf viewer

    # man page
    man-pages
    man-pages-posix
    linux-manual
    stdmanpages

    glxinfo
  ];
  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 40;
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
    theme = {
      # name = "WhiteSur-Dark";
      name = "WhiteSur-Dark-solid";
      package = pkgs.whitesur-gtk-theme.override { nautilusSize = "180"; };
    };
    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 40;
    };
    font = {
      name = "Monaco";
      size = 16;
    };
    gtk3 = {
      bookmarks = [
        "file:///home/bwbwchen/nix-config nix-config"
        "file:///home/bwbwchen/logseq logseq"
        "file:///home/bwbwchen/knowledge knowledge"
        "file:///home/bwbwchen/work work"
      ];
    };
  };
  xdg.userDirs = {
    enable = true;
    desktop = "${config.home.homeDirectory}/Desktop";
    download = "${config.home.homeDirectory}/Downloads";
    documents = null;
    music = null;
    pictures = null;
    publicShare = null;
    templates = null;
    videos = null;
  };

  home.sessionVariables.GTK_THEME = "WhiteSur-Dark-solid";
}
