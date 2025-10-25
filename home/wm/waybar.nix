{ pkgs, config, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;

        modules-left = [
          "sway/mode"
          "sway/workspaces"
          "sway/window"
        ];

        modules-right = [
          "custom/weather"
          "temperature"
          "pulseaudio"
          "sway/language"
          "battery"
          "clock"
          "custom/notification"
          "tray"
        ];

        "sway/window" = {
          format = "{}";
          rewrite = {
            "(.*) — LibreWolf" = "󰖟  $1";
          };
        };

        battery = {
          format = " {icon}  {capacity}%";
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
        };

        "sway/language".format = " 󰌌  {short} {variant}";

        tray = {
          icon-size = 18;
          spacing = 15;
        };

        clock = {
          format = " 󰥔  {:%R}";
          tooltip-format = "<tt>{calendar}</tt>";

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

        temperature = {
          critical-threshold = 60;
          format = " {icon}  {temperatureC}°C";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        pulseaudio = {
          format = " {icon}  {volume}";
          format-bluetooth = " 󰂰  {volume}";
          format-muted = "   0";
          scroll-step = 5;
          format-icons.default = [
            ""
            ""
          ];
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        "custom/weather" = {
          return-type = "json";
          format = "{}°C";
          tooltip = true;
          interval = 3600;
          exec = "${pkgs.wttrbar}/bin/wttrbar --location jundiai";
        };

        "custom/notification" =
          let
            swaync = "${config.services.swaync.package}/bin/swaync-client";
          in
          {
            tooltip = false;
            format = " {icon}  ";
            format-icons = {
              notification = "󰂚";
              none = "󰂜";
              dnd-notification = "󱏧";
              dnd-none = "󱏨";
            };
            return-type = "json";
            exec = "${swaync} --subscribe-waybar";
            on-click = "${swaync} --toggle-panel --skip-wait";
            on-click-right = "${swaync} --toggle-dnd --skip-wait";
            escape = true;
          };
      };
    };

    style = ''
      window#waybar {
        border-radius: 10px;
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
