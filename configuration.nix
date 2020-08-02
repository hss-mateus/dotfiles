{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix <home-manager/nixos> ];

  system.stateVersion = "20.03";
  boot.loader.grub.device = "/dev/sda";

  time.timeZone = "America/Sao_Paulo";

  sound.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
        vaapiVdpau
        libva
        libva-utils
      ];
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.mt = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  environment = {
    sessionVariables.PATH = [ "/home/mt/.local/bin" ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    shellAliases = {
      cat = "bat --theme=base16";
      ls = "exa --git --ignore-glob .git";
      v = "nvim";
      e = "emacsclient -nw";
    };

    systemPackages = with pkgs; [
      # General CLI tools
      bat
      curl
      exa
      fd
      neovim
      pfetch
      ranger
      ripgrep
      scrot
      unzip
      wget
      ytop

      # Development
      emacs
      git
      ghc
      hlint
      stack

      # Graphical
      dmenu
      feh
      firefox
      libsForQt5.vlc
      scrcpy
      signal-desktop
      xmobar
      zathura
    ];
  };

  fonts.fonts = with pkgs; [ hasklig powerline-fonts ];

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "lambda";
      plugins = [ "git" ];
    };
  };

  services.emacs.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "ati" ];
    xkbOptions = "caps:escape";
    autoRepeatDelay = 250;
    autoRepeatInterval = 25;

    displayManager.lightdm = {
      enable = true;
      autoLogin.enable = true;
      autoLogin.user = "mt";
    };

    windowManager.xmonad.enable = true;
  };

  home-manager.users.mt = import ./home.nix;
}
