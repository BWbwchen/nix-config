{ config, pkgs, unstable, gitkraken_9_3_0, ... }:

with pkgs;
let
  default-python =
    python3.withPackages (python-packages: with python-packages; [ pip ]);
in {
  imports = [
    ../../modules/polybar # polybar
    (import ../../modules/i3 ({
      inherit config lib pkgs;
      outputOption =
        "--output VGA-1 --mode 1920x1080 --pos 1920x0 --output HDMI-1-0 --primary --mode 1920x1080 --pos 0x0";
    })) # i3
    ../../modules/redshift
    ../../modules/custom-font
    ../../modules/firefox
    ../../modules/alacritty
  ];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "nvidia-x11" ];
  home.packages = with pkgs; [
    # For i3
    pulseaudioFull # for pacmd, voice control
    # Command line utilities
    gtk3
    libsForQt5.gwenview
    libsForQt5.kde-gtk-config
    lm_sensors

    # GPU
    pciutils
    nvtop

    # Programming languages
    gcc11
    default-python
    nixfmt
    gnumake
    gdb
    cmake

    # Clang and Clang tool
    # llvmPackages_15.stdenv # clang
    # llvmPackages_15.openmp # clang
    clang-tools_15 # for clangd

    # Developement tools
    gitkraken_9_3_0.gitkraken

    # Other
    unstable.brave
    unstable.logseq
    unstable.obsidian
    unstable.telegram-desktop
    unstable.zulip
    unstable.slack
    unstable.fluent-reader # rss reader
    barrier
    zotero
    libreoffice
    evince # pdf viewer

    # man page
    pkgs.man-pages
    pkgs.man-pages-posix
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

