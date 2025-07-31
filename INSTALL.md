# gsiso ai linux installation guide

this guide will walk you through the process of installing gsiso ai linux on your system.

## Prerequisites

- A computer with x86_64 or ARMv7+ architecture
- At least 512MB of RAM (1GB recommended)
- At least 5GB of free disk space
- A USB drive with at least 2GB of storage
- An active internet connection (recommended)

## Creating a Bootable USB

### On Linux/macOS

1. Insert your USB drive
2. Identify your USB device name using `lsblk` or `diskutil list`
3. Run the following command (replace `/dev/sdX` with your USB device):
   ```bash
   sudo dd if=gsiso-ai-x86_64.iso of=/dev/sdX bs=4M status=progress
   sync
   ```
4. Eject the USB drive safely

### On Windows

1. Download and install [Rufus](https://rufus.ie/)
2. Insert your USB drive
3. Open Rufus and select your USB device
4. click "select" and choose the gsiso ai iso file
5. Click "Start" and wait for the process to complete

## Installation Process

1. Insert the bootable USB drive into your computer
2. Restart your computer and enter the boot menu (usually F12, F2, or DEL key)
3. Select your USB drive from the boot menu
4. the gsiso ai installer will start automatically

### Installation Wizard

1. **Welcome Screen**: Select your language and click "Continue"
2. **Keyboard Layout**: Choose your keyboard layout
3. **Partitioning**:
   - Automatic (recommended for most users)
   - Manual (for advanced users)
4. **User Setup**:
   - Enter your full name
   - Choose a username
   - Set a strong password
   - Optionally, set a hostname for your computer
5. **Summary**: Review your settings
6. **Installation**: Click "Install" to begin
7. **Completion**: Remove the installation media and reboot when prompted

## First Boot

After installation and reboot:

1. Log in with your username and password
2. The system will guide you through initial setup
3. Update your system:
   ```bash
   sudo gs-update
   ```

## Post-Installation

### Recommended Software

Install additional software using the package manager:

```bash
# Install web browser
sudo gs-pkg install firefox

# Install office suite
sudo gs-pkg install libreoffice

# Install media codecs
sudo gs-pkg install gstreamer-plugins-bad gstreamer-plugins-ugly
```

### System Updates

Keep your system up to date with:

```bash
gs-update
```

## Troubleshooting

### Common Issues

1. **Boot issues**: Try booting in compatibility mode
2. **Display problems**: Use the "nomodeset" kernel parameter
3. **WiFi not working**: Connect via Ethernet for initial setup

### Getting Help

- Documentation: https://gsiso-ai.org/docs
- Forums: https://forum.gsiso-ai.org
- IRC: #gsiso-ai on Libera.Chat

## Uninstallation

to remove gsiso ai linux:

1. Boot from a live USB of another OS
2. delete the gsiso ai partitions
3. Update your bootloader configuration

For dual-boot systems, you may need to repair the bootloader of your other OS.
