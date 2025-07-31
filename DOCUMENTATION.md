# Gsiso AI Linux Documentation

## Table of Contents
1. [Overview](#overview)
2. [System Architecture](#system-architecture)
3. [Package Management](#package-management)
4. [System Initialization](#system-initialization)
5. [Configuration](#configuration)
6. [Development Guide](#development-guide)
7. [Troubleshooting](#troubleshooting)
8. [Contributing](#contributing)
9. [License](#license)

## Overview

Gsiso AI is a lightweight, fast, and user-friendly Linux distribution designed for modern hardware while maintaining compatibility with older systems. It's built with simplicity, security, and performance in mind.

### Key Features
- **Minimal Base**: Small footprint with essential components
- **Fast Boot**: Optimized initialization process
- **Easy Package Management**: Simple package manager with dependency resolution
- **Modular Design**: Customizable to specific needs
- **Security Focused**: Built with security best practices

## System Architecture

### Kernel
- Based on the latest stable Linux kernel
- Minimal set of modules enabled by default
- Optimized for performance and security

### Init System
- Uses `runit` as the init system
- Simple and reliable service management
- Fast boot times

### Filesystem Hierarchy
```
/
├── bin/           # Essential user binaries
├── boot/          # Boot loader files
├── dev/           # Device files
├── etc/           # System configuration
├── home/          # User home directories
├── lib/           # Essential shared libraries
├── mnt/           # Mount points
├── opt/           # Optional software
├── proc/          # Process information
├── root/          # Root user's home
├── run/           # Runtime variable data
├── sbin/          # System binaries
├── srv/           # Site-specific data
├── sys/           # System information
├── tmp/           # Temporary files
└── var/           # Variable data
```

## Package Management

### gs-pkg
Gsiso AI uses `gs-pkg` as its package manager. It's a simple yet powerful tool for managing software packages.

#### Basic Commands
```bash
# Install a package
gs-pkg install <package>

# Remove a package
gs-pkg remove <package>

# Update package database
gs-pkg update

# Upgrade all packages
gs-pkg upgrade

# Search for a package
gs-pkg search <query>

# List installed packages
gs-pkg list-installed
```

### Package Format
Packages are distributed as `.tar.xz` archives with the following structure:
```
package-version/
├── usr/
│   ├── bin/       # User binaries
│   ├── lib/       # Libraries
│   └── share/     # Shared data
├── etc/           # Configuration files
└── .PKGINFO       # Package metadata
```

## System Initialization

### Boot Process
1. Bootloader loads the kernel and initramfs
2. Kernel mounts the root filesystem
3. `gsiso-init` script initializes the system
4. Essential services are started
5. Login prompt is displayed

### Service Management
Services are managed using `runit`:
```bash
# Start a service
sv start <service>

# Stop a service
sv stop <service>

# Restart a service
sv restart <service>

# Check service status
sv status <service>
```

## Configuration

### System Configuration
Main configuration file: `/etc/gsiso.conf`

### Network Configuration
- Static IP: Edit `/etc/network/interfaces`
- DHCP: Enabled by default
- Hostname: Set in `/etc/hostname`

### User Management
```bash
# Add a user
useradd -m <username>

# Set password
passwd <username>

# Add to sudoers
usermod -aG wheel <username>
```

## Development Guide

### Building Packages
1. Create a package directory
2. Add source files and build script
3. Create a `.PKGINFO` file
4. Build with `tar -cJf package-version.tar.xz *`

### Contributing
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Troubleshooting

### Common Issues
- **No network**: Check interface status with `ip link`
- **Boot failure**: Boot with `single` parameter
- **Package issues**: Run `gs-pkg update`

### Logs
- System logs: `/var/log/messages`
- Package manager: `/var/log/gs-pkg.log`
- Boot logs: `journalctl -b`

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

Gsiso AI is licensed under the [GNU General Public License v3.0](LICENSE).
