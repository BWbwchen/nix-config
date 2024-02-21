{ config, lib, pkgs, ... }:

{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [ vim curl wget git ];
    variables.EDITOR = "vim";

    # Disable gui prompt when git asks for a password.
    # Disable DPMS and prevent screen from blanking, [reference](https://wiki.archlinux.org/title/Display_Power_Management_Signaling)
    extraInit = ''
      unset -v SSH_ASKPASS
      xset s off -dpms
    '';
  };

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };
}
