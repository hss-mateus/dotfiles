{ user, ... }:
{
  boot.kernelParams = [ "resume_offset=533760" ];

  home-manager.users.${user} = {
    programs.waybar.settings.mainBar.temperature.thermal-zone = 2;
    wayland.windowManager.hyprland.settings.monitor = ",preferred,auto,1.25";
  };
}
