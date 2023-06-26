{ config, pkgs, ... }:

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

    # GPU
    pciutils
    nvtop

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

    # Developement tools

    # Other
    google-chrome
    brave
    logseq
    telegram-desktop
    barrier
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

  home.sessionVariables.GTK_THEME = "WhiteSur-Dark-solid";
}

