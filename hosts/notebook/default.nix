{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
    "${inputs.nixos-hardware}/common/gpu/intel/tiger-lake"
  ];
}
