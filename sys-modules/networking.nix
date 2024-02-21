{ config, lib, pkgs, host_name ? "bw_workstation", ... }:

{
  networking = {
    hostName = host_name;
    networkmanager.enable = true;
    # resolvconf.enable = false; # prevent default nameservers
    # nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };
}
