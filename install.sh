#!/usr/bin/env sh

set -e

if [ "$1" = "-h" ]; then
   echo "usage: ./install.sh [system-name] [ssh-uri]"
   exit 0
fi

nix \
  --extra-experimental-features "flakes nix-command" \
  run github:nix-community/nixos-anywhere -- \
  --flake ".#${1:-desktop}" \
  "${2:-nixos@0.0.0.0}"
