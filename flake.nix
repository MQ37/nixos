{
  description = "MQ NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-23.11";
      inputs.nixpkgs-23_11.follows = "nixpkgs";
    };
    mynixpkgs = {
      url = "github:MQ37/mynixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self
            , nixpkgs
            , home-manager
            , simple-nixos-mailserver
            , mynixpkgs
            , ...
            }@inputs: {
    nixosConfigurations = {

      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mq = import ./hosts/laptop/home.nix;

            home-manager.extraSpecialArgs = {
              #devenv = inputs.devenv;
              inherit (inputs) mynixpkgs;
            };
          }
        ];
      };

      nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mq = import ./hosts/desktop/home.nix;

            home-manager.extraSpecialArgs = {
              #devenv = inputs.devenv;
              inherit (inputs) mynixpkgs;
            };
          }
        ];
      };

      nixos-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/server/configuration.nix
          simple-nixos-mailserver.nixosModules.mailserver
        ];
      };

    };
  };
}
