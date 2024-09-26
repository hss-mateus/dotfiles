{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakelight.url = "github:nix-community/flakelight";
    disko.url = "github:nix-community/disko";
    lanzaboote.url = "github:nix-community/lanzaboote";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
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
