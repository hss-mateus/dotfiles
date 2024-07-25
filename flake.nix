{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      nixvim,
      disko,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
        };

        modules = [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          nixvim.nixosModules.nixvim
          ./configuration.nix
          ./hardware-configuration.nix
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mt = import ./home;
            };
          }
        ];
      };
    };
}
