{ config, lib, pkgs, ... }:

{

  imports = [
    ../../sys-modules/ssh.nix # ssh
  ];

  console.useXkbConfig = true;

  sound.enable = true;
  security.rtkit.enable = true;

  hardware = {
    pulseaudio = {
      enable = false; # Since we use pipewire
      # extraConfig = "load-module module-combine-sink";
    };
    bluetooth.enable = true;
    # ledger.enable = true; # Allow ledger devices to connect.
    nvidia.nvidiaSettings = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [ pkgs.mesa.drivers ];
    };
  };

  virtualisation.libvirtd.enable = true;

  # services.dbus.enable = true;
  # services.dbus.packages = with pkgs; [ dconf ];
  services = {
    gvfs.enable = true; # Nautilus file manager.
    joycond.enable = true;
    blueman.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

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
    };

    xserver = {
      enable = true;
      xkb = {
        variant = "";
        options = "ctrl:nocaps";
        layout = "us";
      };
      videoDrivers = [ "nvidia" "modesetting" ];

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
