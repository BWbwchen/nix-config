{ ... }:

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
}

