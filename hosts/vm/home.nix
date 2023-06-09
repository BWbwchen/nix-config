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
      outputOption = "--output Virtual-1 --mode 1280x800";
    })) # i3
    ../../modules/redshift
    ../../modules/custom-font
    ../../modules/firefox
  ];
  home.packages = with pkgs; [
    # For i3
    pulseaudioFull # for pacmd, voice control
    # Command line utilities
    gtk3
    libsForQt5.gwenview
    libsForQt5.kde-gtk-config

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
    # telegram-desktop # not work in 22.11 only work in 23.05
    tdesktop
  ];
  gtk = {
    enable = true;
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
    theme = {
      # name = "WhiteSur-Dark";
      name = "WhiteSur-Dark-solid";
      package = pkgs.whitesur-gtk-theme;
    };
    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
    };
    font = { name = "Monaco"; };
    # gtk3 = {
    # bookmarks = [
    #   "file:///home/balsoft/projects Projects"
    #   "davs://nextcloud.balsoft.ru/remote.php/dav/files/balsoft nextcloud.balsoft.ru"
    #   "sftp://balsoft.ru/home/balsoft balsoft.ru"
    # ] ++ map (machine: "sftp://${machine}/home/balsoft ${machine}")
    #   (builtins.attrNames inputs.self.nixosConfigurations);
    # };
  };

  home.sessionVariables.GTK_THEME = "WhiteSur-Dark-solid";
}

