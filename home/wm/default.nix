{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "light -O && light -S 10";
          on-resume = "light -I";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "${pkgs.writeShellScript "suspend" ''
            file=/sys/class/power_supply/AC/online

            if [ ! -f $file ] || [ "$(cat $file)" = "1" ]; then
              systemctl suspend
            else
              systemctl suspend-then-hibernate
            fi
          ''}";
        }
      ];
    };
  };

  programs = {
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
          path = "${../../wallpaper.png}";
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
  };
}
