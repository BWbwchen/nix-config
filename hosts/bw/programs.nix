{ config, lib, pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.dconf.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    # pinentryFlavor = "curses"; # leave pinentryFlavor null for auto-system detection
  };

}
