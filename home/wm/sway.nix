{
  lib,
  pkgs,
  config,
  ...
}:

{
  home.packages = with pkgs; [
    sway-contrib.grimshot
    satty
    wl-clipboard
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    extraConfig = ''
      shadows enable
      corner_radius 10
      default_dim_inactive 0.1
    '';

    config = {
      terminal = "alacritty";
      menu = "fuzzel --dpi-aware=yes";
      bars = [ ];

      startup = [
        { command = "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1"; }
        { command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
        { command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
        { command = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
        { command = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
      ];

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";

          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

          "XF86MonBrightnessUp" = "exec light -A 10";
          "XF86MonBrightnessDown" = "exec light -U 10";

          "${mod}+b" = "exec firefox";
          "${mod}+e" = "exec alacritty -e yazi";
          "${mod}+s" = ''exec grimshot save anything - | satty -o "${config.xdg.userDirs.pictures}/%s.png" --filename - --copy-command wl-copy'';
        };

      window = {
        titlebar = false;
        border = 0;
      };

      floating.titlebar = false;

      input = {
        "*" = {
          repeat_rate = "30";
          repeat_delay = "200";
          xkb_layout = lib.mkDefault "us,us(intl)";
          xkb_options = "grp:alt_space_toggle";
        };

        "type:touchpad" = {
          tap = "enabled";
          tap_button_map = "lrm";
          dwt = "enabled";
          dwtp = "enabled";
        };
      };

      output = {
        HDMI-A-1.pos = "1536 0";

        "Samsung Electric Company SAMSUNG 0x01000E00" = {
          scale = "2";
          mode = "3840x2160@60Hz";
        };
      };
    };
  };
}
