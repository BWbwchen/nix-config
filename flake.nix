{
  description = "Tim's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # gitkraken with all free feature.
    gitkraken-allfree.url =
      "github:nixos/nixpkgs/da5adce0ffaff10f6d0fee72a02a5ed9d01b52fc";
  };

  outputs =
    inputs@{ self, nixpkgs, nixpkgs-unstable, gitkraken-allfree, home-manager }:
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
        ];
      };
      pkgs = import nixpkgs pkgs-config;
      lib = nixpkgs.lib;
      pkgs-unstable = import nixpkgs-unstable pkgs-unstable-config;
      pkgs-gitkraken = import gitkraken-allfree pkgs-config;
    in {
      nixosConfigurations = {
        bw = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit user pkgs lib;
            inherit pkgs-unstable pkgs-gitkraken;
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
                  inherit pkgs-unstable pkgs-gitkraken;
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
