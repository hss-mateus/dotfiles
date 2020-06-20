{ pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./bspwm.nix
    ./neovim.nix
    ./polybar.nix
    ./sxhkd.nix
    ./tmux.nix
    ./zathura.nix
  ];

  home.stateVersion = "20.03";

  programs.git = {
    enable = true;
    userName = "hss-mateus";
    userEmail = "hss-mateus@tuta.io";
    extraConfig.credential.helper = "store";
  };

  xsession.enable = true;

  services.picom = {
    enable = true;
    experimentalBackends = true;
    backend = "xrender";
    vSync = true;
  };
}
