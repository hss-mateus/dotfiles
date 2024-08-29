{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
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
                  mountpoint = "/";
                  mountOptions = [ "noatime" ];
                  extraArgs = [ "-f" ];
                  swap.swapfile.size = "20G";
                };
              };
            };
          };
        };
      };
    };
  };
}
