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
      24800 # deskflow
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
      noto-fonts-cjk-sans # for chinese font
      noto-fonts-color-emoji
      nerd-fonts.fira-code
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Meslo" "Monaco" "Noto Sans Mono CJK TC" ];
        serif = [ "Noto Sans CJK TC" ];
        sansSerif = [ "Noto Serif CJK TC" ];
      };
    };
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chewing # chewing
      fcitx5-gtk
      qt6Packages.fcitx5-configtool
    ];
  };

  system.stateVersion = "22.11";
}
