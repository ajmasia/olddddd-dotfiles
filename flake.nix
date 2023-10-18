{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    amd-controller = {
      type = "github";
      owner = "ajmasia";
      repo = "amd-controller";
      ref = "rolling";
    };
  };
  outputs = inputs @ { home-manager, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        ajmasia = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs;
          };

          modules = [
            home-manager.nixosModules.home-manager
            ./nixos/system/hardware-configuration.nix
            ./nixos/system/configuration.nix
            inputs.amd-controller.module
          ];
        };
      };
      home-manager = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        modules = [
          ./nixos/nixpkgs/home.nix
        ];
      };
    };
}
