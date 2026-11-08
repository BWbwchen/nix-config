{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../sys-modules/prelude.nix # some necassary package and settings.
    ./system.nix # some system wide settings.
    ./programs.nix # some programs.
    ./service.nix # some system services.
    ./power.nix # power saving, sleep and hibernate (MacBook-like).
  ];
}
