{ config, lib, pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = {
      max-cache-ttl = 86400; # valid for 1 day.
      default-cache-ttl = 86400; # valid for 1 day.
    };
  };
  programs.direnv.enable = true;
}
