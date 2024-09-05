{
  description = "MQ NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-24.05";
      inputs.nixpkgs-24_05.follows = "nixpkgs";
    };
    mynixpkgs = {
      url = "github:MQ37/mynixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self
            , nixpkgs
            , nixpkgs-unstable
            , home-manager
            , simple-nixos-mailserver
            , mynixpkgs
            , nixos-hardware
            , ...
            }@inputs: {
    nixosConfigurations = {

      nixos-laptop = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mq = import ./hosts/laptop/home.nix;

            home-manager.extraSpecialArgs = {
              inherit (inputs) mynixpkgs;
              pkgs-unstable = import inputs.nixpkgs-unstable {
                  system = system;
                  config.allowUnfree = true;
              };
            };
          }
        ];
      };

      nixos-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/server/configuration.nix
          simple-nixos-mailserver.nixosModules.mailserver

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mq = import ./hosts/server/home.nix;

            home-manager.extraSpecialArgs = {
            };
          }

        ];
      };

      nixos-rpi = nixpkgs-unstable.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          nixos-hardware.nixosModules.raspberry-pi-4
          ./hosts/rpi/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mq = import ./hosts/rpi/home.nix;

            home-manager.extraSpecialArgs = {
            };
          }

        ];
      };

    };
  };
}
