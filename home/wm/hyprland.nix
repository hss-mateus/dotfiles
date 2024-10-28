{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    grim
    satty
    slurp
    swaynotificationcenter
    wl-clipboard
    xdg-desktop-portal-hyprland
  ];

  xdg.configFile."swaync/style.css".source = inputs.catppuccin-swaync;

  wayland.windowManager.hyprland = {
    enable = true;
    catppuccin.enable = true;

    settings = {
      debug.disable_logs = false;
      monitor = lib.mkDefault ",preferred,auto,auto";
      xwayland.force_zero_scaling = true;

      "$terminal" = "alacritty";
      "$fileManager" = "alacritty -e ranger";
      "$menu" = "fuzzel --dpi-aware=yes";
      "$browser" = "firefox";
      "$screenshot" = "grim -g \"$(slurp)\" - | satty --filename - --copy-command wl-copy";

      exec-once = [
        "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1"
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        "swaync"
        "waybar"
      ];

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
        drop_shadow = false;
        blur.enabled = false;
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
        kb_options = "grp:alt_space_toggle";
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

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      windowrulev2 = [ "suppressevent maximize, class:.*" ];
    };
  };
}
