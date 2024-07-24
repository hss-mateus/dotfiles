{ config, pkgs, ... }:

{
  home = {
    username = "mt";
    homeDirectory = "/home/mt";
    preferXdgDirectories = true;
    stateVersion = "24.11";

    keyboard = {
      layout = "us,us(intl)";
      model = "qwerty";
      options = [
        "grp:alt_space_toggle"
        "caps:escape"
      ];
    };

    packages = with pkgs; [
      cmake
      editorconfig-core-c
      emacs-lsp-booster
      gnumake
      grim
      libtool
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      networkmanager_dmenu
      nixfmt-rfc-style
      pavucontrol
      ranger
      ripgrep
      rofi-wayland
      satty
      slurp
      swaynotificationcenter
      udiskie
      wl-clipboard
      xdg-desktop-portal-hyprland
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      DOOMDIR = "${config.xdg.configHome}/doom/config";
      DOOMLOCALDIR = "${config.xdg.configHome}/doom/local";
      DOOMPROFILELOADFILE = "${config.xdg.configHome}/doom/local/load.el";
    };

    sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];

    shellAliases = {
      cat = "bat";
      ls = "eza --git --ignore-glob .git";
      v = "nvim";
    };
  };

  xdg = {
    enable = true;

    configFile =
      with config.xdg;
      let
        mkDoomScript =
          {
            name ? "doom-sync",
            text ? "${configHome}/emacs/bin/doom --force sync",
          }:
          let
            app = pkgs.writeShellApplication {
              inherit name text;
              runtimeInputs = config.home.packages ++ config.home.sessionPath;
              runtimeEnv = {
                inherit (config.home.sessionVariables) DOOMDIR DOOMLOCALDIR DOOMPROFILELOADFILE;
              };
            };
          in
          "${app}/bin/${name}";
      in
      {
        emacs = {
          source = builtins.fetchGit {
            url = "https://github.com/doomemacs/doomemacs.git";
            rev = "f5b3958331cebf66383bf22bdc8b61cd44eca645";
          };

          onChange = mkDoomScript {
            name = "doom-repo-setup";
            text = ''
              if [ ! -d "$DOOMLOCALDIR" ]; then
                ${configHome}/emacs/bin/doom install --force
              else
                ${configHome}/emacs/bin/doom --force sync -u
              fi
            '';
          };
        };

        "doom/config/init.el" = {
          source = ./emacs/init.el;
          onChange = mkDoomScript { };
        };

        "doom/config/packages.el" = {
          source = ./emacs/packages.el;
          onChange = mkDoomScript { };
        };

        "doom/config/config.el".source = ./emacs/config.el;

        "networkmanager-dmenu/config.ini".text = ''
          [dmenu]
          dmenu_command = rofi -dmenu
        '';
      };
  };

  services.hypridle = {
    enable = true;

    settings = {
      listener.timeout = 300;

      general = {
        lock_cmd = "hyprlock";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
      };
    };
  };

  programs = {
    alacritty = {
      enable = true;

      settings = {
        mouse.hide_when_typing = true;
        window.dynamic_padding = true;

        keyboard.bindings = [
          {
            action = "IncreaseFontSize";
            key = "Equals";
            mods = "Control";
          }
          {
            action = "DecreaseFontSize";
            key = "Minus";
            mods = "Control";
          }
          {
            action = "ResetFontSize";
            key = "Key0";
            mods = "Control";
          }
          {
            action = "ScrollPageUp";
            key = "K";
            mods = "Control|Shift";
          }
          {
            action = "ScrollPageDown";
            key = "J";
            mods = "Control|Shift";
          }
        ];
      };
    };

    bat.enable = true;
    bottom.enable = true;

    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    emacs.enable = true;

    eza = {
      enable = true;
      icons = true;
      git = true;
      extraOptions = [
        "--ignore-glob"
        ".git"
      ];
    };

    fd.enable = true;
    firefox.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = "set fish_greeting";
      plugins = [
        {
          name = "plugin-git";
          src = builtins.fetchGit {
            url = "https://github.com/jhillyerd/plugin-git.git";
            rev = "6336017c16c02b1e9e708dd4eb233e66a18b62fe";
          };
        }
      ];
    };

    git = {
      enable = true;
      userName = "hss-mateus";
      userEmail = "hss-mateus@pm.me";

      difftastic = {
        enable = true;
        display = "side-by-side-show-both";
      };

      extraConfig = {
        pull.ff = true;
        merge.conflictstyle = "diff3";
      };
    };

    git-credential-oauth.enable = true;

    hyprlock = {
      enable = true;

      settings = {
        input-field = {
          monitor = "";
          size = "200, 50";
          outline_thickness = -1;
          dots_center = false;
          dots_rounding = -1;
          inner_color = "rgb(255, 255, 255)";
          font_color = "rgb(0, 0, 0)";
          fade_on_empty = false;
          placeholder_text = "";
          hide_input = false;
          rounding = -1;
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_size = 9;
          shadow_boost = 0.5;
        };

        background = {
          monitor = "";
          path = "${./wallpaper.png}";
          color = "rgba(25, 20, 20, 1.0)";
          blur_passes = 1;
          blur_size = 10;
          noise = 0.1;
        };

        label = {
          monitor = "";
          text = "cmd[update:1000] echo \"<span foreground='##ffffff'>$(date +'%A, %B %d - %H:%M')</span>\"";
          text_align = "center";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 25;
          font_family = "SF Pro";
          rotate = 0;
          position = "0, 80";
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_size = 9;
          shadow_boost = 0.5;
        };
      };
    };

    newsboat = {
      enable = true;
      urls = builtins.map (url: { inherit url; }) [
        "https://lobste.rs/rss"
        "https://rsshub.app/github/trending/daily"
        "https://cprss.s3.amazonaws.com/rubyweekly.com.xml"
        "https://ferd.ca/feed.rss"
        "http://www.rubyflow.com/rss"
        "https://blog.bigbinary.com/feed.xml"
        "https://rubyonrails.org/feed.xml"
        "https://lwn.net/headlines/newrss"
        "https://blog.arkency.com/feed.xml"
        "https://esoteric.codes/rss"
        "https://shopify.engineering/blog.atom"
      ];

      extraConfig = ''
        color listfocus        black blue bold
        color listfocus_unread black blue bold
        color info             black blue bold
      '';
    };

    starship.enable = true;

    waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 27;

          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];

          modules-right = [
            "network"
            "temperature"
            "pulseaudio"
            "hyprland/language"
            "clock"
            "tray"
          ];

          "hyprland/workspaces".format = "{id}";

          "hyprland/window" = {
            format = "{}";
            rewrite = {
              "(.*) — Mozilla Firefox" = "  $1";
            };
          };

          "hyprland/language" = {
            format = "󰌌  {}";
            format-en = "en";
            format-en-intl = "en-intl";
          };

          tray = {
            icon-size = 18;
            spacing = 15;
          };

          clock = {
            format = "  {:%a %b %e  󰥔  %R}";
            interval = 30;
          };

          network = {
            interface = "wlp3s0";
            format-wifi = "󰕒  {bandwidthUpBytes}  󰇚  {bandwidthDownBytes}    {essid} ({signalStrength}%)";
            format-disconnected = "󰅛  Disconnected";
            interval = 1;
          };

          temperature = {
            hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
            critical-threshold = 60;
            format = "{icon} {temperatureC}°C";
            format-icons = [
              ""
              ""
              ""
            ];
          };

          pulseaudio = {
            format = "{icon}  {volume}";
            format-bluetooth = "󰂰  {volume}";
            format-muted = "  0";
            scroll-step = 5;
            format-icons.default = [
              ""
              ""
            ];
            on-click = "pavucontrol";
          };
        };
      };

      style = ''
        @define-color shadow-color rgba(0,0,0,0.5);

        * {
          border: none;
          border-radius: 0;
          min-height: 0;
          font-family: "Iosevka Comfy Motion Fixed";
          font-size: 13px;
          color: @base07;
          text-shadow: 0px 0px 1px @shadow-color;
          border-radius: 10px;
        }

        window#waybar {
          background-color: transparent;
        }

        .module {
          background-color: @base01;
          padding: 0px 10px;
          box-shadow: 0px 0px 2px 0px @shadow-color;
          margin-bottom: 5px;
          margin-left: 3px;
        }

        label {
          background-color: @base01;
        }

        #workspaces {
          background-color: transparent;
          margin-left: 0;
          margin-right: 0;
          padding: 0;
          box-shadow: none;
        }

        #workspaces button {
          background-color: @base01;
          margin: 0;
          margin-right: 3px;
          padding: 0 5px;
          box-shadow: 0px 0px 2px 0px @shadow_color;
          border-bottom: solid 2px transparent;
        }

        #workspaces button.active {
          border-bottom: solid 2px @base0C;
        }

        #workspaces button.urgent {
          border-bottom: solid 2px @base08;
        }
      '';
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = ",preferred,auto,auto";

      "$terminal" = "alacritty";
      "$fileManager" = "alacritty -e ranger";
      "$menu" = "rofi -show run";
      "$browser" = "firefox";
      "$screenshot" = "grim -g \"$(slurp)\" - | satty --filename - --copy-command wl-copy";

      exec-once = "swaync & udiskie & waybar &";

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 0;
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 0.8;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;

        blur = {
          enabled = true;
          size = 10;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 2, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "us,us(intl)";
        kb_options = "grp:alt_space_toggle,caps:escape";
        repeat_rate = 30;
        repeat_delay = 200;
        follow_mouse = 1;
        sensitivity = 0;
      };

      "$mainMod" = "ALT";

      unbind = [ "SUPER, space" ];

      bind = [
        "$mainMod, return, exec, $terminal"
        "$mainMod SHIFT, C, killactive,"
        "$mainMod SHIFT, Q, exit,"
        "$mainMod, B, exec, firefox"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, S, exec, $screenshot"
        "$mainMod, P, exec, $menu"

        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrulev2 = [ "suppressevent maximize, class:.*" ];
    };
  };
}
