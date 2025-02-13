{
  programs.waybar.settings.mainBar.temperature.thermal-zone = 2;
  wayland.windowManager.sway.config = {
    input."*".xkb_layout = "us,us(intl),br";

    output = {
      HDMI-A-1.pos = "1536 0";
      eDP-1 = {
        pos = "0 0";
        scale = "1.25";
      };
    };
  };
}
