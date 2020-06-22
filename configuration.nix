{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

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

  hardware = {
    pulseaudio.enable = true;

    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau libva libva-utils ];
    };
  };

  virtualisation.docker.enable = true;

  users = {
    defaultUserShell = pkgs.bash;
    users.mt = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "docker" ];
      password = "mt";
    };
  };

  console.colors = [ "2e3440" "88c0d0" "bf616a" "5e81ac"
                     "ebcb8b" "a3be8c" "d08770" "e5e9f0"
                     "4c566a" "81a1c1" "3b4252" "434c5e"
                     "d8dee9" "eceff4" "b48ead" "8fbcbb" ];

  nixpkgs.config.allowUnfree = true;

  environment = {
    shells = [ pkgs.bash pkgs.zsh ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      FZF_DEFAULT_COMMAND = "fd --type f --hidden --exclude .git";
    };

    shellAliases = {
      cat = "bat --theme=base16";
      ls = "exa --git --ignore-glob .git";
      v = "nvim";
      e = "emacsclient -nc";
    };

    systemPackages = with pkgs; [
      # General CLI tools
      alsaUtils
      bat
      coreutils
      curl
      exa
      fd
      fzf
      killall
      mesa
      neofetch
      neovim
      ranger
      ripgrep
      rsync
      scrot
      tmux
      unzip
      wget
      wmname
      ytop

      # Development
      emacs
      docker-compose
      git
      ghc
      guile
      jetbrains.idea-ultimate
      jdk11
      nodejs
      polyml
      stack

      # Graphical
      alacritty
      dmenu
      feh
      firefox
      libsForQt5.vlc
      lxappearance
      nordic
      papirus-icon-theme
      polybar
      scrcpy
      zathura
    ];
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    hasklig
    powerline-fonts
  ];

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "theunraveler";
      plugins = [ "git" "stack" ];
    };
  };

  services = {
    emacs.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "ati" ];
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

    redshift = {
      enable = true;
      temperature.day = 4500;
      temperature.night = 4500;
    };
  };

  home-manager.users.mt = import /etc/nixos/home;
}
