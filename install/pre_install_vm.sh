#!/usr/bin/env nix-shell
#! nix-shell -i bash --pure
#! nix-shell -p bash parted e2fsprogs util-linux dosfstools

# Variables
swapsize = 4GB

# NixOS preinstall script for a VM with UEFI
# Basic disk partitioning

parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart root ext4 512MB -$swapsize
parted /dev/sda -- mkpart swap linux-swap -$swapsize 100%
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 3 esp on

# format partiions
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3

# Mount the system
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
swapon /dev/sda2
