{ config, lib, pkgs, user, ... }:

{
  imports = [
    ../../sys-modules/i18n.nix # .
    (import ../../sys-modules/networking.nix {
      inherit config lib pkgs;
      host_name = user;
    }) # .
  ];

  boot.loader = {
    # systemd-boot.enable = true;
    grub = {
      enable = true;
      device = "nodev";
      #useOSProber = true;
    };
  };

  time.timeZone = "Asia/Taipei";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      24800 # barrier
    ];
  };

  programs.zsh.enable = true;
  users.groups.${user} = {
    name = "${user}";
    members = [ "${user}" ];
    gid = 1000;
  };
  users.users.${user} = {
    isNormalUser = true;
    group = "${user}";
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  fonts = {
    # Reference: https://zhuanlan.zhihu.com/p/463403799
    packages = with pkgs; [
      noto-fonts-cjk # for chinese font
      noto-fonts-emoji
      nerdfonts
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Meslo" "Monaco" "Noto Sans Mono CJK SC" ];
        serif = [ "Noto Sans CJK SC" ];
        sansSerif = [ "Noto Serif CJK SC" ];
      };
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chewing # chewing
      fcitx5-gtk
      fcitx5-configtool
    ];
  };

  system.stateVersion = "22.11";
}
