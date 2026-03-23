#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/scripts/utils.sh"

ensure_dirs

BUSYBOX_SRC="$BUILD_DIR/busybox-$BUSYBOX_VERSION"
BUSYBOX_BUILD="$BUILD_DIR/busybox-build"

if [[ ! -d "$BUSYBOX_SRC" ]]; then
  echo "Extracting busybox"
  tar -C "$BUILD_DIR" -xf "$SRC_DIR/$BUSYBOX_TAR"
fi

rm -rf "$BUSYBOX_BUILD"
cp -R "$BUSYBOX_SRC" "$BUSYBOX_BUILD"

pushd "$BUSYBOX_BUILD" >/dev/null

make defconfig

if [[ -f "$ROOT_DIR/config/busybox.config" ]]; then
  cp "$ROOT_DIR/config/busybox.config" .config
fi

make -j"$(getconf _NPROCESSORS_ONLN)"
make CONFIG_PREFIX="$BUILD_DIR/busybox-install" install

popd >/dev/null
