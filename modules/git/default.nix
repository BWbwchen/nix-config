{ config, lib, pkgs, ... }:

let
  # optional arg: use git sign or not.
  gitSignEnabled = config._module.args.gitSignEnabled or true;
in {
  programs.git = {
    #    package = pkgs.gitAndTools.gitFull;
    enable = true;
    ignores = [ ".direnv" ];

    lfs.enable = true;

    signing = {
      key = "AF1C0F596A8F1346D3070412A856CC61E240F91A";
      signByDefault = gitSignEnabled;
    };

    settings = {
      user = {
        name = "BWbwchen";
        email = "tim.chenbw@gmail.com";
      };
      
      core = {
        editor = "nvim";
        ignorecase = false;
        quotepath = false;
      };

      commit = { template = "~/.gitmessage.txt"; };

    };
  };
  home.packages = with pkgs;
    [
      git-crypt # crypt secret file
    ];
  home.file.".gitmessage.txt".source = ./gitmessage.txt;
}
