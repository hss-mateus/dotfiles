{ inputs, config, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
    "${inputs.nixos-hardware}/common/gpu/intel/tiger-lake"
  ];

  nix = {
    distributedBuilds = true;

    buildMachines = [
      {
        hostName = "desktop.${config.networking.domain}";
        sshUser = "remotebuild";
        sshKey = "/root/.ssh/remotebuild";
        system = "x86_64-linux";
        supportedFeatures = [ "nixos-test" "big-parallel" "kvm" ];
        protocol = "ssh-ng";
        maxJobs = 16;
      }
    ];
  };
}
