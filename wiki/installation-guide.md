# Installation Guide

## Overview

This guide will walk you through the complete process of installing Gsiso AI Linux on your system. Gsiso AI Linux is a complete Linux distribution with XFCE4 desktop environment, package management, and professional installation experience.

## Prerequisites

### System Requirements

#### Minimum Requirements
- **CPU**: x86_64 processor
- **RAM**: 2GB
- **Storage**: 10GB free space
- **Graphics**: Any VGA-compatible card
- **Boot**: USB or CD/DVD drive

#### Recommended Requirements
- **CPU**: Multi-core x86_64 processor
- **RAM**: 4GB or more
- **Storage**: 20GB or more
- **Graphics**: Modern graphics card with 3D acceleration
- **Network**: Internet connection for updates

### Required Materials
- USB drive with at least 4GB storage (for bootable USB)
- Gsiso AI Linux ISO file
- Backup of important data (recommended)

## Download Gsiso AI Linux

### Step 1: Get the ISO File

1. **Visit GitHub Actions**: Go to [GitHub Actions](https://github.com/sisodiabhumca/gsiso-ai/actions)
2. **Find Latest Build**: Look for the most recent successful workflow run
3. **Download Artifact**: Click on the `gsiso-ai-bootable-iso` artifact
4. **Extract ISO**: Extract the downloaded file to get the `.iso` file

### Step 2: Verify Download (Optional but Recommended)

```bash
# Check file integrity (if checksums are provided)
sha256sum gsiso-ai-1.0.0-x86_64.iso
```

## Creating a Bootable USB Drive

### Method 1: Using dd Command (Linux/macOS)

1. **Insert USB Drive**: Connect your USB drive to the computer
2. **Identify Device**: Find your USB device name:
   ```bash
   # Linux
   lsblk
   
   # macOS
   diskutil list
   ```
3. **Unmount Drive**: Unmount the USB drive:
   ```bash
   # Linux
   sudo umount /dev/sdX
   
   # macOS
   diskutil unmountDisk /dev/diskX
   ```
4. **Create Bootable USB**:
   ```bash
   # Replace /dev/sdX with your USB device
   sudo dd if=gsiso-ai-1.0.0-x86_64.iso of=/dev/sdX bs=4M status=progress
   sync
   ```

### Method 2: Using Rufus (Windows)

1. **Download Rufus**: Get Rufus from [rufus.ie](https://rufus.ie/)
2. **Insert USB Drive**: Connect your USB drive
3. **Open Rufus**: Launch Rufus as administrator
4. **Select Device**: Choose your USB drive from the device dropdown
5. **Select ISO**: Click "SELECT" and choose the Gsiso AI ISO file
6. **Start Process**: Click "START" and wait for completion

### Method 3: Using Etcher (Cross-platform)

1. **Download Etcher**: Get Etcher from [balena.io/etcher](https://www.balena.io/etcher/)
2. **Launch Etcher**: Open the application
3. **Select ISO**: Click "Select image" and choose the Gsiso AI ISO
4. **Select Drive**: Choose your USB drive
5. **Flash**: Click "Flash!" and wait for completion

## Booting from USB

### Step 1: Prepare Your System

1. **Backup Data**: Ensure all important data is backed up
2. **Check BIOS/UEFI**: Note your current boot settings
3. **Disconnect Unnecessary Devices**: Remove external drives except the bootable USB

### Step 2: Boot from USB

1. **Insert USB Drive**: Connect the bootable USB drive
2. **Restart Computer**: Restart your computer
3. **Access Boot Menu**: Press the appropriate key during startup:
   - **F12**: Most common boot menu key
   - **F2/F10**: BIOS/UEFI setup
   - **ESC**: Alternative boot menu key
   - **Del**: Some systems use Delete key
4. **Select USB Drive**: Choose your USB drive from the boot menu
5. **Wait for Boot**: Allow the system to boot from USB

### Step 3: Choose Boot Option

When the GRUB menu appears, you'll see several options:

- **Gsiso AI Linux**: Normal boot with desktop (recommended)
- **Gsiso AI Linux (Safe Mode)**: Boot with basic graphics
- **Gsiso AI Linux (Text Mode)**: Command-line only

Select "Gsiso AI Linux" for normal installation.

## Live Environment

### Testing Before Installation

The system will boot into a live environment where you can:

1. **Test Hardware Compatibility**: Check if all your hardware works
2. **Browse the Web**: Use Firefox to test internet connectivity
3. **Try Applications**: Test LibreOffice, VLC, and other applications
4. **Check Desktop**: Experience the XFCE4 desktop environment

### System Information

You can check system information using:
```bash
# System information
gsiso-system-info

# Hardware details
lscpu
free -h
df -h
```

## Installation Process

### Step 1: Start Installation

1. **Double-click Install Icon**: Look for "Install Gsiso AI Linux" on the desktop
2. **Or Use Menu**: Applications → System → Install Gsiso AI Linux
3. **Wait for Installer**: The installer will load

### Step 2: Language and Keyboard

1. **Select Language**: Choose your preferred language
2. **Select Keyboard Layout**: Choose your keyboard layout
3. **Click Continue**: Proceed to the next step

### Step 3: Installation Type

Choose your installation method:

#### Option A: Erase Disk and Install (Recommended for New Installations)
- **Use**: When you want to replace your current OS
- **Warning**: This will delete all data on the selected disk
- **Best for**: Single OS installations

#### Option B: Install Alongside Existing OS (Dual Boot)
- **Use**: When you want to keep your current OS
- **Requires**: Free disk space
- **Best for**: Multi-OS setups

#### Option C: Something Else (Manual Partitioning)
- **Use**: For advanced users who want custom partitioning
- **Requires**: Knowledge of disk partitioning
- **Best for**: Custom setups

### Step 4: Disk Selection and Partitioning

#### For "Erase Disk and Install":
1. **Select Target Disk**: Choose the disk where you want to install
2. **Review Warning**: Confirm that you understand data will be erased
3. **Click Install Now**: Proceed with installation

#### For "Install Alongside":
1. **Select Free Space**: Choose unallocated space on your disk
2. **Adjust Partition Size**: Use the slider to allocate space
3. **Click Install Now**: Proceed with installation

#### For "Something Else":
1. **Create Partitions**: Set up your desired partition layout
2. **Set Mount Points**: Assign mount points to partitions
3. **Format Partitions**: Choose filesystem types
4. **Click Install Now**: Proceed with installation

### Step 5: User Setup

1. **Your Name**: Enter your full name
2. **Username**: Choose a username (default: gsiso)
3. **Password**: Set a strong password
4. **Confirm Password**: Re-enter your password
5. **Login Options**: Choose automatic or manual login
6. **Hostname**: Set a name for your computer (optional)

### Step 6: Installation Progress

The installer will:
1. **Copy System Files**: Transfer the operating system
2. **Install Bootloader**: Set up GRUB boot manager
3. **Configure System**: Set up users and services
4. **Install Applications**: Add desktop applications

**Note**: This process may take 10-30 minutes depending on your hardware.

### Step 7: Installation Complete

1. **Restart Now**: Click "Restart Now" when prompted
2. **Remove USB**: Remove the USB drive when the system shuts down
3. **Boot from Hard Drive**: The system will boot from your hard drive

## First Boot

### Step 1: Login

1. **Select User**: Choose your username from the login screen
2. **Enter Password**: Type your password
3. **Login**: Press Enter or click the login button

### Step 2: Welcome Screen

1. **Welcome Browser**: A welcome page will open automatically
2. **System Information**: Check your system details
3. **Close Welcome**: Close the browser when ready

### Step 3: Initial Setup

1. **Update System**: Run system updates:
   ```bash
   sudo gs-update
   ```
2. **Install Additional Packages** (Optional):
   ```bash
   sudo gs-pkg install gsiso-desktop
   sudo gs-pkg install gsiso-apps
   sudo gs-pkg install gsiso-tools
   ```

## Post-Installation

### System Configuration

1. **Network Setup**: Configure wireless networks if needed
2. **Display Settings**: Adjust screen resolution and settings
3. **Sound Configuration**: Test and configure audio
4. **Printer Setup**: Add printers if needed

### Package Management

1. **Update Package Lists**:
   ```bash
   sudo gs-pkg update
   ```
2. **Install Applications**:
   ```bash
   sudo gs-pkg install package-name
   ```
3. **List Installed Packages**:
   ```bash
   gs-pkg list-installed
   ```

### System Maintenance

1. **Regular Updates**:
   ```bash
   sudo gs-update
   ```
2. **System Information**:
   ```bash
   gsiso-system-info
   ```
3. **Disk Usage**:
   ```bash
   df -h
   ```

## Troubleshooting

### Common Installation Issues

#### Boot Issues
- **Problem**: System won't boot from USB
- **Solution**: Check BIOS/UEFI settings, disable Secure Boot

#### Display Problems
- **Problem**: Screen resolution issues or black screen
- **Solution**: Try Safe Mode boot option, update graphics drivers

#### Installation Fails
- **Problem**: Installer crashes or fails
- **Solution**: Check disk space, verify ISO integrity, try different USB drive

#### Network Issues
- **Problem**: No internet connection after installation
- **Solution**: Check network settings, install additional drivers

### Getting Help

If you encounter issues:

1. **Check Documentation**: Review this guide and other wiki pages
2. **Search Issues**: Look for similar problems in [GitHub Issues](https://github.com/sisodiabhumca/gsiso-ai/issues)
3. **Ask Community**: Post questions in [GitHub Discussions](https://github.com/sisodiabhumca/gsiso-ai/discussions)
4. **Report Bugs**: Create a new issue with detailed information

## Default Credentials

- **Username**: `gsiso`
- **Password**: `gsiso`
- **Root Password**: `root`
- **SSH**: Enabled by default

## Next Steps

After successful installation:

1. **Explore the Desktop**: Familiarize yourself with XFCE4
2. **Install Applications**: Add software using the package manager
3. **Customize Settings**: Adjust desktop appearance and behavior
4. **Join the Community**: Participate in discussions and contribute

## Support

For additional support:

- **Documentation**: [Wiki Home](https://github.com/sisodiabhumca/gsiso-ai/wiki)
- **Issues**: [GitHub Issues](https://github.com/sisodiabhumca/gsiso-ai/issues)
- **Discussions**: [GitHub Discussions](https://github.com/sisodiabhumca/gsiso-ai/discussions)
- **Repository**: [GitHub Repository](https://github.com/sisodiabhumca/gsiso-ai)

---

**Congratulations!** You have successfully installed Gsiso AI Linux. Enjoy your new Linux distribution! 🐧✨ 