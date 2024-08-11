{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-right = [
          "network"
          "custom/weather"
          "memory"
          "cpu"
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
          format-wifi = "  {essid} ({signalStrength}%)";
          tooltip-format-wifi = "󰕒  {bandwidthUpBytes}  󰇚  {bandwidthDownBytes}";
          format-disconnected = "󰅛  Disconnected";
          interval = 1;
        };

        temperature = {
          critical-threshold = 60;
          format = "{icon}  {temperatureC}°C";
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

        "custom/weather" = {
          return-type = "json";
          format = "{}";
          tooltip = true;
          interval = 3600;
          exec = "${pkgs.writeShellScript "weather" ''
            set -o pipefail

            for i in {1..5}
            do
              text=$(curl -s "https://wttr.in/?format=1" | sed -E "s/\s+/ /g")
              tooltip=$(curl -s "https://wttr.in/?format=4" | sed -E "s/\s+/ /g")

              if [[ $text != "" && $tooltip != "" ]]
              then
                echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
                exit
              fi

              sleep 2
            done

            echo '{"text": "error", "tooltip": "error"}'
          ''}";
        };

        cpu = {
          interval = 1;
          format = "  {usage:2d}%";
        };

        memory = {
          interval = 1;
          format = "  {:2d}%";
        };
      };
    };

    style = ''
      window#waybar {
        border-radius: 10px;
      }

      .module {
        margin-left: 3px;
      }

      label {
        font-family: "Iosevka Comfy Motion Fixed";
        font-size: 14px;
        color: @base05;
        text-shadow: none;
      }

      #workspaces button {
        padding: 0 5px;
      }

      #custom-weather {
        padding: 0 5px;
      }
    '';
  };
}
