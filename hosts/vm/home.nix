{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # For i3
    pulseaudioFull # for pacmd, voice control
    # Command line utilities
    gtk3

    # Programming languages

    # Developement tools
  ];
}

