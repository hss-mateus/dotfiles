{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    catppuccin.enable = true;

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
          "custom/weather"
          "memory"
          "cpu"
          "temperature"
          "pulseaudio"
          "hyprland/language"
          "battery"
          "network"
          "clock"
          "custom/notification"
          "tray"
        ];

        "hyprland/workspaces".format = "{id}";

        "hyprland/window" = {
          format = "{}";
          rewrite = {
            "(.*) — Mozilla Firefox" = "  $1";
          };
        };

        battery = {
          format = "{icon}  {capacity}%";
          format-icons = [
            "󱃍"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          tooltip-format = "{timeTo}\nCycles: {cycles}\nHealth: {health}%\nPower: {power}";
          interval = 1;
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
          format = "󰥔  {:%R}";
          tooltip-format = "<tt>{calendar}</tt>";
          interval = 1;

          calendar = {
            mode = "year";
            mode-mon-col = 3;
            format.today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };

          actions = {
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
            on-click-middle = "shift_reset";
          };
        };

        network = {
          format-wifi = "{icon} ";
          tooltip-format-wifi = "{icon}  {essid} ({signalStrength}%)  󰕒  {bandwidthUpBytes}  󰇚  {bandwidthDownBytes}";
          format-disconnected = "󰤭 ";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          interval = 1;
          on-click = "networkmanager_dmenu";
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
          exec = "${pkgs.wttrbar}/bin/wttrbar";
        };

        cpu = {
          interval = 1;
          format = "  {usage:2d}%";
        };

        memory = {
          interval = 1;
          format = "  {:2d}%";
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon} ";
          format-icons = {
            notification = "󰂚";
            none = "󰂜";
            dnd-notification = "󱏧";
            dnd-none = "󱏨";
          };
          return-type = "json";
          exec = "swaync-client --subscribe-waybar";
          on-click = "swaync-client --toggle-panel --skip-wait";
          on-click-right = "swaync-client --toggle-dnd --skip-wait";
          escape = true;
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
