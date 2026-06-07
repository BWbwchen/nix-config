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

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      user = "bwbwchen";
      system = "x86_64-linux";
      pkgs-config = {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable-config = {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "electron-27.3.11" # for obsidian 1.5.3
          "electron-39.8.10" # for obsidian/logseq
        ];
      };
      pkgs = import nixpkgs pkgs-config;
      lib = nixpkgs.lib;
      pkgs-unstable = import nixpkgs-unstable pkgs-unstable-config;
    in {
      nixosConfigurations = {
        bw = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit user pkgs lib;
            inherit pkgs-unstable;
          };
          modules = [
            ./hosts/bw/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = import ./hosts/bw/home.nix;
                extraSpecialArgs = {
                  inherit user pkgs;
                  inherit pkgs-unstable;
                };
              };
            }
          ];
        };

        # LXC container
        lxc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            user = "bw";
            inherit pkgs lib;
            inherit pkgs-unstable;
          };
          modules = [
            ./hosts/lxc/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."bw" = import ./hosts/lxc/home.nix;
                extraSpecialArgs = {
                  user = "bw";
                  inherit pkgs pkgs-unstable;
                };
              };
            }
          ];
        };
      };
    };
}
