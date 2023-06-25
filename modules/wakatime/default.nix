{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ wakatime ];
  home.file.".wakatime.cfg".source = ./wakatime.cfg.secret;
}
