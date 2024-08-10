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
    inputs: with inputs.nixpkgs.lib; {
      nixosConfigurations =
        let
          mkConfig = host: {
            system = "x86_64-linux";

            specialArgs = {
              inherit inputs;
            };

            modules = [
              inputs.disko.nixosModules.disko
              inputs.home-manager.nixosModules.home-manager
              inputs.stylix.nixosModules.stylix
              inputs.nixvim.nixosModules.nixvim
              ./configuration.nix
              ./hardware-configuration.nix
              ./hosts/${host}
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.mt = import ./home;
                };
              }
            ];
          };
        in
          mapAttrs (host: _: nixosSystem (mkConfig host)) (builtins.readDir ./hosts);
    };
}
