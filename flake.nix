{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    flakelight.url = "github:nix-community/flakelight";
    disko.url = "github:nix-community/disko";
    lanzaboote.url = "github:nix-community/lanzaboote";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    catppuccin.url = "github:catppuccin/nix";

    doom-emacs = {
      url = "github:doomemacs/doomemacs";
      flake = false;
    };

    catppuccin-swaync = {
      url = "file+https://github.com/catppuccin/swaync/releases/latest/download/mocha.css";
      flake = false;
    };

    sf-pro = {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
      flake = false;
    };

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.sf-pro.follows = "sf-pro";
    };
  };

  outputs =
    inputs:
    inputs.flakelight ./. {
      nixpkgs.config.allowUnfree = true;

      nixosConfigurations = builtins.mapAttrs (hostname: _: {
        system = "x86_64-linux";
        specialArgs.user = "mt";

        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./hosts/${hostname}
        ];
      }) (builtins.readDir ./hosts);
    };
}
