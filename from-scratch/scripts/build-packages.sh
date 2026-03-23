#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PKG_SRC="$ROOT_DIR/packages"
PKG_OUT="$ROOT_DIR/build/packages"

mkdir -p "$PKG_OUT"

for pkg in "$PKG_SRC"/*; do
  name="$(basename "$pkg")"
  [ -d "$pkg" ] || continue

  tar -czf "$PKG_OUT/$name.tar.gz" -C "$pkg" .
  echo "Built package: $name"
done
