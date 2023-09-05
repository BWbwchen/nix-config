{ lib, inputs, nixpkgs, home-manager, user, configDir, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    config.permittedInsecurePackages = [ "electron-20.3.12" ];
    overlays = [
      (import ../overlays/logseq) # logseq
    ];
  };
  lib = nixpkgs.lib;
  hmImports = [ (import ./home.nix) ];
in {
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [
      ./vm
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useUserPackages = true;
          extraSpecialArgs = { inherit user configDir pkgs; };
          users.${user} = {
            imports = hmImports ++ [ (import ./vm/home.nix) ];
          };
        };
      }
    ];
  };
  work = lib.nixosSystem {
    inherit system;
    specialArgs = { user = "bwbwchen"; };
    modules = [
      ./work
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useUserPackages = true;
          extraSpecialArgs = {
            inherit configDir pkgs;
            user = "bwbwchen";
          };
          users."bwbwchen" = {
            imports = hmImports ++ [ (import ./work/home.nix) ];
          };
        };
      }
    ];
  };
}
