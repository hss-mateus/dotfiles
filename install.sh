#!/usr/bin/env sh

sudo nix \
  --extra-experimental-features "flakes nix-command" \
  run github:nix-community/disko#disko-install -- \
  --flake "github:hss-mateus/dotfiles#nixos" \
  --write-efi-boot-entries \
  --disk main /dev/nvme0n1
