{ pkgs, ... }:

{
  home.packages = with pkgs; [
    graphviz
    ripgrep
  ];

  programs = {
    doom-emacs = {
      enable = true;
      doomDir = ./.;
      emacs = pkgs.emacs30-pgtk;
      experimentalFetchTree = true;
      extraPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];
    };

    fd.enable = true;
  };

  services.emacs.enable = true;
}
