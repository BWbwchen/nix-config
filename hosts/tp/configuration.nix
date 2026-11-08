{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../sys-modules/prelude.nix # some necassary package and settings.
    ./system.nix # some system wide settings.
    ./programs.nix # some programs.
    ./service.nix # some system services.
    # power saving, sleep and hibernate (MacBook-like).
    (import ./power.nix {
      swapSizeMiB = 16 * 1024; # keep >= RAM, see `free -m`
    })
  ];
}
