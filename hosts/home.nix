{ config, pkgs, user, ... }:

{
  imports = [
    ./apps.nix
  ];

  programs.home-manager.enable = true;

  programs.direnv.enable = true;

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "22.11";
  };

  programs.bash = {
    enable = true;
  };
}
