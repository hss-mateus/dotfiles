{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "20.03";

  boot.loader.grub.device = "/dev/sda";

  networking.wireless = {
    enable = true;
    networks.Slowmo.psk = "1148190449";
  };

  time.timeZone = "America/Sao_Paulo";

  location = {
    latitude = 0.0;
    longitude = 0.0;
  };

  sound.enable = true;

  hardware.pulseaudio.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.mt = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      password = "mt";
    };
  };

  console.colors = [ "2e3440" "88c0d0" "bf616a" "5e81ac"
                     "ebcb8b" "a3be8c" "d08770" "e5e9f0"
                     "4c566a" "81a1c1" "3b4252" "434c5e"
                     "d8dee9" "eceff4" "b48ead" "8fbcbb" ];

  nixpkgs.config.allowUnfree = true;

  environment = {
    shells = with pkgs; [ bash zsh ];
    systemPackages = with pkgs; [
      alacritty
      alsaUtils
      bat
      curl
      coreutils
      dmenu
      emacs
      exa
      fd
      feh
      firefox
      ghc
      git
      jetbrains.idea-ultimate
      jdk11
      killall
      libsForQt5.vlc
      lxappearance
      mesa
      neofetch
      neovim
      nodejs
      nordic
      papirus-icon-theme
      polybar
      polyml
      ranger
      ripgrep
      rsync
      scrcpy
      scrot
      tmux
      unzip
      wget
      wmname
      ytop
      zathura
    ];
  };

  fonts.fonts = with pkgs; [ dejavu_fonts hasklig powerline-fonts ];

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    ohMyZsh.enable = true;
    syntaxHighlighting.enable = true;
  };

  services = {
    emacs.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "ati" ];
      defaultDepth = 24;
      xkbOptions = "caps:escape";
      autoRepeatDelay = 250;
      autoRepeatInterval = 25;
      windowManager.bspwm.enable = true;
      displayManager.lightdm = {
        enable = true;
        autoLogin.enable = true;
        autoLogin.user = "mt";
      };
    };

    picom = {
      enable = true;
      backend = "xr_glx_hybrid";
      fade = true;
      fadeDelta = 4;
      fadeSteps = [ "0.03" "0.03" ];
      vSync = true;
    };

    redshift = {
      enable = true;
      temperature.day = 4500;
      temperature.night = 4500;
    };
  };
}
