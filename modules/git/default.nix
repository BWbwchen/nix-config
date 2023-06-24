{ config, lib, pkgs, ... }:

{
  programs.git = {
    #    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "BWbwchen";
    userEmail = "tim.chenbw@gmail.com";
    ignores = [ ".direnv" ];

    lfs.enable = true;

    extraConfig = {

      core = {
        editor = "nvim";
        ignorecase = false;
      };

      commit = { template = "~/.gitmessage.txt"; };

    };
  };
  home.file.".gitmessage.txt".source = ./gitmessage.txt;
}
