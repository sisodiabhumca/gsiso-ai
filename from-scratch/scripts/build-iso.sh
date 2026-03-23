#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/scripts/utils.sh"

ensure_dirs

ISO_DIR="$BUILD_DIR/iso"
BOOT_DIR="$ISO_DIR/boot"
GRUB_DIR="$BOOT_DIR/grub"

rm -rf "$ISO_DIR"
mkdir -p "$GRUB_DIR"

cp "$OUTPUT_DIR/bzImage" "$BOOT_DIR/bzImage"
cp "$OUTPUT_DIR/initramfs.cpio.gz" "$BOOT_DIR/initramfs.cpio.gz"

cat > "$GRUB_DIR/grub.cfg" <<'GRUBCFG'
set default=0
set timeout=5

menuentry "Gsiso Minimal Linux" {
    linux /boot/bzImage quiet
    initrd /boot/initramfs.cpio.gz
}
GRUBCFG

# Create ISO
if command -v grub-mkrescue >/dev/null 2>&1; then
  grub-mkrescue -o "$OUTPUT_DIR/gsiso-minlinux.iso" "$ISO_DIR" >/dev/null 2>&1
else
  echo "grub-mkrescue not found. Please install grub and xorriso." >&2
  exit 1
fi
