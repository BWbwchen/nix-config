{ config, lib, pkgs, ... }:

{
  # imports = [ ../../modules/i3 ];
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      # config = null;
      configFile = ../../modules/i3/config;
    };
  };
}
