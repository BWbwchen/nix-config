{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ../../sys-modules/home-manager.nix
    ../../modules/polybar # polybar
    ../../modules/i3 # i3
    ../../modules/redshift
    ../../modules/custom-font
    ../../modules/firefox
    ../../modules/alacritty
    ../../modules/vscode
  ];

  # extra arguments consumed by the imported modules
  _module.args = {
    # the first monitor is the primary one
    monitors = [
      { name = "HDMI-0"; pos = "0x0"; }
      { name = "VGA-1-1"; pos = "1920x0"; }
    ];
    state_version = "22.11";
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "nvidia-x11" ];
  home.packages = with pkgs; [
    # RDP
    remmina
    gpclient
    chromium

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
    kdePackages.gwenview
    kdePackages.kde-gtk-config
    lm_sensors

    # GPU
    pciutils
    nvtopPackages.full

    # Programming languages
    (python3.withPackages (p: [ p.pip ]))
    nixfmt

    # Developement tools
    pkgs-unstable.code-cursor

    # Other
    pkgs-unstable.brave
    pkgs-unstable.logseq
    pkgs-unstable.telegram-desktop
    deskflow
    libreoffice
    evince # pdf viewer

    # man page
    man-pages
    man-pages-posix
    linux-manual
    stdmanpages

    # mesa-demos
    steam-run
  ];

  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 40;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
    theme = {
      # name = "WhiteSur-Dark";
      name = "WhiteSur-dark-solid";
      package = pkgs.whitesur-gtk-theme;
    };
    font = {
      name = "Monaco";
      size = 16;
    };
    gtk3.bookmarks = [
      "file:///home/bwbwchen/nix-config nix-config"
      "file:///home/bwbwchen/logseq logseq"
      "file:///home/bwbwchen/knowledge knowledge"
      "file:///home/bwbwchen/work work"
    ];
    gtk4.theme = config.gtk.theme;
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
    setSessionVariables = true;
  };

  home.sessionVariables.GTK_THEME = "WhiteSur-Dark-solid";
}
