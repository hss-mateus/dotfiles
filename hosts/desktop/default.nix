{ inputs, ... }:
{
  imports = with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-cpu-amd-zenpower
    common-gpu-amd
    common-pc
    common-pc-ssd
  ];

  services.nix-serve = {
    enable = true;
    secretKeyFile = "/root/cache.key";
  };

  nix.settings.trusted-users = [ "remotebuild" ];

  users = {
    extraUsers.remotebuild = {
      isNormalUser = true;
      createHome = false;
      group = "remotebuild";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3xDzHT2egMLstQJCOQ4t4TT0srrGBUkkKqbhvzJ7od root@notebook"
      ];
    };

    extraGroups.remotebuild = { };
  };
}
