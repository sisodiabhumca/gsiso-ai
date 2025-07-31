# Installation Guide

this guide will walk you through the process of installing gsiso ai linux on your system.

## Prerequisites

- A computer with x86_64 or ARMv7+ architecture
- At least 512MB of RAM (1GB recommended)
- 5GB of free disk space
- A USB drive with at least 2GB of space (for installation media)
- Internet connection (recommended)

## Downloading the ISO

1. Visit the [Releases](https://github.com/sisodiabhumca/gsiso-ai/releases) page
2. Download the latest stable ISO file
3. Verify the checksum (recommended):
   ```bash
   sha256sum gsiso-ai-x86_64-1.0.0.iso
   ```
   Compare the output with the checksum provided on the releases page.

## Creating Bootable Media

### On Linux/macOS

```bash
# Replace /dev/sdX with your USB device (be careful to select the correct one)
sudo dd if=gsiso-ai-x86_64-1.0.0.iso of=/dev/sdX bs=4M status=progress
sync
```

### On Windows

1. Download [Rufus](https://rufus.ie/)
2. Insert your USB drive
3. Open Rufus and select your USB device
4. Click "Select" and choose the downloaded ISO
5. Click "Start" and wait for the process to complete

## Booting from USB

1. Insert the bootable USB drive
2. Restart your computer
3. Enter the boot menu (usually F12, F2, or Del key during startup)
4. Select your USB drive from the boot menu

## Installation Process

1. **Welcome Screen**: Select your language and click "Continue"
2. **Keyboard Layout**: Choose your keyboard layout
3. **Partitioning**:
   - Automatic (recommended for most users)
   - Manual (for advanced users)
4. **User Setup**:
   - Enter your full name
   - Choose a username
   - Set a strong password
   - Optionally, set a hostname
5. **Summary**: Review your settings
6. **Installation**: Click "Install" to begin
7. **Completion**: Remove the installation media and reboot when prompted

## First Boot

After installation and reboot:

1. Log in with your username and password
2. Update your system:
   ```bash
   sudo gs-update
   ```
3. Install additional software (if needed):
   ```bash
   sudo gs-pkg install package-name
   ```

## Next Steps

- [Quick Start Guide](getting-started/quick-start)
- [User Guide](user-guide/package-management)
- [Troubleshooting](user-guide/troubleshooting)
