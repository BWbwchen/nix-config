{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
        settings = {
          "browser.display.background_color" = "#FFFFFF";
          "browser.display.background_color.dark" = "#1C1B22";
          "browser.display.foreground_color" = "#000000";
          "browser.display.foreground_color.dark" = "#FBFBFE";
          "browser.search.hiddenOneOffs" =
            "Google,Amazon.com,Bing,DuckDuckGo,Wikipedia (en)";
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.placeholderName" = "Google";
          "browser.urlbar.speculativeConnect.enabled" = true;
          "general.smoothScroll" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };

        userChrome = builtins.readFile ./userChrome.css;
      };
    };
  };

  home.sessionVariables.TZ = "/etc/localtime";
}
