# Gsiso AI Linux ISO Builder

This directory contains the build system for creating a bootable Gsiso AI Linux ISO image.

## Prerequisites

- A Linux system (Ubuntu/Debian recommended)
- Root or sudo access
- At least 2GB of free disk space
- Internet connection for downloading packages

## Building the ISO

1. Make the build script executable:
   ```bash
   chmod +x build.sh
   ```

2. Run the build script as root:
   ```bash
   sudo ./build.sh
   ```

3. The built ISO will be available in the `output/` directory.

## Customization

### Changing the ISO Name/Version
Edit the `build_config` file to modify:
- `ISO_NAME`: The base name of the ISO file
- `VERSION`: Version number of the ISO
- `ARCH`: Target architecture (x86_64, i386, etc.)

### Adding Packages
Edit the `PACKAGES` variable in `build_config` to include additional packages.

### Custom Kernel
To use a custom kernel:
1. Build your kernel
2. Update the `KERNEL_IMAGE` path in `build_config`
3. Ensure the kernel has necessary modules built-in or include them in initramfs

## ISO Contents

The generated ISO will include:
- A minimal Linux environment
- BusyBox for basic utilities
- Basic device nodes and filesystems
- GRUB bootloader
- Custom init script

## Booting the ISO

The ISO can be booted in any virtual machine or burned to a USB drive using tools like:
- `dd` (Linux/macOS)
- Rufus (Windows)
- Etcher (Cross-platform)

## Troubleshooting

### Build Fails with Missing Dependencies
Install the required packages:
```bash
sudo apt-get update
sudo apt-get install grub2-common grub-pc-bin grub-efi-amd64-bin mtools xorriso squashfs-tools wget cpio genisoimage
```

### ISO Doesn't Boot
1. Verify the ISO checksum
2. Try recreating the bootable media
3. Check for BIOS/UEFI compatibility issues

## License

GPL-3.0 - See the [LICENSE](../LICENSE) file for details.
