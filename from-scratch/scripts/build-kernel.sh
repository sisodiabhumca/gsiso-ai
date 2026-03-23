#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/scripts/utils.sh"

ensure_dirs

KERNEL_SRC="$BUILD_DIR/linux-$KERNEL_VERSION"
KERNEL_BUILD="$BUILD_DIR/kernel-build"

if [[ ! -d "$KERNEL_SRC" ]]; then
  echo "Extracting kernel"
  tar -C "$BUILD_DIR" -xf "$SRC_DIR/$KERNEL_TAR"
fi

mkdir -p "$KERNEL_BUILD"

pushd "$KERNEL_SRC" >/dev/null

make O="$KERNEL_BUILD" defconfig

# Apply small config fragment for initramfs and basic drivers
if [[ -f "$ROOT_DIR/config/kernel.fragment" ]]; then
  scripts/kconfig/merge_config.sh -O "$KERNEL_BUILD" \
    "$KERNEL_BUILD/.config" "$ROOT_DIR/config/kernel.fragment"
fi

make O="$KERNEL_BUILD" -j"$(getconf _NPROCESSORS_ONLN)"

cp "$KERNEL_BUILD/arch/x86/boot/bzImage" "$OUTPUT_DIR/bzImage"

popd >/dev/null
