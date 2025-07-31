# System Architecture Overview

This document provides a high-level overview of the Gsiso AI Linux architecture, its components, and how they interact.

## Design Philosophy

Gsiso AI Linux is built with the following principles in mind:

- **Simplicity**: Minimal, clean, and maintainable code
- **Performance**: Optimized for speed and efficiency
- **Security**: Secure by default
- **Modularity**: Components are loosely coupled and replaceable

## System Components

### 1. Kernel
- Based on the latest stable Linux kernel
- Minimal set of modules enabled by default
- Optimized for performance and security

### 2. Init System
- Uses `runit` as the init system
- Simple and reliable service management
- Fast boot times

### 3. Package Management
- `gs-pkg` package manager
- Handles software installation, removal, and updates
- Supports dependency resolution
- Repository management

### 4. Core Utilities
- BusyBox for essential command-line utilities
- Custom system scripts
- Configuration management

### 5. Security
- User and permission management
- Firewall (ufw)
- AppArmor for application sandboxing
- Regular security updates

## Boot Process

1. **BIOS/UEFI**: System firmware initializes hardware
2. **Bootloader**: GRUB2 loads the kernel and initramfs
3. **Kernel**: Linux kernel initializes hardware and mounts root filesystem
4. **Init**: `runit` starts the system initialization
5. **Services**: System services are started in parallel
6. **Login**: Login prompt or display manager starts

## Filesystem Hierarchy

```
/
├── bin/           # Essential user binaries
├── boot/          # Boot loader files
├── dev/           # Device files
├── etc/           # System configuration
│   └── gsiso/     # Gsiso-specific configuration
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
    ├── cache/     # Cached data
    ├── lib/       # State information
    ├── log/       # Log files
    └── spool/     # Queued tasks
```

## Process Management

Gsiso AI uses `runit` for service management:

- **Service Directories**: `/etc/sv/`
- **Service Control**: `sv` command
- **Logging**: `svlogd` for service logging

## Network Stack

- **NetworkManager**: Network configuration
- **systemd-networkd**: Alternative network configuration
- **iptables/nftables**: Firewall
- **NetworkManager**: Wireless networking

## Security Model

1. **User Privileges**: Principle of least privilege
2. **AppArmor**: Mandatory access control
3. **Firewall**: Default deny policy
4. **Updates**: Regular security updates

## Package Management

### Repository Structure
```
/repository/
├── x86_64/         # x86_64 packages
│   ├── base/       # Base system packages
│   ├── extra/      # Additional software
│   └── community/  # Community-maintained packages
└── aarch64/        # ARM packages
```

### Package Format
- `.gs` package format
- Signed packages for security
- Dependency resolution

## Development Tools

- GCC compiler
- GNU Make
- Git
- Debugging tools (gdb, strace, etc.)

## Monitoring and Logging

- `journald`: System logging
- `logrotate`: Log rotation
- `htop`: Process monitoring
- `netdata`: System monitoring

## Customization

Gsiso AI is designed to be highly customizable:

1. **Themes**: GTK, icon, and cursor themes
2. **Window Managers**: Multiple options available
3. **Services**: Enable/disable as needed
4. **Kernel**: Custom kernel builds supported

## Performance Considerations

- Minimal default services
- Optimized kernel configuration
- Efficient resource usage
- SSD optimizations

## Next Steps

- [Boot Process](boot-process.md)
- [Package Management Architecture](package-management.md)
- [Security Model](security-model.md)
