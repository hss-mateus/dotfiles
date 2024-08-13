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

    doom-emacs = {
      url = "github:doomemacs/doomemacs";
      flake = false;
    };

    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    inputs: with inputs.nixpkgs.lib; {
      nixosConfigurations =
        let
          mkConfig = modules: {
            system = "x86_64-linux";

            specialArgs = {
              inherit inputs;
            };

            modules = [
              inputs.disko.nixosModules.disko
              inputs.home-manager.nixosModules.home-manager
              inputs.stylix.nixosModules.stylix
              inputs.nixvim.nixosModules.nixvim
              inputs.catppuccin.nixosModules.catppuccin
              ./configuration.nix
              ./hardware-configuration.nix
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;

                  extraSpecialArgs = {
                    inherit inputs;
                  };

                  users.mt.imports = [
                    ./home
                    inputs.catppuccin.homeManagerModules.catppuccin
                  ];
                };
              }
            ] ++ modules;
          };

          mkSystem = modules: nixosSystem (mkConfig modules);
        in
        {
          desktop = mkSystem [ ./hosts/desktop ];
          notebook = mkSystem [
            ./hosts/notebook
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
          ];
        };
    };
}
