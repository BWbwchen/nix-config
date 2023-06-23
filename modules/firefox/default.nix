{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };

        userChrome = builtins.readFile ./userChrome.css;
      };
    };
  };

}
