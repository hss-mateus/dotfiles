#!/usr/bin/env sh

sudo nix \
  --extra-experimental-features "flakes nix-command" \
  run github:nix-community/disko#disko-install -- \
  --flake "github:hss-mateus/dotfiles#${HOST:-desktop}" \
  --write-efi-boot-entries \
  --disk main ${DISK:-/dev/nvme0n1}
