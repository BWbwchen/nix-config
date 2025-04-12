{ config, lib, pkgs, ... }:

let
  # type = "vm";
  type = "workstation";
  vm_monitor = "\${env:MONITOR}";
  workstation_monitor = "\${env:MONITOR}";
  monitor = if type == "vm" then vm_monitor else workstation_monitor;
  vm_script = "polybar master &";
  workstation_script =
    "MONITOR=VGA-1 polybar second & MONITOR=HDMI-1-3 polybar master &";
in {
  services.polybar = {
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
      iwSupport = true;
      githubSupport = true;
    };
    enable = true;
    config = let
      background = "#364E5D";
      background-alt = "#364E5D";

      foreground = "#dfdfdf";
      foreground-alt = "#888";

      primary = "#ffb52a";
      secondary = "#e60053";
      alert = "#bd2c40";

      fonts = {
        font-0 = "NotoSans-Regular:size=11;0";
        font-1 = "Material Icons:size=11;2";
        font-2 = "xos4 Terminus:size=14;0";
        font-3 = "Siji:pixelsize=11;1";
        font-4 = "FontAwesome:size=11;0";
      };

      tray_setting = {
        tray-position = "right";
        tray-scale = 1;
        tray-background = background;
        tray-maxsize = 24;

        tray-offset-y = 0;
        tray-padding = 10;
      };
      normal_bar = {
        enable-ipc = true;
        bottom = false;
        monitor = monitor;
        height = 30;
        width = "100%";

        background = background;
        foreground = foreground;

        radius = 15;
        line-color = background;
        line-size = 1;

        padding-left = 0;
        padding-right = 0;
        module-margin-left = 2;
        module-margin-right = 2;

        border-size = 3;
        border-color = "#f7f3f2";

        separator = "|";
        overline-size = 10;
        overline-color = background;
        underline-size = 2;
        underline-color = background;
      };
      i3_showing = {
        modules-left = modules-left;
        modules-center = modules-center;
        modules-right = modules-right;

        wm-restack = "i3";
      };

      modules-left = "i3 ";
      modules-center = "date";
      modules-right = "cpu memory pavolume powermenu";
    in {
      "bar/master" = fonts // normal_bar // tray_setting // i3_showing;
      "bar/second" = fonts // normal_bar // i3_showing;
      # "module/xwindow" = {
      #   type = "internal/xwindow";
      #   label = "%title:0:40:...%";
      # };
      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;

        format = "<label> <ramp-load>";
        format-underline = "#35E3FF";
        label = "CPU %percentage:3%%";
        ramp-load-0 = "▁";
        ramp-load-0-font = 2;
        ramp-load-0-foreground = "#aaff77";
        ramp-load-1 = "▂";
        ramp-load-1-font = 2;
        ramp-load-1-foreground = "#aaff77";
        ramp-load-2 = "▃";
        ramp-load-2-font = 2;
        ramp-load-2-foreground = "#aaff77";
        ramp-load-3 = "▄";
        ramp-load-3-font = 2;
        ramp-load-3-foreground = "#aaff77";
        ramp-load-4 = "▅";
        ramp-load-4-font = 2;
        ramp-load-4-foreground = "#fba922";
        ramp-load-5 = "▆";
        ramp-load-5-font = 2;
        ramp-load-5-foreground = "#fba922";
        ramp-load-6 = "▇";
        ramp-load-6-font = 2;
        ramp-load-6-foreground = "#ff5555";
        ramp-load-7 = "█";
        ramp-load-7-font = 2;
        ramp-load-7-foreground = "#ff5555";
      };
      "module/memory" = {
        type = "internal/memory";
        format = "<label>";
        interval = 2;
        label = "RAM: %gb_used% / %percentage_used:2%%  SWAP: %mb_swap_used%";
        format-underline = "#FF4231";
      };
      "module/date" = {
        type = "internal/date";
        date = "   %%{F#fff}%Y-%m-%d%%{F-}, %a | %%{F#fff}%H:%M:%S%%{F-}";
        format-underline = "#FFF400";
      };
      "module/i3" = {
        type = "internal/i3";
        # type = "internal/xworkspaces";
        format = "<label-state> <label-mode>";

        wrapping-scroll = false;
        fuzzy-match = true;
        # Only show workspaces on the same output as the bar
        pin-workspaces = true;
        strip-wsnumbers = true;
        index-sort = true;

        ws-icon-0 = "1;♚";
        ws-icon-1 = "2;♛";
        ws-icon-2 = "3;♜";
        ws-icon-3 = "4;♝";
        ws-icon-4 = "5;♞";
        ws-icon-default = "♟";

        label-dimmed-underline = background;

        label-mode = "%mode%";
        label-mode-padding = 0;
        label-mode-background = "#e60053";

        # focused = "Active workspace on focused monitor";
        label-focused = "%icon% %name%";
        label-focused-foreground = "#ffffff";
        label-focused-background = "#3f3f3f";
        label-focused-underline = "#fba922";
        label-focused-padding = 2;

        # unfocused = "Inactive workspace on any monitor";
        label-unfocused = "%icon% %name%";
        label-unfocused-padding = 2;

        # visible = "Active workspace on unfocused monitor";
        label-visible = "%name%";
        label-visible-underline = "#555555";
        label-visible-padding = 2;

        # urgent = "Workspace with urgency hint set";
        label-urgent = "%name%";
        label-urgent-foreground = "#000000";
        label-urgent-background = "#bd2c40";
        label-urgent-padding = 2;

        label-separator = "|";
        label-separator-padding = 0;
        label-separator-foreground = "#ffb52a";
      };
      "module/powermenu" = {
        type = "custom/menu";

        format-spacing = 2;
        format-underline = "#FF0000";

        label-open = "";
        label-close = "";
        label-separator = "|";

        menu-0-0 = "Logout";
        menu-0-0-foreground = "#fba922";
        menu-0-0-exec =
          "${pkgs.i3}/bin/i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'";
        menu-0-1 = "Reboot";
        menu-0-1-foreground = "#fba922";
        menu-0-1-exec = "sudo reboot";
        menu-0-2 = "Power off";
        menu-0-2-foreground = "#fba922";
        menu-0-2-exec = "sudo shutdown now";
      };
      "module/pavolume" = {
        type = "custom/script";
        interval = 1;
        label = "%output%";
        exec = "${pkgs.pamixer}/bin/pamixer --get-volume-human";
        click-left = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
        scroll-up = "${pkgs.pamixer}/bin/pamixer --increase 2";
        scroll-down = "${pkgs.pamixer}/bin/pamixer --decrease 2";
        format-underline = "#0a6cf5";
        format-foreground = foreground;
      };
    };
    script = if type == "vm" then vm_script else workstation_script;
  };
  home.packages = with pkgs; [ pamixer ];
}
