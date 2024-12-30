{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmake
    libtool
    ripgrep
  ];

  programs = {
    doom-emacs = {
      enable = true;
      doomDir = ./.;
      emacs = pkgs.emacs30-pgtk;
    };

    fd.enable = true;
  };
}
