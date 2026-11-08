{
  description = "Tim's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "electron-27.3.11" # for obsidian 1.5.3
          "electron-39.8.10" # for obsidian/logseq
        ];
      };

      mkHost =
        host: user:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              user
              lib
              pkgs
              pkgs-unstable
              ;
          };
          modules = [
            ./hosts/${host}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = import ./hosts/${host}/home.nix;
                extraSpecialArgs = { inherit user pkgs pkgs-unstable; };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        bw = mkHost "bw" "bwbwchen";
        tp = mkHost "tp" "bwbwchen";
      };
    };
}
