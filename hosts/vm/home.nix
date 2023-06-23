{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # For i3
    redshift
    pulseaudioFull # for pacmd, voice control
    # Command line utilities

    # Programming languages

    # Developement tools
  ];
}

