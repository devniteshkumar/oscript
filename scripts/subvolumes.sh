#!/usr/bin/env bash
set -euo pipefail

# Detect currently mounted filesystems
ROOT_DEV=$(findmnt -no SOURCE /mnt)
EFI_DEV=$(findmnt -no SOURCE /mnt/boot)

echo "Btrfs device : $ROOT_DEV"
echo "EFI device   : $EFI_DEV"
echo

# Verify that /mnt is actually Btrfs
[[ "$(findmnt -no FSTYPE /mnt)" == "btrfs" ]] || {
  echo "Error: /mnt is not mounted as Btrfs."
  exit 1
  }

# Create subvolumes
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@log

echo
echo "Created subvolumes:"
btrfs subvolume list /mnt

# Temporarily unmount EFI and Btrfs
umount /mnt/boot
umount /mnt

# Mount @root
mount -o subvol=@root,compress=zstd,noatime "$ROOT_DEV" /mnt

# Create mount points
mkdir -p /mnt/home
mkdir -p /mnt/nix
mkdir -p /mnt/var/log
mkdir -p /mnt/boot

# Mount remaining subvolumes
mount -o subvol=@home,compress=zstd,noatime "$ROOT_DEV" /mnt/home
mount -o subvol=@nix,compress=zstd,noatime "$ROOT_DEV" /mnt/nix
mount -o subvol=@log,compress=zstd,noatime "$ROOT_DEV" /mnt/var/log

# Mount EFI
mount "$EFI_DEV" /mnt/boot

echo
echo "======================================"
echo " Btrfs setup complete"
echo "======================================"
echo

findmnt /mnt
echo
btrfs subvolume list /mnt
