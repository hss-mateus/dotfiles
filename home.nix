{ pkgs, ... }:

{
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
      default-bg                 = "#282c34";
      default-fg                 = "#353b45";
      statusbar-fg               = "#565c64";
      statusbar-bg               = "#3e4451";
      recolor-lightcolor         = "#282c34";
      recolor-darkcolor          = "#b6bdca";
      recolor                    = true;
      recolor-keephue            = false;
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
}
