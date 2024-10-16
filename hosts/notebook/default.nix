{
  inputs,
  flake,
  user,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
    "${inputs.nixos-hardware}/common/gpu/intel/tiger-lake"
  ];

  nix = {
    distributedBuilds = true;
    buildMachines = [
      (
        let
          host = flake.outputs.nixosConfigurations.desktop.config;
        in
        {
          hostName = host.ipv4Address;
          sshUser = user;
          system = host.nixpkgs.system;
          maxJobs = 16;
          supportedFeatures = host.nix.settings.system-features;
        }
      )
    ];
  };
}
