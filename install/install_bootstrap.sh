# Variables
SWAP_SIZE=4GB
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# bootstrap NixOS script for a VM with UEFI

echo "Partitioning disk..."
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart root ext4 512MB -$SWAP_SIZE
parted /dev/sda -- mkpart swap linux-swap -$SWAP_SIZE 100%
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 3 esp on

echo "Formatting partitions..."
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3

echo "Mounting filesystem..."
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
swapon /dev/sda2

echo "Copying bootstrap configuration..."
mkdir -p /mnt/etc/nixos
cp $SCRIPT_DIR/../environments/bootstrap/*.nix /mnt/etc/nixos/

echo "Installing NixOS..."
nixos-install --no-root-passwd
