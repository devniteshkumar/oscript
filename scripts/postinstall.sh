#!/usr/bin/env bash
set -euo pipefail

git clone https://github.com/devniteshkumar/oscript.git oscript
cp -r ~/oscript/post-install/dotfiles ~/dotfiles
rm -rf oscript

cd dotfiles
cp /etc/nixos/hardware-configuration.nix .
nix flake check
sudo nixos-rebuild dry-run --flake .#nixos
sudo nixos-rebuild switch --flake .#nixos
sudo reboot