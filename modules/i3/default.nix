{ config, lib, pkgs, outputOption, # xrandr render option
primaryMonitor, secondaryMonitor ? primaryMonitor, ... }:

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
          commands = [
            {
              command = "border pixel 5";
              criteria = { class = "^.*"; };
            }
            {
              command = "move to workspace $ws1";
              criteria = { class = "Google"; };
            }
            {
              command = "move to workspace $ws1";
              criteria = { class = "firefox"; };
            }
            {
              command = "move to workspace $ws2";
              criteria = { class = "Emacs"; };
            }
          ];
        };

        gaps = {
          inner = 8;
          outer = 0;
          smartBorders = "on";
        };

        floating = {
          inherit modifier;
          criteria = [
            { class = "Telegram"; } # telegram floating
            { class = "Nautilus"; } # file manager floating
            { class = "spectacle"; } # screenshot floating
            { class = "Bitwarden"; } # bitwarden floating
            { window_role = "pop-up"; }
          ];
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
          "${modifier}+f" = "exec ${pkgs.nautilus}/bin/nautilus";

          # WorkSpace
          "${modifier}+1" = "workspace $ws1";
          "${modifier}+2" = "workspace $ws2";
          "${modifier}+3" = "workspace $ws3";
          "${modifier}+4" = "workspace $ws4";
          "${modifier}+5" = "workspace $ws5";
          "${modifier}+6" = "workspace $ws6";
          "${modifier}+7" = "workspace $ws7";
          "${modifier}+8" = "workspace $ws8";
          "${modifier}+9" = "workspace $ws9";

          "${modifier}+Shift+1" = "move container to workspace $ws1";
          "${modifier}+Shift+2" = "move container to workspace $ws2";
          "${modifier}+Shift+3" = "move container to workspace $ws3";
          "${modifier}+Shift+4" = "move container to workspace $ws4";
          "${modifier}+Shift+5" = "move container to workspace $ws5";
          "${modifier}+Shift+6" = "move container to workspace $ws6";
          "${modifier}+Shift+7" = "move container to workspace $ws7";
          "${modifier}+Shift+8" = "move container to workspace $ws8";
          "${modifier}+Shift+9" = "move container to workspace $ws9";

          # Audio Volume
          "XF86AudioRaiseVolume" =
            "exec ${pkgs.pamixer}/bin/pamixer --increase 2";
          "XF86AudioLowerVolume" =
            "exec ${pkgs.pamixer}/bin/pamixer --decrease 2";
          "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute";
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
            command = "systemctl --user restart polybar";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.alttab}/bin/alttab -w 1 -d 1";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.xorg.xrandr}/bin/xrandr ${outputOption}";
            always = true;
            notification = false;
          }
          {
            command = "fcitx5";
            always = true;
            notification = false;
          }
          {
            command = "barrier";
            always = true;
            notification = false;
          }
        ];
      };
      extraConfig = ''
        set $ws1 "1:www"
        set $ws2 "2:emacs"
        set $ws3 "3:term"
        set $ws4 4
        set $ws5 5
        set $ws6 6
        set $ws7 7
        set $ws8 8
        set $ws9 9

        workspace $ws1 output ${primaryMonitor}
        workspace $ws2 output ${primaryMonitor}
        workspace $ws3 output ${primaryMonitor}
        workspace $ws4 output ${primaryMonitor}
        workspace $ws5 output ${primaryMonitor}
        workspace $ws6 output ${secondaryMonitor}
        workspace $ws7 output ${secondaryMonitor}
        workspace $ws8 output ${secondaryMonitor}
        workspace $ws9 output ${secondaryMonitor}
      '';
    };
  };
}
