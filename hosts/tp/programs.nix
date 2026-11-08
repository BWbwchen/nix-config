{ pkgs, ... }:

{
  programs = {
    nix-ld.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # pinentryFlavor = "curses"; # leave pinentryFlavor null for auto-system detection
    };
  };
}
