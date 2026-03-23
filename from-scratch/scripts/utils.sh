#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/src"
BUILD_DIR="$ROOT_DIR/build"
OUTPUT_DIR="$ROOT_DIR/output"

KERNEL_TAR="linux-${KERNEL_VERSION}.tar.xz"
BUSYBOX_TAR="busybox-${BUSYBOX_VERSION}.tar.bz2"

KERNEL_URL="https://cdn.kernel.org/pub/linux/kernel/v6.x/${KERNEL_TAR}"
BUSYBOX_URL="https://busybox.net/downloads/${BUSYBOX_TAR}"

ensure_dirs() {
  mkdir -p "$SRC_DIR" "$BUILD_DIR" "$OUTPUT_DIR"
}

fetch_file() {
  local url="$1"
  local dest="$2"

  if [[ -f "$dest" ]]; then
    echo "Already have $(basename "$dest")"
    return 0
  fi

  echo "Fetching $(basename "$dest")"
  if command -v curl >/dev/null 2>&1; then
    curl -L "$url" -o "$dest"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$dest" "$url"
  else
    echo "Neither curl nor wget is available" >&2
    exit 1
  fi
}
