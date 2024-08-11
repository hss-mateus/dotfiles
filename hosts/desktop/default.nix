{ ... }:
{
  hardware.cpu.amd.updateMicrocode = true;
  networking.hostName = "desktop";
  home-manager.users.mt.programs.waybar.settings.mainBar.temperature.hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
}
