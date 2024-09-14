{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    resumeDevice = "/dev/dm-0";
    kernelParams = [ "resume_offset=533760" ];
    loader.efi.canTouchEfiVariables = true;

    initrd = {
      systemd.enable = true;
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

  hardware = {
    enableAllFirmware = true;
    firmware = [ pkgs.linux-firmware ];
    bluetooth.enable = true;
  };

  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            luks = {
              size = "100%";

              content = {
                type = "luks";
                name = "crypted";

                settings = {
                  allowDiscards = true;
                  bypassWorkqueues = true;
                };

                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];

                  subvolumes = {
                    "/" = {
                      mountpoint = "/";
                      mountOptions = [ "noatime" ];
                    };

                    "/swap" = {
                      mountpoint = "/swap";
                      mountOptions = [
                        "noatime"
                        "nodatacow"
                      ];
                      swap.swapfile.size = "20G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
