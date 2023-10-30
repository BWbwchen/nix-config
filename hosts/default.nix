{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, user, configDir, ... }:

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
  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
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
          extraSpecialArgs = { inherit user configDir pkgs unstable; };
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
            inherit configDir pkgs unstable;
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
