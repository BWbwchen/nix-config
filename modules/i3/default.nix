{ config, lib, pkgs, ... }:

{
  services.xserver = {
    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      configFile = ./config;
    };
  };
}
