#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ISO="$ROOT_DIR/output/gsiso-minlinux.iso"
KERNEL="$ROOT_DIR/output/bzImage"
INITRAMFS="$ROOT_DIR/output/initramfs.cpio.gz"

if [[ ! -f "$KERNEL" || ! -f "$INITRAMFS" ]]; then
  echo "Kernel/initramfs not found. Run ./build.sh first." >&2
  exit 1
fi

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 /dev/sdX" >&2
  exit 1
fi

DISK="$1"

cat <<WARN
This will ERASE all data on $DISK.
Proceed? (yes/no)
WARN
read -r confirm
if [[ "$confirm" != "yes" ]]; then
  echo "Aborted."
  exit 1
fi

# Create a simple GPT with EFI + root
sgdisk --zap-all "$DISK"
sgdisk -n 1:2048:+512M -t 1:ef00 -c 1:"EFI" "$DISK"
sgdisk -n 2:0:0 -t 2:8300 -c 2:"ROOT" "$DISK"

partprobe "$DISK"

EFI_PART="${DISK}1"
ROOT_PART="${DISK}2"

mkfs.vfat -F32 "$EFI_PART"
mkfs.ext4 -F "$ROOT_PART"

MNT="/mnt/gsiso"
mkdir -p "$MNT"
mount "$ROOT_PART" "$MNT"
mkdir -p "$MNT/boot"
mkdir -p "$MNT/boot/efi"
mount "$EFI_PART" "$MNT/boot/efi"

cp "$KERNEL" "$MNT/boot/bzImage"
cp "$INITRAMFS" "$MNT/boot/initramfs.cpio.gz"

mkdir -p "$MNT/boot/grub"
cat > "$MNT/boot/grub/grub.cfg" <<'GRUBCFG'
set default=0
set timeout=5

menuentry "Gsiso Minimal Linux" {
    linux /boot/bzImage quiet
    initrd /boot/initramfs.cpio.gz
}
GRUBCFG

if command -v grub-install >/dev/null 2>&1; then
  grub-install --target=x86_64-efi --efi-directory="$MNT/boot/efi" --boot-directory="$MNT/boot" --removable
else
  echo "grub-install not found. Please install GRUB and rerun." >&2
  exit 1
fi

sync
umount "$MNT/boot/efi"
umount "$MNT"

rmdir "$MNT" || true

echo "Install complete. You can boot from $DISK now."
