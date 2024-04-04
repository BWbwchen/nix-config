{ config, lib, pkgs, user, ... }:

{
  imports = [
    ../../sys-modules/i18n.nix # .
    (import ../../sys-modules/networking.nix {
      inherit config lib pkgs;
      host_name = user;
    }) # .
  ];

  time.timeZone = "Asia/Taipei";

  programs.zsh.enable = true;
  users.groups.${user} = {
    name = "${user}";
    members = [ "${user}" ];
    gid = 1000;
  };
  users.users.${user} = {
    isNormalUser = true;
    description = user;
    group = user;
    extraGroups = [ "networkmanager" "wheel" ];
    password = user;
    shell = pkgs.zsh;
  };

  system.stateVersion = "23.11";
}
