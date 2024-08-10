{ config, lib, pkgs, ... }:

{
  hardware.cpu.amd.updateMicrocode = true;
  networking.hostName = "desktop";
}
