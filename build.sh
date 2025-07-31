#!/bin/bash

# gsiso ai linux build script
# this script builds the gsiso ai linux distribution

set -e

# Configuration
VERSION="1.0.0"
BUILD_DIR="$(pwd)/build"
ISO_DIR="${BUILD_DIR}/iso"
WORK_DIR="${BUILD_DIR}/work"
OUTPUT_DIR="${BUILD_DIR}/output"

# Create necessary directories
mkdir -p "${ISO_DIR}" "${WORK_DIR}" "${OUTPUT_DIR}"

echo "=== gsiso ai linux builder ==="
echo "Version: ${VERSION}"
echo "Build directory: ${BUILD_DIR}"

# Check for required tools
command -v mkisofs >/dev/null 2>&1 || { 
    echo "Error: mkisofs is required but not installed."; 
    echo "On Debian/Ubuntu: sudo apt-get install genisoimage";
    echo "On Arch: sudo pacman -S cdrkit";
    exit 1; 
}

# Create basic directory structure
mkdir -p "${ISO_DIR}/boot/grub"
mkdir -p "${ISO_DIR}/gsiso"

# Create a minimal GRUB configuration
cat > "${ISO_DIR}/boot/grub/grub.cfg" << EOF
set default=0
set timeout=5

menuentry "gsiso ai linux" {
    linux /vmlinuz root=/dev/sr0 quiet splash
    initrd /initrd.img
}

menuentry "gsiso ai linux (safe mode)" {
    linux /vmlinuz root=/dev/sr0 single
    initrd /initrd.img
}
EOF

# Create a simple info file
echo "gsiso ai linux ${VERSION}" > "${ISO_DIR}/gsiso/gsiso.info"

# Create the ISO
echo "Creating ISO image..."
mkisofs -o "${OUTPUT_DIR}/gsiso-ai-${VERSION}.iso" \
    -b boot/grub/stage2_eltorito \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -input-charset utf-8 \
    -J -r -V "gsiso ai ${VERSION}" \
    "${ISO_DIR}"

# Create checksum
cd "${OUTPUT_DIR}"
sha256sum "gsiso-ai-${VERSION}.iso" > "gsiso-ai-${VERSION}.iso.sha256"

# Print summary
echo "\n=== Build Complete ==="
echo "ISO created at: ${OUTPUT_DIR}/gsiso-ai-${VERSION}.iso"
echo "SHA256: $(cat "gsiso-ai-${VERSION}.iso.sha256")"
