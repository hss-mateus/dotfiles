{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    catppuccin.url = "github:catppuccin/nix";
    catppuccin-swaync.url = "file+https://github.com/catppuccin/swaync/releases/latest/download/mocha.css";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      mkSystems = nixpkgs.lib.mapAttrs (
        hostName: modules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit hostName inputs;
            user = "mt";
          };

          modules =
            with inputs;
            [
              disko.nixosModules.disko
              home-manager.nixosModules.home-manager
              stylix.nixosModules.stylix
              nixvim.nixosModules.nixvim
              catppuccin.nixosModules.catppuccin
              ./configuration.nix
              ./hardware-configuration.nix
              ./hosts/${hostName}
              lix-module.nixosModules.default
            ]
            ++ modules;
        }
      );
    in
    with inputs.nixos-hardware.nixosModules;
    {
      nixosConfigurations = mkSystems {
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
          "${inputs.nixos-hardware}/common/gpu/intel/tiger-lake"
        ];
      };
    };
}
