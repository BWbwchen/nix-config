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
    sessionPath = [ "$HOME/.local/bin" ];
  };

  programs.bash = {
    enable = true;
  };
}

