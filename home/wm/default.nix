{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  services.hypridle = {
    enable = true;

    settings = {
      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];

      general = {
        lock_cmd = "hyprlock";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
      };
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
