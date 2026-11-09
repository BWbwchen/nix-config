{ config, pkgs, ... }:

{
  imports = [
    ../../sys-modules/ssh.nix # ssh
  ];

  console.useXkbConfig = true;

  security.rtkit.enable = true;

  hardware = {
    bluetooth.enable = true;
    # ledger.enable = true; # Allow ledger devices to connect.
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.intel-media-driver ];
    };
  };

  virtualisation.libvirtd.enable = false;

  services = {
    pcscd.enable = true;
    gvfs.enable = true; # Nautilus file manager.
    joycond.enable = false;
    blueman.enable = true;
    pulseaudio = {
      enable = false; # Since we use pipewire
      # extraConfig = "load-module module-combine-sink";
    };

    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat"; # Disable acceleration.
        middleEmulation = false; # Disable emulating middle click using left + right clicks;
      };
      touchpad = {
        tapping = true;
        disableWhileTyping = true;
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
      # videoDrivers = [ "nvidia" ];
      videoDrivers = [ "modesetting" ];

      windowManager.i3.enable = true;
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
