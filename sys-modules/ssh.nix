{ config, lib, pkgs, ... }:

{
  services = {
    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        LogLevel = "VERBOSE";
      };
    };

    fail2ban = {
      enable = true;
      maxretry = 8; # Observe 5 violations before banning an IP
      bantime = "24h"; # Set bantime to one day
      bantime-increment = {
        enable = true; # Enable increment of bantime after each violation
        formula =
          "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
        maxtime = "168h"; # Do not ban for more than 1 week
        overalljails = true; # Calculate the bantime based on all the violations
      };
    };
  };
}
