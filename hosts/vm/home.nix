{ config, pkgs, ... }:

{
  imports = [
    ../../modules/polybar # polybar
    ../../modules/i3 # i3
    ../../modules/redshift
    ../../modules/custom-font
  ];
  home.packages = with pkgs; [
    # For i3
    pulseaudioFull # for pacmd, voice control
    # Command line utilities
    gtk3

    # Programming languages

    # Developement tools
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

