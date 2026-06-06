{ config, lib, pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.dconf.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    # pinentryFlavor = "curses"; # leave pinentryFlavor null for auto-system detection
  };
  programs.steam = {
    enable = true; 
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      # protonup-qt
    ];
  };
  programs.gamemode.enable = true;
}
