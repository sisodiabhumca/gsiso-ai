#!/bin/bash

# Exit on error
set -e

# Configuration
ISO_NAME="gsiso-ai"
VERSION="1.0.0"
ARCH="x86_64"
BUILD_DIR="$(pwd)/iso"
ISO_DIR="${BUILD_DIR}/gsiso"
ISO_FILE="${ISO_NAME}-${VERSION}-${ARCH}.iso"

# Create necessary directories
mkdir -p ${BUILD_DIR}/isolinux

# Install required tools
echo "Installing required tools..."
sudo apt-get update
sudo apt-get install -y grub2-common grub-pc-bin grub-efi-amd64-bin \
    mtools xorriso squashfs-tools wget cpio genisoimage

# Create basic file system structure
echo "Creating basic file system structure..."
mkdir -p ${ISO_DIR}/{bin,boot,dev,etc,lib,lib64,mnt,proc,root,run,sbin,sys,tmp,usr/{bin,lib,sbin},var}

# Copy essential binaries and libraries (using host system's for now)
# In a real build, these would be built from source
cp /bin/busybox ${ISO_DIR}/bin/
ln -s /bin/busybox ${ISO_DIR}/bin/sh
cp /lib64/ld-linux-x86-64.so.2 ${ISO_DIR}/lib64/
cp /lib/x86_64-linux-gnu/libc.so.6 ${ISO_DIR}/lib/
cp /lib/x86_64-linux-gnu/libm.so.6 ${ISO_DIR}/lib/
cp /lib/x86_64-linux-gnu/libresolv.so.2 ${ISO_DIR}/lib/
cp /lib/x86_64-linux-gnu/libnss_dns.so.2 ${ISO_DIR}/lib/

# Create init script
cat > ${ISO_DIR}/init << 'EOF'
#!/bin/sh

echo "Starting Gsiso AI Linux..."

# Mount necessary filesystems
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs udev /dev

# Create device nodes
mknod /dev/console c 5 1
mknod /dev/null c 1 3
mknod /dev/zero c 1 5

# Set up network (basic loopback)
ip link set lo up

# Start a shell
setsid cttyhack /bin/sh

# If shell exits, power off
poweroff -f
EOF

chmod +x ${ISO_DIR}/init

# Create GRUB configuration
cat > ${BUILD_DIR}/isolinux/grub.cfg << 'EOF'
set default=0
set timeout=10

menuentry "Gsiso AI Linux" {
    linux /boot/bzImage root=/dev/ram0 rw init=/init
    initrd /boot/initrd.img
}
EOF

# Create ISO image
echo "Creating ISO image..."
cd ${ISO_DIR}
find . | cpio -H newc -o | gzip > ${BUILD_DIR}/initrd.img
cd ${BUILD_DIR}

# Copy kernel (using host kernel for now, in a real build this would be a custom kernel)
cp /boot/vmlinuz-$(uname -r) ${BUILD_DIR}/bzImage

grub-mkrescue -o ${ISO_FILE} .

echo "ISO created: ${BUILD_DIR}/${ISO_FILE}"
