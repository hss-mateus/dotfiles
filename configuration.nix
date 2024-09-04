{
  pkgs,
  inputs,
  inputs',
  config,
  user,
  hostname,
  ...
}:
{
  imports = with inputs; [
    ./hardware-configuration.nix
    disko.nixosModules.disko
    lanzaboote.nixosModules.lanzaboote
    stylix.nixosModules.stylix
    nixvim.nixosModules.nixvim
    catppuccin.nixosModules.catppuccin
    home-manager.nixosModules.home-manager
  ];

  environment.systemPackages = [ pkgs.sbctl ];

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  systemd.sleep.extraConfig = "HibernateDelaySec=1h";

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation = {
    docker.enable = true;

    oci-containers = {
      backend = "docker";

      containers.postgres = {
        image = "postgres:alpine";
        ports = [ "5432:5432" ];
        cmd = [
          "postgres"
          "-c"
          "statement_timeout=2000"
          "-c"
          "max_connections=200"
          "-c"
          "shared_buffers=2GB"
          "-c"
          "fsync=off"
          "-c"
          "full_page_writes=off"
        ];

        environment = {
          POSTGRES_USER = "postgres";
          POSTGRES_PASSWORD = "postgres";
        };

        volumes = [ "/var/lib/postgresql/data:/var/lib/postgresql/data" ];
      };
    };
  };

  services = {
    acpid.enable = true;
    blueman.enable = true;
    udisks2.enable = true;

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 50;
      };
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      catppuccin.enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.extraConfig = {
        disable-camera = {
          "wireplumber.profiles" = {
            main = {
              "monitor.libcamera" = "disabled";
            };
          };
        };
      };
    };

    openssh = {
      enable = true;
      settings.X11Forwarding = true;
    };

    keyd = {
      enable = true;
      keyboards.default.settings.main = {
        capslock = "esc";
        esc = "`";
      };
    };

    xserver.xkb = {
      layout = "us,us(intl)";
      model = "querty";
      options = "grp:alt_space_toggle";
    };

    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "suspend";
    };
  };

  programs = {
    hyprland.enable = true;
    fish.enable = true;

    nixvim = {
      enable = true;
      clipboard.register = "unnamedplus";
    };

    light = {
      enable = true;
      brightnessKeys.enable = true;
    };

    nh = {
      enable = true;
      clean.enable = true;
      flake =
        let
          home = config.users.extraUsers.${user}.home;
        in
        "${home}/dev/dotfiles";
    };
  };

  stylix = {
    enable = true;
    image = ./wallpaper.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor.size = 24;

    fonts = {
      monospace = {
        name = "Iosevka Comfy Motion Fixed";
        package = pkgs.iosevka-comfy.comfy-motion-fixed;
      };

      sansSerif = {
        name = "SF Pro";
        package = inputs'.apple-fonts.packages.sf-pro;
      };
    };

    targets.gtk.enable = false;
  };

  catppuccin.enable = true;

  nix = {
    package = pkgs.lix;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [
        "root"
        user
      ];
    };
  };

  users = {
    users.root.initialPassword = "123";

    extraUsers.${user} = {
      initialPassword = "123";
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "audio"
        "docker"
      ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs user;
    };

    users.${user}.imports = [
      ./home
      ./hosts/${hostname}/home.nix
    ];
  };

  console = {
    catppuccin.enable = true;
    useXkbConfig = true;
  };

  powerManagement.enable = true;
  system.stateVersion = "24.05";
}
