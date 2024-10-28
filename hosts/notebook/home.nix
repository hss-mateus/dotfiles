{
  programs.waybar.settings.mainBar.temperature.thermal-zone = 2;
  wayland.windowManager.hyprland.settings = {
    env = "GDK_SCALE,1.25";
    monitor = [
      "eDP-1,preferred,auto,1.25"
      "HDMI-A-1,preferred,auto,1"
    ];
  };
}
