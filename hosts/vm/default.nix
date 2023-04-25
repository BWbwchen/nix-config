{ ... }:

{
  imports = [
    # include the hardware setting
    ./hardware-configuration.nix
    ./gui.nix
  ];

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

