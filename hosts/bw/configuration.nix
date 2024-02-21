{ config, lib, pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../sys-modules/prelude.nix # some necassary package and settings.
    ./system.nix # some system wide settings.
    ./programs.nix # some programs.
    ./service.nix # some system services.
  ];

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chewing # chewing
      fcitx5-gtk
      fcitx5-configtool
    ];
  };
}
