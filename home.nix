{ pkgs, ... }:

let
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = "https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz";
  }) { doomPrivateDir = ./doom-emacs; };
in {
  home.stateVersion = "20.03";

  programs.git = {
    enable = true;
    userName = "hss-mateus";
    userEmail = "hss-mateus@tuta.io";
    extraConfig.credential.helper = "store";
  };

  programs.zathura = {
    enable = true;
    options = {
      default-bg         = "#282c34";
      default-fg         = "#353b45";
      statusbar-fg       = "#565c64";
      statusbar-bg       = "#3e4451";
      recolor-lightcolor = "#282c34";
      recolor-darkcolor  = "#b6bdca";
      recolor            = true;
      recolor-keephue    = false;
    };
  };

  xsession.enable = true;

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
  };

  xsession.windowManager.xmonad = {
    enable = true;
    config = pkgs.writeText "xmonad.hs" ''
      import XMonad

      main = launch defaultConfig
             { modMask = mod4Mask
             , terminal = "st"
             , focusedBorderColor = "#e06c75"
             , normalBorderColor = "#abb2bf"
             }
    '';
  };

  home.packages = [ doom-emacs ];
  home.file.".emacs.d/init.el".text = ''(load "default.el")'';
}
