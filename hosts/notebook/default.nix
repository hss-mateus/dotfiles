{ ... }:
{
  networking.hostName = "notebook";
  home-manager.users.mt = {
    programs.waybar.settings.mainBar.temperature.thermal-zone = 2;
    wayland.windowManager.hyprland.settings.monitor = ",preferred,auto,1.25";
  };
}
