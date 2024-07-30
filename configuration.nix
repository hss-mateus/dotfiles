{ pkgs, inputs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

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

        volumes = ["/var/lib/postgresql/data:/var/lib/postgresql/data"];
      };
    };
  };

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };

  programs = {
    hyprland.enable = true;
    fish.enable = true;
    nixvim.enable = true;
  };

  stylix = {
    enable = true;
    image = ./wallpaper.png;
    polarity = "light";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-light.yaml";
    cursor.size = 24;

    fonts = {
      monospace = {
        name = "Iosevka Comfy Motion Fixed";
        package = pkgs.iosevka-comfy.comfy-motion-fixed;
      };

      sansSerif = {
        name = "SF Pro";
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro;
      };
    };
  };

  nix = {
    gc.automatic = true;
    settings = {
      trusted-users = [ "@wheel" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  users = {
    users.mt = {
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

  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "24.05";
}
