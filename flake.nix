{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
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

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    catppuccin.url = "github:catppuccin/nix";
    catppuccin-swaync.url = "file+https://github.com/catppuccin/swaync/releases/latest/download/mocha.css";
  };

  outputs =
    { flakelight, ... }:
    flakelight ./. (
      { lib, ... }:
      {
        nixpkgs.config.allowUnfree = true;

        nixosConfigurations = lib.mapAttrs (hostname: _: {
          system = "x86_64-linux";

          specialArgs = {
            user = "mt";
          };

          modules = [
            ./configuration.nix
            ./hardware-configuration.nix
            ./hosts/${hostname}
          ];
        }) (builtins.readDir ./hosts);
      }
    );
}
