{ config, pkgs, user, inputs, ... }:

{
  imports = [
    # include the hardware setting
    ./hardware-configuration.nix
  ];

  boot.loader = {
    # systemd-boot.enable = true;
    grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };
  };
  networking = {
    hostName = "${user}-vm";
    networkmanager.enable = true;
    resolvconf.enable = false; # prevent default nameservers
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  time.timeZone = "Asia/Taipei";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "zh_TW.UTF-8";
      LC_IDENTIFICATION = "zh_TW.UTF-8";
      LC_MEASUREMENT = "zh_TW.UTF-8";
      LC_MONETARY = "zh_TW.UTF-8";
      LC_NAME = "zh_TW.UTF-8";
      LC_NUMERIC = "zh_TW.UTF-8";
      LC_PAPER = "zh_TW.UTF-8";
      LC_TELELPHONE = "zh_TW.UTF-8";
      LC_TIME = "zh_TW.UTF-8";
    };
  };

  services = {
    gvfs.enable = true; # Nautilus file manager.
    joycond.enable = true;
    blueman.enable = true;
    openssh.enable = true;
    qemuGuest.enable = true;
    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      xkbOptions = "ctrl:nocaps";
      # videoDrivers = [ "nvidia" ];
      libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat"; # Disable acceleration.
          middleEmulation =
            false; # Disable emulating middle click using left + right clicks;
        };
      };

      displayManager = {
        defaultSession = "none+i3";
        sddm.autoNumlock = true;

        # autoLogin = {
        #   enable = true;
        #   user = username;
        # };

        # Enable 240hz refresh rate.
        setupCommands =
          "${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 1920x1080 --rate 239.76";
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
  };

  console.useXkbConfig = true;

  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
    # ledger.enable = true; # Allow ledger devices to connect.
    # opengl.driSupport32Bit = true; # Required for steam.
  };

  # Enable docker in rootless mode.
  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };

  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      git
      # docker-compose
      gnome.adwaita-icon-theme
      gnome.nautilus
    ];

    # Disable gui prompt when git asks for a password.
    extraInit = ''
      unset -v SSH_ASKPASS
    '';
  };

  fonts.fonts = with pkgs; [ nerdfonts ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 3000 8080 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  nix = {
    # package = pkgs.nixFlakes;
    package = pkgs.nixVersions.stable; # flakes
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = "experimental-features = nix-command flakes";
  };

  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # services.xrdp.enable = true;
  # services.xrdp.defaultWindowManager = "i3";
  # services.xrdp.openFirewall = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

