{ config, lib, ... }:

let
  # --- swap file + hibernate -------------------------------------------------
  # tp was installed without any swap, so hibernate needs a swap file, and
  # resuming from a swap file needs its physical offset on disk, which only
  # exists once the file does. Hence two steps:
  #   1. rebuild with `swapResumeOffset = null`: creates the swap file, the lid
  #      does a plain suspend, hibernate stays off.
  #   2. get the offset, put it below, rebuild and REBOOT once:
  #        sudo filefrag -v /var/lib/swapfile | awk '$1=="0:" { print substr($4, 1, length($4)-2) }'
  swapSizeMiB = 16 * 1024; # keep >= RAM, see `free -m`
  swapResumeOffset = null;
  hibernateReady = swapResumeOffset != null;

  # what closing the lid / tapping the power button does
  sleepAction = if hibernateReady then "suspend-then-hibernate" else "suspend";
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

  # --- hibernate ---------------------------------------------------------------
  boot.resumeDevice = lib.mkIf hibernateReady config.fileSystems."/".device;
  boot.kernelParams = [
    # prefer S3 ("deep") over s2idle when the firmware offers it: much lower drain
    # while asleep. Ignored when the firmware has no S3.
    "mem_sleep_default=deep"
  ] ++ lib.optional hibernateReady "resume_offset=${toString swapResumeOffset}";

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
    };
  };
  services.thermald.enable = true; # Intel thermal management

  # act on a critically low battery instead of dying hard
  services.upower = {
    enable = true;
    criticalPowerAction = if hibernateReady then "Hibernate" else "PowerOff";
  };
}
