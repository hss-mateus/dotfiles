{ ... }:
{
  hardware.cpu.intel.updateMicrocode = true;
  networking.hostName = "notebook";
  home-manager.users.mt = {
    programs.waybar.settings.mainBar.temperature.thermal-zone = 2;
  };
}
