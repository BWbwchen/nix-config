# Argument (passed from configuration.nix):
#   swapSizeMiB  size of the swap file in MiB, keep >= RAM (see `free -m`)
#
# tp was installed without any swap, so a swap file is added for hibernate.
# resume= / resume_offset= are left out on purpose: with systemd in the initrd
# (boot.initrd.systemd.enable, the default) systemd-sleep records where it wrote
# the hibernation image in the HibernateLocation EFI variable and the initrd
# resumes from there. This needs UEFI boot (tp has it).
# https://wiki.nixos.org/wiki/Power_Management#Hibernation
{ swapSizeMiB }:

{ ... }:

let
  # what closing the lid / tapping the power button does
  sleepAction = "suspend-then-hibernate";
in
{
  # --- swap --------------------------------------------------------------------
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = swapSizeMiB;
    }
  ];
  # compressed RAM swap is used first (like macOS memory compression), the swap
  # file only takes the overflow and the hibernation image.
  zramSwap.enable = true;

  # prefer S3 ("deep") over s2idle when the firmware offers it: much lower drain
  # while asleep. Ignored when the firmware has no S3.
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  powerManagement.enable = true;
  powerManagement.powertop.enable = false;

  # --- MacBook-like sleep ------------------------------------------------------
  services.logind.settings.Login = {
    HandleLidSwitch = sleepAction;
    HandleLidSwitchExternalPower = sleepAction;
    HandleLidSwitchDocked = "ignore"; # external monitor attached: clamshell mode
    HandlePowerKey = sleepAction; # tap = sleep
    HandlePowerKeyLongPress = "poweroff";
  };
  # like macOS standby: suspend first, hibernate after this long
  systemd.sleep.settings.Sleep.HibernateDelaySec = "3h";

  # --- power saving ------------------------------------------------------------
  # switches by itself when the charger is plugged / unplugged
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave"; # intel_pstate: speed is decided by EPP
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      # deep idle: let PCIe links, USB, Wi-Fi and the audio codec sleep on battery
      PCIE_ASPM_ON_BAT = "powersupersave";
      RUNTIME_PM_ON_BAT = "auto";
      USB_AUTOSUSPEND = 1;
      WIFI_PWR_ON_BAT = "on";
      SOUND_POWER_SAVE_ON_BAT = 1;
    };
  };
  services.thermald.enable = true; # Intel thermal management

  # hibernate on a critically low battery instead of dying hard
  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
  };
}
