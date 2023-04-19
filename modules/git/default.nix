{ pkgs, ... }:

{
  programs.git = {
#    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "BWbwchen";
    userEmail = "tim.chenbw@gmail.com";
  };
}

