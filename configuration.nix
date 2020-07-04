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
    };
  };

  console.colors = [ "282c34" "e06c75" "98c379" "e5c07b"
                     "61afef" "c678dd" "56b6c2" "abb2bf"
                     "545862" "e06c75" "98c379" "e5c07b"
                     "61afef" "c678dd" "56b6c2" "c8ccd4" ];

  nixpkgs.config.allowUnfree = true;

  environment = {
    shells = [ pkgs.bash pkgs.zsh ];

    sessionVariables.PATH = [ "/home/mt/.local/bin" ];

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
      tuir
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

      # Graphical
      dmenu
      feh
      firefox
      libsForQt5.vlc
      lxappearance
      nordic
      papirus-icon-theme
      polybar
      scrcpy
      ueberzug
      zathura
    ];
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    fira-code
    powerline-fonts
  ];

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "arrow";
      plugins = [ "git" ];
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
