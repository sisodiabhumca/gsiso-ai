#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/scripts/utils.sh"

ensure_dirs

fetch_file "$KERNEL_URL" "$SRC_DIR/$KERNEL_TAR"
fetch_file "$BUSYBOX_URL" "$SRC_DIR/$BUSYBOX_TAR"
