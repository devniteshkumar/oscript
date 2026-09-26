#!/usr/bin/env bash
set -euo pipefail

git clone https://github.com/devniteshkumar/oscript.git oscript
mkdir -p nixos
cp -r ~/oscript/post-install/. ~/nixos/
rm -rf oscript

cd nixos
cp /etc/nixos/hardware-configuration.nix .
nix flake check
sudo nixos-rebuild dry-run --flake .#nixos
sudo nixos-rebuild switch --flake .#nixos
sudo reboot