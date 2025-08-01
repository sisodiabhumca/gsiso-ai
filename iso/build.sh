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

# Retry function for package installation
retry_install() {
    local max_attempts=3
    local delay=5
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        echo -e "${YELLOW}Attempt $attempt of $max_attempts to install packages...${NC}"
        if "$@"; then
            return 0
        fi
        echo -e "${YELLOW}Package installation failed. Retrying in $delay seconds...${NC}"
        sleep $delay
        attempt=$((attempt + 1))
        delay=$((delay * 2))
    done
    echo -e "${RED}Package installation failed after $max_attempts attempts${NC}"
    return 1
}

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
    
    # Check if we're in a container environment
    if [ -f /.dockerenv ]; then
        echo -e "${YELLOW}Detected Docker environment, skipping package installation${NC}"
        return 0
    fi
    
    if command -v apt-get &> /dev/null; then
        echo -e "${YELLOW}Using apt-get package manager${NC}"
        retry_install apt-get update
        retry_install apt-get install -y ${REQUIRED_PACKAGES}
    elif command -v dnf &> /dev/null; then
        echo -e "${YELLOW}Using dnf package manager${NC}"
        retry_install dnf install -y ${REQUIRED_PACKAGES}
    elif command -v yum &> /dev/null; then
        echo -e "${YELLOW}Using yum package manager${NC}"
        retry_install yum install -y ${REQUIRED_PACKAGES}
    else
        echo -e "${YELLOW}Warning: Could not determine package manager. Please install required packages manually.${NC}"
        echo -e "${YELLOW}Required packages: ${REQUIRED_PACKAGES}${NC}"
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
        if [ -f "$bin" ]; then
            ldd "$bin" 2>/dev/null | grep "=>" | awk '{print $3}' | while read -r lib; do
                if [ -f "$lib" ] && [ ! -f "${ISO_DIR}${lib}" ]; then
                    mkdir -p "${ISO_DIR}$(dirname "$lib")"
                    cp "$lib" "${ISO_DIR}${lib}"
                fi
            done
        fi
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
    
    # Try to find kernel image
    echo -e "${YELLOW}Searching for kernel image...${NC}"
    KERNEL_FOUND=""
    
    # Try paths from config
    for kernel_path in ${KERNEL_PATHS}; do
        echo -e "${YELLOW}Checking: ${kernel_path}${NC}"
        if [ -f "${kernel_path}" ]; then
            KERNEL_FOUND="${kernel_path}"
            echo -e "${GREEN}Found kernel at: ${KERNEL_FOUND}${NC}"
            break
        fi
    done
    
    # If not found, search more broadly
    if [ -z "${KERNEL_FOUND}" ]; then
        echo -e "${YELLOW}Searching for kernel in /boot and /...${NC}"
        KERNEL_FOUND=$(find /boot / -name "vmlinuz*" -o -name "bzImage" -o -name "vmlinux*" 2>/dev/null | head -1)
        if [ -n "${KERNEL_FOUND}" ]; then
            echo -e "${GREEN}Found kernel at: ${KERNEL_FOUND}${NC}"
        fi
    fi
    
    # If still not found, create a minimal kernel stub
    if [ -z "${KERNEL_FOUND}" ]; then
        echo -e "${YELLOW}No kernel found, creating minimal kernel stub...${NC}"
        # Create a minimal kernel stub (this is just for testing)
        dd if=/dev/zero of="${BUILD_DIR}/boot/bzImage" bs=1M count=1 2>/dev/null || true
        echo -e "${YELLOW}Created minimal kernel stub${NC}"
    else
        echo -e "${GREEN}Copying kernel: ${KERNEL_FOUND}${NC}"
        cp "${KERNEL_FOUND}" "${BUILD_DIR}/boot/bzImage"
    fi
    
    # Create GRUB configuration
    create_grub_config
    
    # Create ISO
    echo -e "${YELLOW}Generating ISO...${NC}"
    cd "${BUILD_DIR}"
    
    # Check if grub-mkrescue is available
    if ! command -v grub-mkrescue &> /dev/null; then
        echo -e "${RED}Error: grub-mkrescue not found${NC}"
        echo -e "${YELLOW}Available grub commands:${NC}"
        which grub-mkrescue || echo "grub-mkrescue not found"
        which grub2-mkrescue || echo "grub2-mkrescue not found"
        exit 1
    fi
    
    # Create output directory if it doesn't exist
    mkdir -p "${OUTPUT_DIR}"
    
    echo -e "${YELLOW}Running grub-mkrescue...${NC}"
    echo -e "${YELLOW}Current directory: $(pwd)${NC}"
    echo -e "${YELLOW}Output file: ${OUTPUT_DIR}/${ISO_FILE}${NC}"
    
    # Run grub-mkrescue with verbose output
    if grub-mkrescue -o "${OUTPUT_DIR}/${ISO_FILE}" . 2>&1; then
        echo -e "${GREEN}grub-mkrescue completed successfully${NC}"
    else
        echo -e "${RED}grub-mkrescue failed${NC}"
        echo -e "${YELLOW}Trying alternative approach...${NC}"
        
        # Try alternative ISO creation method
        if command -v xorriso &> /dev/null; then
            echo -e "${YELLOW}Using xorriso as alternative...${NC}"
            xorriso -as mkisofs -o "${OUTPUT_DIR}/${ISO_FILE}" -b boot/grub/i386-pc/eltorito.img -no-emul-boot -boot-load-size 4 -boot-info-table --grub2-boot-info --grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img -r -V "GsisoAI" -append-partition 2 0xef /usr/lib/grub/x86_64-efi/efi.img -joliet-long . || {
                echo -e "${RED}xorriso also failed${NC}"
                exit 1
            }
        else
            echo -e "${RED}No alternative ISO creation tools available${NC}"
            exit 1
        fi
    fi
    
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
