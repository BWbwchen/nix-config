{ config, pkgs, user, inputs, ... }:

{
  imports = [
    # include the hardware setting
    ./hardware-configuration.nix
    ../../modules/i3
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "ctrl:nocaps";
  };

  services.blueman.enable = true;

  services.openssh.enable = true;
  services.qemuGuest.enable = true;

  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };
  };

  # Automatically delete generations older than a week
  nix.gc = {
    automatic = true;
    options = "--delete-generations 8d";
  };

  networking = {
    hostName = "${user}-vm";
    networkmanager.enable = true;
    resolvconf.enable = false; # prevent default nameservers
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  time.timeZone = "Asia/Taipei";

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

  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "password";
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.stable; # flakes
    extraOptions = "experimental-features = nix-command flakes";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

