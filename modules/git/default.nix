{ config, lib, pkgs, ... }:

{
  programs.git = {
    #    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "BWbwchen";
    userEmail = "tim.chenbw@gmail.com";
    ignores = [ ".direnv" ];

    lfs.enable = true;

    signing = {
      key = "AF1C0F596A8F1346D3070412A856CC61E240F91A";
      signByDefault = true;
    };

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
