#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$ROOT_DIR/output"

export KERNEL_VERSION="${KERNEL_VERSION:-6.6.6}"
export BUSYBOX_VERSION="${BUSYBOX_VERSION:-1.36.1}"

mkdir -p "$OUTPUT_DIR"

"$ROOT_DIR/scripts/fetch.sh"
"$ROOT_DIR/scripts/build-kernel.sh"
"$ROOT_DIR/scripts/build-busybox.sh"
"$ROOT_DIR/scripts/build-rootfs.sh"
"$ROOT_DIR/scripts/build-iso.sh"

echo "Build complete. ISO at $OUTPUT_DIR/gsiso-minlinux.iso"
