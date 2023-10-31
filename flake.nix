{
  description = "Tim's Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gitkraken_allfree.url =
      "github:nixos/nixpkgs/da5adce0ffaff10f6d0fee72a02a5ed9d01b52fc";
  };

  outputs =
    inputs@{ self, nixpkgs, nixpkgs-unstable, gitkraken_allfree, home-manager }:
    let
      user = "bw";
      configDir = "nix-config";
    in {
      nixosConfigurations = import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixpkgs-unstable home-manager user configDir
          gitkraken_allfree;
      };
    };
}
