#!/usr/bin/env bash
set -euo pipefail

# Show available disks
lsblk -d -o NAME,SIZE,MODEL,TYPE

echo
read -rp "Enter target disk (e.g. /dev/sda or /dev/nvme0n1): " DISK

if [[ ! -b "$DISK" ]]; then
    echo "Error: $DISK is not a block device."
    exit 1
fi

echo
echo "Selected disk:"
lsblk "$DISK"

echo
read -rp "ERASE $DISK? Type 'y' to continue: " CONFIRM
[[ "$CONFIRM" == "y" ]] || exit 1

# Remove existing partition tables and filesystem signatures.
wipefs --all --force "$DISK"
sgdisk --zap-all "$DISK"

# RAM + 4 GiB swap
RAM_MIB=$(awk '/MemTotal/ {print int($2 / 1024)}' /proc/meminfo)
SWAP_MIB=$((RAM_MIB + 4096))

# GPT:
# 1. 2 GiB EFI
# 2. RAM + 4 GiB swap
# 3. Remaining Btrfs
printf 'label: gpt\n,2G,U\n,%sM,S\n,,L\n' "$SWAP_MIB" \
    | sfdisk "$DISK"

partprobe "$DISK"
udevadm settle

# Handle /dev/sda vs /dev/nvme0n1 naming
if [[ "$DISK" == *nvme* || "$DISK" == *mmcblk* ]]; then
    EFI="${DISK}p1"
    SWAP="${DISK}p2"
    ROOT="${DISK}p3"
else
    EFI="${DISK}1"
    SWAP="${DISK}2"
    ROOT="${DISK}3"
fi

mkfs.fat -F 32 -n EFI "$EFI"
mkswap -L swap "$SWAP"
mkfs.btrfs -L nixos "$ROOT"

mount "$ROOT" /mnt
mount --mkdir "$EFI" /mnt/boot
swapon "$SWAP"

lsblk -o NAME,SIZE,FSTYPE,LABEL,MOUNTPOINTS "$DISK"