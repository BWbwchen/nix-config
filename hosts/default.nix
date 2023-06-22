{ lib, inputs, nixpkgs, home-manager, user, configDir, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
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
          extraSpecialArgs = { inherit user configDir; };
          users.${user} = {
            imports = hmImports ++ [ (import ./vm/home.nix) ];
          };
        };
      }
    ];
  };
}

