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
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "";
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

  nixConfig = {
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "doom-emacs-unstraightened.cachix.org-1:O5oOlRPnmQEvVaFyuMTmthCEooHbrg54WgSLR07tmg4="
      "hss-mateus.cachix.org-1:Mjcgtnt9/ogUvKNoybvBcXxS6GOceFJjkDISerRFD8Q="
    ];

    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://doom-emacs-unstraightened.cachix.org"
      "https://hss-mateus.cachix.org"
    ];
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
