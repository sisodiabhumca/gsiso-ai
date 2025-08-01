# Gsiso AI Linux Installation Guide

This guide will walk you through the process of installing Gsiso AI Linux on your system.

## Prerequisites

- A computer with x86_64 architecture
- At least 2GB of RAM (4GB recommended)
- At least 10GB of free disk space
- A USB drive with at least 4GB of storage
- An active internet connection (recommended)

## Downloading Gsiso AI Linux

### Option 1: Download from GitHub Actions (Recommended)
1. Go to [GitHub Actions](https://github.com/sisodiabhumca/gsiso-ai/actions)
2. Click on the latest successful workflow run
3. Download the `gsiso-ai-bootable-iso` artifact
4. Extract the ISO file

### Option 2: Build from Source
```bash
# Clone the repository
git clone https://github.com/sisodiabhumca/gsiso-ai.git
cd gsiso-ai

# Build the ISO (requires Docker)
./iso/build.sh
```

## Creating a Bootable USB

### On Linux/macOS

1. Insert your USB drive
2. Identify your USB device name:
   ```bash
   # Linux
   lsblk
   
   # macOS
   diskutil list
   ```

3. Create bootable USB:
   ```bash
   # Replace /dev/sdX with your USB device
   sudo dd if=gsiso-ai-1.0.0-x86_64.iso of=/dev/sdX bs=4M status=progress
   sync
   ```

4. Eject the USB drive safely

### On Windows

1. Download and install [Rufus](https://rufus.ie/)
2. Insert your USB drive
3. Open Rufus and select your USB device
4. Click "SELECT" and choose the Gsiso AI ISO file
5. Click "START" and wait for the process to complete

## Installation Process

### 1. Boot from USB

1. Insert the bootable USB drive into your computer
2. Restart your computer and enter the boot menu (usually F12, F2, or DEL key)
3. Select your USB drive from the boot menu
4. Choose your preferred boot option:
   - **Gsiso AI Linux** - Normal boot with desktop
   - **Gsiso AI Linux (Safe Mode)** - Boot with basic graphics
   - **Gsiso AI Linux (Text Mode)** - Command-line only

### 2. Live System

The system will boot into a live environment where you can:
- Test the system before installation
- Browse the web with Firefox
- Use office applications with LibreOffice
- Try the XFCE4 desktop environment

### 3. Installation

1. **Start Installation**: Double-click the "Install Gsiso AI Linux" icon on the desktop
2. **Language Selection**: Choose your preferred language
3. **Keyboard Layout**: Select your keyboard layout
4. **Installation Type**:
   - **Erase disk and install** (recommended for new installations)
   - **Install alongside existing OS** (for dual-boot)
   - **Something else** (manual partitioning)
5. **User Setup**:
   - Enter your full name
   - Choose a username (default: gsiso)
   - Set a password
   - Optionally, set a hostname
6. **Installation**: Click "Install" to begin
7. **Completion**: Remove the installation media and reboot when prompted

## First Boot

After installation and reboot:

1. **Login**: Use your username and password
2. **Desktop Environment**: The XFCE4 desktop will start automatically
3. **Welcome Screen**: A welcome browser window will open
4. **System Updates**: Run system updates:
   ```bash
   sudo gs-update
   ```

## Default Credentials

- **Username**: `gsiso`
- **Password**: `gsiso`
- **Root Password**: `root`

## Post-Installation

### Installing Additional Software

Use the package manager to install additional software:

```bash
# Install desktop applications
sudo gs-pkg install gsiso-desktop

# Install essential applications
sudo gs-pkg install gsiso-apps

# Install system tools
sudo gs-pkg install gsiso-tools
```

### System Information

Check your system information:

```bash
# System information tool
gsiso-system-info

# Package information
gs-pkg list-installed
```

### Desktop Customization

The XFCE4 desktop environment is highly customizable:

1. **Panel**: Right-click on the panel to add/remove items
2. **Desktop**: Right-click on desktop to change background
3. **Settings**: Use XFCE4 Settings Manager for customization
4. **Themes**: Install additional themes and icons

## Features Included

### Desktop Environment
- **XFCE4**: Lightweight and fast desktop environment
- **LightDM**: Display manager for login
- **Plymouth**: Boot splash screen

### Applications
- **Web Browser**: Firefox
- **Office Suite**: LibreOffice (Writer, Calc, Impress)
- **Media**: VLC media player, GIMP image editor
- **Development**: VS Code, Git, Python
- **System Tools**: GParted, Htop, Neofetch

### System Tools
- **Package Manager**: gs-pkg for software management
- **System Updates**: gs-update for system maintenance
- **System Info**: gsiso-system-info for system details

## Troubleshooting

### Common Issues

1. **Boot Issues**:
   - Try booting in Safe Mode
   - Use Text Mode for troubleshooting
   - Check BIOS/UEFI settings

2. **Display Problems**:
   - Use "nomodeset" kernel parameter
   - Try different graphics drivers
   - Check monitor settings

3. **Network Issues**:
   - Connect via Ethernet for initial setup
   - Check network manager settings
   - Verify DHCP configuration

4. **Package Installation**:
   - Run `gs-pkg update` first
   - Check internet connection
   - Verify package repository

### Getting Help

- **Documentation**: [Wiki](https://github.com/sisodiabhumca/gsiso-ai/wiki)
- **Issues**: [GitHub Issues](https://github.com/sisodiabhumca/gsiso-ai/issues)
- **Discussions**: [GitHub Discussions](https://github.com/sisodiabhumca/gsiso-ai/discussions)

## Uninstallation

To remove Gsiso AI Linux:

1. Boot from a live USB of another OS
2. Delete the Gsiso AI partitions
3. Update your bootloader configuration

For dual-boot systems, you may need to repair the bootloader of your other OS.

## System Requirements

### Minimum Requirements
- **CPU**: x86_64 processor
- **RAM**: 2GB
- **Storage**: 10GB
- **Graphics**: Any VGA-compatible card

### Recommended Requirements
- **CPU**: Multi-core x86_64 processor
- **RAM**: 4GB or more
- **Storage**: 20GB or more
- **Graphics**: Modern graphics card with 3D acceleration

## Support

For additional support and information:

- **Website**: [GitHub Repository](https://github.com/sisodiabhumca/gsiso-ai)
- **Documentation**: [Project Wiki](https://github.com/sisodiabhumca/gsiso-ai/wiki)
- **Community**: [GitHub Discussions](https://github.com/sisodiabhumca/gsiso-ai/discussions)
