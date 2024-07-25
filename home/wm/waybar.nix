{ ... }:

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
      window#waybar {
        border-radius: 10px;
      }

      .module {
        margin-left: 3px;
      }

      label {
        font-family: "Iosevka Comfy Motion Fixed";
        font-size: 14px;
      }

      #workspaces button {
        padding: 0 5px;
      }
    '';
  };
}
