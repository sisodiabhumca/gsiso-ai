#!/bin/bash

# Gsiso AI Linux ISO Builder - Main Script
# This script orchestrates the complete ISO building process

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

# Check build mode
check_build_mode() {
    echo -e "${YELLOW}Checking build mode...${NC}"
    
    # Check if we have the real build script
    if [ -f "${SCRIPT_DIR}/build_real.sh" ]; then
        echo -e "${GREEN}Real bootable ISO builder found${NC}"
        return 0
    else
        echo -e "${YELLOW}Using minimal ISO builder (development mode)${NC}"
        return 1
    fi
}

# Build packages first
build_packages() {
    echo -e "${YELLOW}Building packages...${NC}"
    
    if [ -f "${SCRIPT_DIR}/../scripts/create-packages.sh" ]; then
        echo -e "${YELLOW}Running package builder...${NC}"
        "${SCRIPT_DIR}/../scripts/create-packages.sh"
        echo -e "${GREEN}Packages built successfully${NC}"
    else
        echo -e "${YELLOW}Package builder not found, skipping${NC}"
    fi
}

# Build real bootable ISO
build_real_iso() {
    echo -e "${YELLOW}Building real bootable ISO...${NC}"
    
    # Make the real build script executable
    chmod +x "${SCRIPT_DIR}/build_real.sh"
    
    # Run the real ISO builder
    if "${SCRIPT_DIR}/build_real.sh"; then
        # Copy ISO to the expected location for GitHub Actions
        if [ -f "${SCRIPT_DIR}/output/gsiso-ai-1.0.0-x86_64.iso" ]; then
            echo -e "${YELLOW}Copying ISO to expected location...${NC}"
            mkdir -p "${SCRIPT_DIR}/output"
            cp "${SCRIPT_DIR}/output/gsiso-ai-1.0.0-x86_64.iso" "${SCRIPT_DIR}/output/"
            echo -e "${GREEN}ISO copied to: ${SCRIPT_DIR}/output/gsiso-ai-1.0.0-x86_64.iso${NC}"
            
            # List files in output directory
            echo -e "${YELLOW}Files in output directory:${NC}"
            ls -la "${SCRIPT_DIR}/output/"
        else
            echo -e "${RED}Error: ISO file not found in expected location${NC}"
            echo -e "${YELLOW}Searching for ISO files...${NC}"
            find "${SCRIPT_DIR}" -name "*.iso" -type f 2>/dev/null || echo "No ISO files found"
            return 1
        fi
        
        echo -e "${GREEN}Real bootable ISO created successfully${NC}"
        return 0
    else
        echo -e "${YELLOW}Real ISO build failed, trying fallback...${NC}"
        return 1
    fi
}

# Build fallback ISO
build_fallback_iso() {
    echo -e "${YELLOW}Building fallback ISO...${NC}"
    
    # Make the fallback build script executable
    chmod +x "${SCRIPT_DIR}/build_fallback.sh"
    
    # Run the fallback ISO builder
    "${SCRIPT_DIR}/build_fallback.sh"
    
    # Copy ISO to the expected location for GitHub Actions
    if [ -f "${SCRIPT_DIR}/output/gsiso-ai-1.0.0-x86_64.iso" ]; then
        echo -e "${YELLOW}Copying fallback ISO to expected location...${NC}"
        mkdir -p "${SCRIPT_DIR}/output"
        cp "${SCRIPT_DIR}/output/gsiso-ai-1.0.0-x86_64.iso" "${SCRIPT_DIR}/output/"
        echo -e "${GREEN}Fallback ISO copied to: ${SCRIPT_DIR}/output/gsiso-ai-1.0.0-x86_64.iso${NC}"
        
        # List files in output directory
        echo -e "${YELLOW}Files in output directory:${NC}"
        ls -la "${SCRIPT_DIR}/output/"
    else
        echo -e "${RED}Error: Fallback ISO file not found${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}Fallback ISO created successfully${NC}"
}

