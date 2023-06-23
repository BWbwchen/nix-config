{ config, lib, pkgs, ... }:

let modifier = "Mod1";
in {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
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
          "${modifier}+d" = "exec ${pkgs.i3lock-fancy}/bin/i3lock-fancy";

          "${modifier}+Shift+e" =
            "exec ${pkgs.i3}/bin/i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'";

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

          # WorkSpace
          "${modifier}+1" = "workspace 1";
          "${modifier}+2" = "workspace 2";
          "${modifier}+3" = "workspace 3";
          "${modifier}+4" = "workspace 4";
          "${modifier}+5" = "workspace 5";
          "${modifier}+6" = "workspace 6";
          "${modifier}+7" = "workspace 7";
          "${modifier}+8" = "workspace 8";
          "${modifier}+9" = "workspace 9";
          "${modifier}+0" = "workspace 10";

          "${modifier}+Shift+1" = "move container to workspace 1";
          "${modifier}+Shift+2" = "move container to workspace 2";
          "${modifier}+Shift+3" = "move container to workspace 3";
          "${modifier}+Shift+4" = "move container to workspace 4";
          "${modifier}+Shift+5" = "move container to workspace 5";
          "${modifier}+Shift+6" = "move container to workspace 6";
          "${modifier}+Shift+7" = "move container to workspace 7";
          "${modifier}+Shift+8" = "move container to workspace 8";
          "${modifier}+Shift+9" = "move container to workspace 9";
          "${modifier}+Shift+0" = "move container to workspace 10";

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
