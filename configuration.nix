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
  imports = (
    builtins.map (mod: inputs.${mod}.nixosModules.${mod}) [
      "disko"
      "lanzaboote"
      "stylix"
      "catppuccin"
      "home-manager"
    ]
    ++ [ inputs.determinate.nixosModules.default ]
  );

  boot.plymouth.enable = true;

  environment.systemPackages = [ pkgs.sbctl ];

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  systemd.sleep.extraConfig = "HibernateDelaySec=1h";

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";

  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
  };

  virtualisation = {
    docker.enable = true;
    oci-containers.backend = "docker";
  };

  services = {
    acpid.enable = true;
    blueman.enable = true;
    udisks2.enable = true;
    tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = "client";
    };

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

    logind.settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "suspend";
    };

    postgresql = {
      enable = true;
      enableJIT = true;
      ensureUsers = [
        {
          name = user;
          ensureClauses.createdb = true;
        }
      ];
      settings.max_connections = 200;
    };
  };

  programs = {
    fish = {
      enable = true;
      shellInit = "set fish_greeting";
    };

    starship = {
      enable = true;
      interactiveOnly = true;
    };

    light.enable = true;
    neovim.enable = true;

    nh = {
      enable = true;
      flake =
        let
          home = config.users.extraUsers.${user}.home;
        in
        "${home}/dev/dotfiles";
    };

    sway = {
      enable = true;
      package = pkgs.swayfx;
    };
  };

  stylix = {
    enable = true;
    image = ./wallpaper.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    cursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 24;
    };

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

    targets = {
      gtk.enable = false;
      plymouth.enable = false;
    };
  };

  catppuccin.enable = true;

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    optimise.automatic = true;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      eval-cores = 0;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [
        "root"
        "nix-ssh"
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
        "dialout"
      ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs inputs' user;
    };

    users.${user}.imports = [
      ./home
      ./hosts/${hostname}/home.nix
    ];
  };

  console.useXkbConfig = true;
  powerManagement.enable = true;
  system.stateVersion = "24.05";
}
