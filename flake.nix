{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

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

    determinate = {
      url = "github:DeterminateSystems/nix-src";
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

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    doom-emacs = {
      url = "github:marienz/nix-doom-emacs-unstraightened/lsp-use-plists";
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
      "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
      "desktop-cache:m3kl8CwqPx3WYk3LXlbR4cqyutVX2oQVGSxUbypQ56w="
    ];

    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://doom-emacs-unstraightened.cachix.org"
      "https://hss-mateus.cachix.org"
      "https://install.determinate.systems"
      "http://desktop.tail102bba.ts.net:5000"
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
