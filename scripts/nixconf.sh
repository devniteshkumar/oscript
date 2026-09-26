#!/usr/bin/env bash
set -euo pipefail

# Run from the NixOS installer after partitioning and subvolume setup.
# Assumes /mnt is mounted as the target filesystem and /mnt/boot is mounted as EFI.
sudo nixos-generate-config --root /mnt
REPO_DIR="$(mktemp -d)"
curl -fL --retry 3 https://github.com/devniteshkumar/oscript/archive/refs/heads/main.tar.gz -o "$REPO_DIR/oscript.tar.gz"
tar -xzf "$REPO_DIR/oscript.tar.gz" -C "$REPO_DIR"
REPO_FILES="$REPO_DIR/oscript-main/files"
sudo cp "$REPO_FILES/flake.nix" /mnt/etc/nixos/flake.nix
sudo cp "$REPO_FILES/configuration.nix" /mnt/etc/nixos/configuration.nix
sudo cp "$REPO_FILES/home.nix" /mnt/etc/nixos/home.nix
sudo mkdir -p /mnt/etc/nixos/niri
sudo cp "$REPO_FILES/niri/config.kdl" /mnt/etc/nixos/niri/config.kdl
rm -rf "$REPO_DIR"
cd /mnt/etc/nixos
sudo nix --extra-experimental-features 'nix-command flakes' flake update
sudo nixos-install --flake .#nixos
sudo nixos-enter --root /mnt -c 'passwd niteshk'
sudo nixos-enter --root /mnt -c 'id niteshk'
sudo reboot