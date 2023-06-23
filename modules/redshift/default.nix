{ config, lib, pkgs, ... }:

{
  services.redshift = {
    enable = true;
    latitude = "23.9037";
    longitude = "121.0794";
    temperature.day = 5700;
    temperature.night = 3500;
  };
}
