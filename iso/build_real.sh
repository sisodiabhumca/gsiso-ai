#!/bin/bash

# Gsiso AI Linux - Real Bootable ISO Builder
# This script creates an actual bootable Linux distribution

set -e

# Configuration
VERSION="1.0.0"
ARCH="x86_64"
ISO_NAME="gsiso-ai-${VERSION}-${ARCH}"
BUILD_DIR="$(pwd)/build"
ROOTFS_DIR="${BUILD_DIR}/rootfs"
ISO_DIR="${BUILD_DIR}/iso"
OUTPUT_DIR="$(pwd)/output"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_header() {
    echo -e "${GREEN}"
    echo "========================================"
    echo "  Gsiso AI Linux - Real ISO Builder"
    echo "  Version: ${VERSION}"
    echo "  Architecture: ${ARCH}"
    echo "========================================"
    echo -e "${NC}"
}

# Check dependencies
check_dependencies() {
    echo -e "${YELLOW}Checking dependencies...${NC}"
    
    local deps=("debootstrap" "squashfs-tools" "xorriso" "grub-pc-bin" "grub-efi-amd64-bin")
    local missing=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing+=("$dep")
        fi
    done
    
    if [ ${#missing[@]} -gt 0 ]; then
        echo -e "${RED}Missing dependencies: ${missing[*]}${NC}"
        echo -e "${YELLOW}Install with: sudo apt-get install ${missing[*]}${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}All dependencies found${NC}"
}

# Create base filesystem
create_base_filesystem() {
    echo -e "${YELLOW}Creating base filesystem...${NC}"
    
    # Clean previous build
    rm -rf "${BUILD_DIR}"
    mkdir -p "${BUILD_DIR}" "${ROOTFS_DIR}" "${ISO_DIR}" "${OUTPUT_DIR}"
    
    # Create minimal Ubuntu-based filesystem
    debootstrap --arch=amd64 --variant=minbase focal "${ROOTFS_DIR}" http://archive.ubuntu.com/ubuntu/
    
    echo -e "${GREEN}Base filesystem created${NC}"
}

# Install essential packages
install_essential_packages() {
    echo -e "${YELLOW}Installing essential packages...${NC}"
    
    # Mount necessary filesystems
    mount --bind /dev "${ROOTFS_DIR}/dev"
    mount --bind /proc "${ROOTFS_DIR}/proc"
    mount --bind /sys "${ROOTFS_DIR}/sys"
    
    # Install core packages
    chroot "${ROOTFS_DIR}" apt-get update
    chroot "${ROOTFS_DIR}" apt-get install -y \
        linux-image-generic \
        systemd \
        systemd-sysv \
        network-manager \
        openssh-server \
        sudo \
        nano \
        curl \
        wget \
        git \
        build-essential \
        python3 \
        python3-pip
    
    # Clean up
    chroot "${ROOTFS_DIR}" apt-get clean
    chroot "${ROOTFS_DIR}" apt-get autoremove -y
    
    # Unmount
    umount "${ROOTFS_DIR}/dev"
    umount "${ROOTFS_DIR}/proc"
    umount "${ROOTFS_DIR}/sys"
    
    echo -e "${GREEN}Essential packages installed${NC}"
}

# Install desktop environment
install_desktop_environment() {
    echo -e "${YELLOW}Installing desktop environment...${NC}"
    
    # Mount necessary filesystems
    mount --bind /dev "${ROOTFS_DIR}/dev"
    mount --bind /proc "${ROOTFS_DIR}/proc"
    mount --bind /sys "${ROOTFS_DIR}/sys"
    
    # Install XFCE4 desktop environment
    chroot "${ROOTFS_DIR}" apt-get update
    chroot "${ROOTFS_DIR}" apt-get install -y \
        xfce4 \
        xfce4-goodies \
        lightdm \
        lightdm-gtk-greeter \
        plymouth \
        plymouth-theme-ubuntu-logo
    
    # Install additional desktop applications
    chroot "${ROOTFS_DIR}" apt-get install -y \
        firefox \
        libreoffice-writer \
        libreoffice-calc \
        gimp \
        vlc \
        transmission-gtk \
        gedit \
        file-roller \
        gnome-calculator \
        gnome-screenshot \
        thunar \
        gparted \
        htop \
        neofetch \
        tree \
        wget \
        curl \
        git \
        python3-pip \
        code
    
    # Clean up
    chroot "${ROOTFS_DIR}" apt-get clean
    chroot "${ROOTFS_DIR}" apt-get autoremove -y
    
    # Unmount
    umount "${ROOTFS_DIR}/dev"
    umount "${ROOTFS_DIR}/proc"
    umount "${ROOTFS_DIR}/sys"
    
    echo -e "${GREEN}Desktop environment installed${NC}"
}

# Configure system
configure_system() {
    echo -e "${YELLOW}Configuring system...${NC}"
    
    # Set hostname
    echo "gsiso-ai" > "${ROOTFS_DIR}/etc/hostname"
    
    # Configure network
    cat > "${ROOTFS_DIR}/etc/netplan/01-netcfg.yaml" << 'EOF'
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: true
EOF
    
    # Configure users
    chroot "${ROOTFS_DIR}" useradd -m -s /bin/bash gsiso
    echo "gsiso:gsiso" | chroot "${ROOTFS_DIR}" chpasswd
    chroot "${ROOTFS_DIR}" usermod -aG sudo gsiso
    
    # Configure sudo
    echo "gsiso ALL=(ALL) NOPASSWD:ALL" > "${ROOTFS_DIR}/etc/sudoers.d/gsiso"
    
    # Set root password
    echo "root:root" | chroot "${ROOTFS_DIR}" chpasswd
    
    # Configure SSH
    chroot "${ROOTFS_DIR}" systemctl enable ssh
    
    # Configure systemd
    chroot "${ROOTFS_DIR}" systemctl enable systemd-networkd
    chroot "${ROOTFS_DIR}" systemctl enable systemd-resolved
    
    # Configure display manager
    chroot "${ROOTFS_DIR}" systemctl enable lightdm
    
    echo -e "${GREEN}System configured${NC}"
}

# Configure desktop environment
configure_desktop_environment() {
    echo -e "${YELLOW}Configuring desktop environment...${NC}"
    
    # Create desktop autostart
    mkdir -p "${ROOTFS_DIR}/etc/xdg/autostart"
    cat > "${ROOTFS_DIR}/etc/xdg/autostart/gsiso-welcome.desktop" << 'EOF'
[Desktop Entry]
Type=Application
Name=Gsiso AI Welcome
Comment=Welcome to Gsiso AI Linux
Exec=firefox https://github.com/sisodiabhumca/gsiso-ai
Terminal=false
X-GNOME-Autostart-enabled=true
EOF

    # Create desktop shortcuts
    mkdir -p "${ROOTFS_DIR}/home/gsiso/Desktop"
    cat > "${ROOTFS_DIR}/home/gsiso/Desktop/Gsiso AI Welcome.desktop" << 'EOF'
[Desktop Entry]
Type=Application
Name=Gsiso AI Welcome
Comment=Welcome to Gsiso AI Linux
Exec=firefox https://github.com/sisodiabhumca/gsiso-ai
Icon=firefox
Terminal=false
EOF

    # Set proper permissions
    chroot "${ROOTFS_DIR}" chown -R gsiso:gsiso /home/gsiso/Desktop
    chroot "${ROOTFS_DIR}" chmod +x /home/gsiso/Desktop/*.desktop
    
    # Configure XFCE4 settings
    mkdir -p "${ROOTFS_DIR}/home/gsiso/.config/xfce4/xfconf/xfce-perchannel-xml"
    cat > "${ROOTFS_DIR}/home/gsiso/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-desktop" version="1.0">
  <property name="desktop-icons" type="empty">
    <property name="file-icons" type="empty">
      <property name="show-home" type="bool" value="true"/>
      <property name="show-trash" type="bool" value="true"/>
    </property>
  </property>
</channel>
EOF

    chroot "${ROOTFS_DIR}" chown -R gsiso:gsiso /home/gsiso/.config
    
    echo -e "${GREEN}Desktop environment configured${NC}"
}

# Create ISO structure
create_iso_structure() {
    echo -e "${YELLOW}Creating ISO structure...${NC}"
    
    # Create squashfs
    mksquashfs "${ROOTFS_DIR}" "${ISO_DIR}/filesystem.squashfs" -comp xz
    
    # Copy kernel and initrd
    cp "${ROOTFS_DIR}/boot/vmlinuz-"* "${ISO_DIR}/vmlinuz"
    cp "${ROOTFS_DIR}/boot/initrd.img-"* "${ISO_DIR}/initrd"
    
    # Create GRUB configuration
    mkdir -p "${ISO_DIR}/boot/grub"
    cat > "${ISO_DIR}/boot/grub/grub.cfg" << 'EOF'
set timeout=10
set default=0

menuentry "Gsiso AI Linux" {
    linux /vmlinuz boot=casper quiet splash
    initrd /initrd
}

menuentry "Gsiso AI Linux (Safe Mode)" {
    linux /vmlinuz boot=casper nomodeset
    initrd /initrd
}

menuentry "Gsiso AI Linux (Text Mode)" {
    linux /vmlinuz boot=casper text
    initrd /initrd
}
EOF
    
    echo -e "${GREEN}ISO structure created${NC}"
}

# Create bootable ISO
create_bootable_iso() {
    echo -e "${YELLOW}Creating bootable ISO...${NC}"
    
    # Create ISO with GRUB
    grub-mkrescue -o "${OUTPUT_DIR}/${ISO_NAME}.iso" "${ISO_DIR}"
    
    echo -e "${GREEN}Bootable ISO created: ${OUTPUT_DIR}/${ISO_NAME}.iso${NC}"
    echo -e "${GREEN}Size: $(du -h "${OUTPUT_DIR}/${ISO_NAME}.iso" | cut -f1)${NC}"
}

# Main build process
main() {
    print_header
    check_dependencies
    create_base_filesystem
    install_essential_packages
    install_desktop_environment
    configure_system
    configure_desktop_environment
    create_iso_structure
    create_bootable_iso
    
    echo -e "${GREEN}"
    echo "========================================"
    echo "  Build completed successfully!"
    echo "  ISO: ${OUTPUT_DIR}/${ISO_NAME}.iso"
    echo ""
    echo "  Features included:"
    echo "  - Ubuntu-based Linux system"
    echo "  - XFCE4 desktop environment"
    echo "  - Firefox, LibreOffice, GIMP, VLC"
    echo "  - Development tools (VS Code, Git)"
    echo "  - System utilities and tools"
    echo ""
    echo "  Default login: gsiso / gsiso"
    echo "  Root password: root"
    echo "========================================"
    echo -e "${NC}"
}

# Run main function
main "$@" 