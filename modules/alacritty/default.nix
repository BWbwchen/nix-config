{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.alacritty ];
  xdg.configFile."alacritty/alacritty.toml".text = ''
    ${builtins.readFile ./alacritty.toml}
  '';
}
