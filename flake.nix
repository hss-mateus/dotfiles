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
    catppuccin-swaync = {
      url = "file+https://github.com/catppuccin/swaync/releases/latest/download/mocha.css";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      disko,
      home-manager,
      stylix,
      nixvim,
      catppuccin,
      nixos-hardware,
      ...
    }@inputs:
    {
      nixosConfigurations =
        let
          mkSystems = nixpkgs.lib.mapAttrs (
            name: modules:
            nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";

              specialArgs = {
                inherit inputs;
              };

              modules = [
                disko.nixosModules.disko
                home-manager.nixosModules.home-manager
                stylix.nixosModules.stylix
                nixvim.nixosModules.nixvim
                catppuccin.nixosModules.catppuccin
                ./configuration.nix
                ./hardware-configuration.nix
                ./hosts/${name}
                {
                  networking.hostName = name;
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;

                    extraSpecialArgs = {
                      inherit inputs;
                    };

                    users.mt.imports = [
                      ./home
                      catppuccin.homeManagerModules.catppuccin
                    ];
                  };
                }
              ] ++ modules;
            }
          );
        in
        with nixos-hardware.nixosModules;
        mkSystems {
          desktop = [
            common-cpu-amd
            common-cpu-amd-pstate
            common-cpu-amd-zenpower
            common-gpu-amd
            common-pc
            common-pc-ssd
          ];

          notebook = [
            lenovo-thinkpad-e14-intel
            "${nixos-hardware}/common/gpu/intel/tiger-lake"
          ];
        };
    };
}
