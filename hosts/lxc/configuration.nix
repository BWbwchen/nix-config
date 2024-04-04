{ config, lib, pkgs, pkgs-unstable, user, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/lxc-container.nix>
    ../../sys-modules/prelude.nix # some necassary package and settings.
    ./system.nix # some system wide settings.
    ./programs.nix # some programs.
    ./service.nix # some system services.
  ];
}
