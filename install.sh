#!/usr/bin/env sh

if [ "$1" = "-h" ]; then
   echo "usage: ./install.sh [system-name] [ssh-url]"
   exit 0
fi

nix \
  --extra-experimental-features "flakes nix-command" \
  run github:nix-community/nixos-anywhere -- \
  --build-on-remote \
  --print-build-logs \
  --flake "github:hss-mateus/dotfiles#${1:-desktop}" \
  "${2:-nixos@0.0.0.0}"
