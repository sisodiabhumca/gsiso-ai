#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ISO="$ROOT_DIR/output/gsiso-minlinux.iso"

if [[ ! -f "$ISO" ]]; then
  echo "ISO not found. Run ./build.sh first." >&2
  exit 1
fi

if ! command -v qemu-system-x86_64 >/dev/null 2>&1; then
  echo "qemu-system-x86_64 not found. Install QEMU first." >&2
  exit 1
fi

qemu-system-x86_64 \
  -m 512M \
  -cdrom "$ISO" \
  -boot d \
  -nographic
