{ config, lib, pkgs, ... }:

let modifier = "Mod1";
in {
  # programs.thunar.plugins = with pkgs.xfce; [
  #   thunar-archive-plugin
  #   thunar-volman
  # ];
  # services.gvfs.enable = true; # Mount, trash, and other functionalities
  # services.xserver = {
  #   # Configure keymap in X11
  #   layout = "us";
  #   xkbVariant = "";
  #   xkbOptions = "ctrl:nocaps";
  #   displayManager = { defaultSession = "none+i3"; };
  #   windowManager.i3 = {
  #     enable = true;
  #     package = pkgs.i3-gaps;
  #     configFile = ./config;
  #     extraPackages = with pkgs; [
  #       rofi # application launcher, the same as dmenu
  #       dunst # notification daemon
  #       i3blocks # status bar
  #       i3lock # default i3 screen locker
  #       i3status # provide information to i3bar
  #       feh # set wallpaper
  #       arandr # screen layout manager
  #       xorg.xbacklight # control screen brightness, the same as light
  #       xorg.xdpyinfo # get screen information
  #       sysstat # get system information

  #       xfce.thunar # xfce4's file manager
  #     ];
  #   };
  # };
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      # package = with pkgs; [
      #   i3-gaps
      #   gnome.nautilus # file manager
      #   libsForQt5.spectacle # screen shot
      # ];
      package = pkgs.i3-gaps;
      config = {
        inherit modifier;

        bars = [ ];

        window = {
          border = 0;
          hideEdgeBorders = "both";
        };

        gaps = {
          inner = 8;
          outer = 0;
        };

        keybindings = {
          # Misc 
          "${modifier}+q" = "kill";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";
          "${modifier}+r" = "mode resize";

          # Alacritty terminal
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

          # Rofi
          "${modifier}+space" = "exec ${pkgs.rofi}/bin/rofi -show drun";

          # Screenshot
          "${modifier}+p" =
            "exec ${pkgs.libsForQt5.spectacle}/bin/spectacle -r";

          # Movement
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          # Split
          "${modifier}+backslash" = "split h";
          "${modifier}+v" = "split v";

          # File
          "${modifier}+f" = "exec ${pkgs.gnome.nautilus}/bin/nautilus";

          # Audio Volume
          # bindsym XF86AudioRaiseVolume exec --no-startup-id ~/.config/polybar/scripts/pavolume.sh --up
          # bindsym XF86AudioLowerVolume exec --no-startup-id ~/.config/polybar/scripts/pavolume.sh --down
          # bindsym XF86AudioMute exec --no-startup-id ~/.config/polybar/scripts/pavolume.sh --togmute
        };

        modes.resize = {
          "h" = "resize shrink width 10 px or 10 ppt";
          "j" = "resize grow height 10 px or 10 ppt";
          "k" = "resize shrink height 10 px or 10 ppt";
          "l" = "resize grow width 10 px or 10 ppt";
          "Escape" = "mode default";
          "Return" = "mode default";
        };

        startup = [
          {
            command = "${pkgs.feh}/bin/feh --bg-scale ${./i3-wallpaper.jpg}";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
        ];
      };
    };
  };
}
