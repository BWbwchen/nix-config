{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # For i3
    redshift
    polybar
    # Command line utilities

    # Programming languages

    # Developement tools
  ];
}

