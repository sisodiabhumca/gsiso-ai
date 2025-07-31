#!/bin/bash

# Exit on error and trace
set -e

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/build_config"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print header
print_header() {
    echo -e "${GREEN}"
    echo "========================================"
    echo "  Gsiso AI Linux ISO Builder"
    echo "  Version: ${VERSION}"
    echo "  Architecture: ${ARCH}"
    echo "  Build Directory: ${BUILD_DIR}"
    echo "========================================"
    echo -e "${NC}"
}

# Check if running as root
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${RED}Error: This script must be run as root${NC}"
        exit 1
    fi
}

# Install required packages
install_dependencies() {
    echo -e "${YELLOW}Installing required packages...${NC}"
    if command -v apt-get &> /dev/null; then
        apt-get update
        apt-get install -y ${REQUIRED_PACKAGES}
    elif command -v dnf &> /dev/null; then
        dnf install -y ${REQUIRED_PACKAGES}
    elif command -v yum &> /dev/null; then
        yum install -y ${REQUIRED_PACKAGES}
    else
        echo -e "${YELLOW}Warning: Could not determine package manager. Please install required packages manually.${NC}"
    fi
}

# Create directory structure
setup_directories() {
    echo -e "${YELLOW}Setting up directory structure...${NC}"
    mkdir -p "${ISO_DIR}"
    mkdir -p "${OUTPUT_DIR}"
    
    # Create standard Linux directory structure
    for dir in bin boot dev etc home lib lib64 mnt opt proc root run sbin srv sys tmp usr var; do
        mkdir -p "${ISO_DIR}/${dir}"
    done
    
    # Create additional required directories
    mkdir -p "${ISO_DIR}/usr/bin"
    mkdir -p "${ISO_DIR}/usr/sbin"
    mkdir -p "${ISO_DIR}/usr/lib"
    mkdir -p "${ISO_DIR}/var/log"
    mkdir -p "${ISO_DIR}/var/tmp"
}

# Copy essential binaries and libraries
copy_essentials() {
    echo -e "${YELLOW}Copying essential binaries and libraries...${NC}"
    
    # Copy busybox and create symlinks
    if ! command -v busybox &> /dev/null; then
        echo -e "${RED}Error: busybox is required but not installed.${NC}"
        exit 1
    fi
    
    BUSYBOX_PATH=$(which busybox)
    cp "${BUSYBOX_PATH}" "${ISO_DIR}/bin/"
    chmod +x "${ISO_DIR}/bin/busybox"
    
    # Create busybox symlinks
    for cmd in $(${BUSYBOX_PATH} --list); do
        ln -sf /bin/busybox "${ISO_DIR}/bin/${cmd}"
    done
    
    # Copy essential libraries
    echo -e "${YELLOW}Copying essential libraries...${NC}"
    
    # Function to copy dependencies
    copy_deps() {
        local bin=$1
        ldd "$bin" | grep "=>" | awk '{print $3}' | while read -r lib; do
            if [ -f "$lib" ] && [ ! -f "${ISO_DIR}${lib}" ]; then
                mkdir -p "${ISO_DIR}$(dirname "$lib")"
                cp "$lib" "${ISO_DIR}${lib}"
            fi
        done
    }
    
    # Copy dependencies for busybox
    copy_deps "${BUSYBOX_PATH}"
    
    # Copy additional essential binaries
    for bin in /bin/bash /bin/sh /bin/ls /bin/cat /bin/echo /bin/mkdir /bin/mount /bin/umount /bin/rm /bin/cp /bin/mv /bin/ln /bin/dd /bin/sleep /bin/sync; do
        if [ -f "$bin" ]; then
            cp "$bin" "${ISO_DIR}/bin/"
            copy_deps "$bin"
        fi
    done
}

# Create init script
create_init_script() {
    echo -e "${YELLOW}Creating init script...${NC}"
    cat > "${ISO_DIR}/init" << 'EOF'
#!/bin/sh

# Mount necessary filesystems
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs udev /dev

# Create device nodes
mknod /dev/console c 5 1
mknod /dev/null c 1 3
mknod /dev/zero c 1 5
mknod /dev/tty c 5 0
mknod /dev/tty1 c 4 1
mknod /dev/tty2 c 4 2

# Set up hostname
echo "GsisoAI" > /proc/sys/kernel/hostname

# Mount /dev/pts for pseudo-terminals
mkdir -p /dev/pts
mount -t devpts devpts /dev/pts

# Set up networking
ip link set lo up

# Start a shell
echo ""
echo "Gsiso AI Linux - Minimal System"
echo ""
exec /bin/sh

# If shell exits, power off
poweroff -f
EOF

    chmod +x "${ISO_DIR}/init"
}

# Create GRUB configuration
create_grub_config() {
    echo -e "${YELLOW}Creating GRUB configuration...${NC}"
    mkdir -p "${BUILD_DIR}/boot/grub"
    
    cat > "${BUILD_DIR}/boot/grub/grub.cfg" << 'EOF'
set timeout=10
set default=0

menuentry "Gsiso AI Linux" {
    linux /boot/bzImage root=/dev/ram0 rw init=/init console=tty0 console=ttyS0,115200n8
    initrd /boot/initrd.img
}

menuentry "Gsiso AI Linux (Safe Mode)" {
    linux /boot/bzImage root=/dev/ram0 rw init=/init single
    initrd /boot/initrd.img
}
EOF
}

# Create ISO image
create_iso() {
    echo -e "${YELLOW}Creating ISO image...${NC}"
    
    # Create initramfs
    echo -e "${YELLOW}Creating initramfs...${NC}"
    cd "${ISO_DIR}"
    find . | cpio -H newc -o | gzip -9 > "${BUILD_DIR}/initrd.img"
    
    # Copy kernel
    echo -e "${YELLOW}Copying kernel...${NC}"
    mkdir -p "${BUILD_DIR}/boot"
    cp "${KERNEL_IMAGE}" "${BUILD_DIR}/boot/bzImage"
    
    # Create GRUB configuration
    create_grub_config
    
    # Create ISO
    echo -e "${YELLOW}Generating ISO...${NC}"
    cd "${BUILD_DIR}"
    
    grub-mkrescue -o "${OUTPUT_DIR}/${ISO_FILE}" .
    
    # Check if ISO was created successfully
    if [ -f "${OUTPUT_DIR}/${ISO_FILE}" ]; then
        echo -e "${GREEN}ISO created successfully: ${OUTPUT_DIR}/${ISO_FILE}${NC}"
        echo -e "${GREEN}Size: $(du -h "${OUTPUT_DIR}/${ISO_FILE}" | cut -f1)${NC}"
    else
        echo -e "${RED}Error: Failed to create ISO${NC}"
        exit 1
    fi
}

# Main function
main() {
    print_header
    check_root
    install_dependencies
    setup_directories
    copy_essentials
    create_init_script
    create_iso
    
    echo -e "${GREEN}Gsiso AI ISO build completed successfully!${NC}"
    echo -e "${GREEN}ISO location: ${OUTPUT_DIR}/${ISO_FILE}${NC}"
}

# Run main function
main "$@"