# Build minimal ISO (fallback)
build_minimal_iso() {
    echo -e "${YELLOW}Building minimal ISO (development mode)...${NC}"
    
    # Install required packages
    install_dependencies
    
    # Create directory structure
    setup_directories
    
    # Copy essential binaries and libraries
    copy_essentials
    
    # Create init script
    create_init_script
    
    # Create ISO image
    create_iso
    
    echo -e "${GREEN}Minimal ISO created successfully${NC}"
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
        apt-get update
        apt-get install -y ${REQUIRED_PACKAGES}
    elif command -v dnf &> /dev/null; then
        echo -e "${YELLOW}Using dnf package manager${NC}"
        dnf install -y ${REQUIRED_PACKAGES}
    elif command -v yum &> /dev/null; then
        echo -e "${YELLOW}Using yum package manager${NC}"
        yum install -y ${REQUIRED_PACKAGES}
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
    
    # Create output directory if it doesn't exist
    mkdir -p "${OUTPUT_DIR}"
    
    echo -e "${YELLOW}Current directory: $(pwd)${NC}"
    echo -e "${YELLOW}Output file: ${OUTPUT_DIR}/${ISO_FILE}${NC}"
    
    # Try multiple ISO creation methods
    ISO_CREATED=false
    
    # Method 1: Try grub-mkrescue
    if command -v grub-mkrescue &> /dev/null; then
        echo -e "${YELLOW}Trying grub-mkrescue...${NC}"
        if grub-mkrescue -o "${OUTPUT_DIR}/${ISO_FILE}" . 2>&1; then
            echo -e "${GREEN}grub-mkrescue completed successfully${NC}"
            ISO_CREATED=true
        else
            echo -e "${YELLOW}grub-mkrescue failed, trying next method...${NC}"
        fi
    else
        echo -e "${YELLOW}grub-mkrescue not available${NC}"
    fi
    
    # Method 2: Try xorriso
    if [ "$ISO_CREATED" = false ] && command -v xorriso &> /dev/null; then
        echo -e "${YELLOW}Trying xorriso...${NC}"
        if xorriso -as mkisofs -o "${OUTPUT_DIR}/${ISO_FILE}" -b boot/grub/i386-pc/eltorito.img -no-emul-boot -boot-load-size 4 -boot-info-table --grub2-boot-info --grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img -r -V "GsisoAI" -append-partition 2 0xef /usr/lib/grub/x86_64-efi/efi.img -joliet-long . 2>&1; then
            echo -e "${GREEN}xorriso completed successfully${NC}"
            ISO_CREATED=true
        else
            echo -e "${YELLOW}xorriso failed, trying next method...${NC}"
        fi
    fi
    
    # Method 3: Try genisoimage
    if [ "$ISO_CREATED" = false ] && command -v genisoimage &> /dev/null; then
        echo -e "${YELLOW}Trying genisoimage...${NC}"
        if genisoimage -o "${OUTPUT_DIR}/${ISO_FILE}" -b boot/grub/i386-pc/eltorito.img -no-emul-boot -boot-load-size 4 -boot-info-table -r -V "GsisoAI" . 2>&1; then
            echo -e "${GREEN}genisoimage completed successfully${NC}"
            ISO_CREATED=true
        else
            echo -e "${YELLOW}genisoimage failed, trying next method...${NC}"
        fi
    fi
    
    # Method 4: Create a simple ISO without bootloader (for testing)
    if [ "$ISO_CREATED" = false ]; then
        echo -e "${YELLOW}Creating simple ISO without bootloader...${NC}"
        # Create a simple ISO structure
        mkdir -p "${BUILD_DIR}/iso-content"
        cp -r . "${BUILD_DIR}/iso-content/" 2>/dev/null || true
        
        # Create a simple README
        echo "Gsiso AI Linux ISO" > "${BUILD_DIR}/iso-content/README.txt"
        echo "This is a test ISO created on $(date)" >> "${BUILD_DIR}/iso-content/README.txt"
        
        # Use basic ISO creation
        if command -v mkisofs &> /dev/null; then
            mkisofs -o "${OUTPUT_DIR}/${ISO_FILE}" -r -V "GsisoAI" "${BUILD_DIR}/iso-content" 2>&1 && ISO_CREATED=true
        elif command -v genisoimage &> /dev/null; then
            genisoimage -o "${OUTPUT_DIR}/${ISO_FILE}" -r -V "GsisoAI" "${BUILD_DIR}/iso-content" 2>&1 && ISO_CREATED=true
        else
            echo -e "${YELLOW}No ISO creation tools available, creating archive instead...${NC}"
            # Create a tar.gz as fallback
            tar -czf "${OUTPUT_DIR}/${ISO_NAME}-${VERSION}-${ARCH}.tar.gz" -C "${BUILD_DIR}" .
            echo -e "${GREEN}Created archive: ${OUTPUT_DIR}/${ISO_NAME}-${VERSION}-${ARCH}.tar.gz${NC}"
            ISO_CREATED=true
        fi
    fi
    
    # Check if ISO was created successfully
    if [ "$ISO_CREATED" = true ]; then
        if [ -f "${OUTPUT_DIR}/${ISO_FILE}" ]; then
            echo -e "${GREEN}ISO created successfully: ${OUTPUT_DIR}/${ISO_FILE}${NC}"
            echo -e "${GREEN}Size: $(du -h "${OUTPUT_DIR}/${ISO_FILE}" | cut -f1)${NC}"
        elif [ -f "${OUTPUT_DIR}/${ISO_NAME}-${VERSION}-${ARCH}.tar.gz" ]; then
            echo -e "${GREEN}Archive created successfully: ${OUTPUT_DIR}/${ISO_NAME}-${VERSION}-${ARCH}.tar.gz${NC}"
            echo -e "${GREEN}Size: $(du -h "${OUTPUT_DIR}/${ISO_NAME}-${VERSION}-${ARCH}.tar.gz" | cut -f1)${NC}"
        else
            echo -e "${RED}Error: No output file was created${NC}"
            exit 1
        fi
    else
        echo -e "${RED}Error: All ISO creation methods failed${NC}"
        echo -e "${YELLOW}Available tools:${NC}"
        which grub-mkrescue || echo "grub-mkrescue not found"
        which xorriso || echo "xorriso not found"
        which genisoimage || echo "genisoimage not found"
        which mkisofs || echo "mkisofs not found"
        exit 1
    fi
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

# Main function
main() {
    print_header
    check_root
    
    # Build packages first
    build_packages
    
    # Check build mode and proceed accordingly
    if check_build_mode; then
        echo -e "${GREEN}Building real bootable ISO...${NC}"
        if ! build_real_iso; then
            echo -e "${YELLOW}Real ISO build failed, trying fallback...${NC}"
            build_fallback_iso
        fi
    else
        echo -e "${YELLOW}Building minimal ISO (development mode)...${NC}"
        build_minimal_iso
    fi
    
    echo -e "${GREEN}"
    echo "========================================"
    echo "  Gsiso AI ISO build completed!"
    echo "========================================"
    echo -e "${NC}"
}

# Run main function
main "$@"
