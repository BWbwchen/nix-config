# reference: https://github.com/Harmos274/nixfiles/blob/master/users/nuggets/home/custom-fonts/default.nix
{ config, lib, pkgs, ... }:
let
  fontPaths = [
    ./monaco # Monaco font
  ];
in lib.mkMerge ((map ({ name, path }: {
  home.file.".local/share/fonts/${name}".source = "${path}/${name}";
}) (builtins.concatMap (path:
  map (file: {
    name = file;
    path = path;
  }) (builtins.attrNames (builtins.readDir path))) fontPaths))
  ++ [{ home.activation.cacheFonts = "${pkgs.fontconfig}/bin/fc-cache"; }])
