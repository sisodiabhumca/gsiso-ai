#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/scripts/utils.sh"

ensure_dirs

ROOTFS_DIR="$BUILD_DIR/rootfs"
BUSYBOX_INSTALL="$BUILD_DIR/busybox-install"

rm -rf "$ROOTFS_DIR"
mkdir -p "$ROOTFS_DIR"

# Copy BusyBox install
cp -a "$BUSYBOX_INSTALL"/* "$ROOTFS_DIR"

# Add minimal rootfs files
cp -a "$ROOT_DIR/rootfs"/* "$ROOTFS_DIR"

# Build and include package layers
"$ROOT_DIR/scripts/build-packages.sh"
mkdir -p "$ROOTFS_DIR/packages"
cp -a "$BUILD_DIR/packages"/* "$ROOTFS_DIR/packages" 2>/dev/null || true

# Ensure essential dirs
mkdir -p "$ROOTFS_DIR"/{proc,sys,dev,run,tmp,var,root,usr/bin}
chmod 1777 "$ROOTFS_DIR/tmp"
mkdir -p "$ROOTFS_DIR/etc/gs-pkg"
touch "$ROOTFS_DIR/etc/gs-pkg/installed.db"

# Create device nodes for early boot
sudo mknod -m 600 "$ROOTFS_DIR/dev/console" c 5 1 || true
sudo mknod -m 666 "$ROOTFS_DIR/dev/null" c 1 3 || true

# Build initramfs
pushd "$ROOTFS_DIR" >/dev/null
find . -print0 | cpio --null -ov --format=newc | gzip -9 > "$OUTPUT_DIR/initramfs.cpio.gz"
popd >/dev/null
