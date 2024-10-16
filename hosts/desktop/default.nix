{
  inputs,
  config,
  lib,
  ...
}:
{
  options.ipv4Address = lib.mkOption { default = "192.168.0.151"; };

  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-cpu-amd-zenpower
    common-gpu-amd
    common-pc
    common-pc-ssd
  ];

  config.networking.interfaces.wlp3s0.ipv4.addresses = [
    {
      address = config.ipv4Address;
      prefixLength = 24;
    }
  ];
}
