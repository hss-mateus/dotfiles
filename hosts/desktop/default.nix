{ user, ... }:
{
  home-manager.users.${user}.programs.waybar.settings.mainBar.temperature.hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
}
