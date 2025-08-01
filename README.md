<div align="center">
  <img src="assets/img/logo.jpg" alt="gsiso ai logo" width="200">
  <h1>gsiso ai - lightweight linux distribution</h1>
  
  [![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
  [![GitHub Release](https://img.shields.io/github/v/release/sisodiabhumca/gsiso-ai)](https://github.com/sisodiabhumca/gsiso-ai/releases)
  [![GitHub Issues](https://img.shields.io/github/issues/sisodiabhumca/gsiso-ai)](https://github.com/sisodiabhumca/gsiso-ai/issues)
  [![Build Status](https://github.com/sisodiabhumca/gsiso-ai/workflows/Build%20ISO/badge.svg)](https://github.com/sisodiabhumca/gsiso-ai/actions)
</div>

## 🚀 **Development Status - ALPHA RELEASE**

**Gsiso AI Linux now includes real bootable ISO creation capabilities!**

This project has evolved from a framework to a functional Linux distribution with:

- ✅ **Real Bootable ISO**: Creates actual bootable Linux systems
- ✅ **Complete Package Management**: Functional package repository and manager
- ✅ **System Initialization**: Proper system setup and configuration
- ✅ **CI/CD Pipeline**: Automated building and testing
- ✅ **Documentation**: Comprehensive guides and documentation

## Features

- **Real Linux Distribution**: Based on Ubuntu with custom components
- **Bootable ISO**: Creates actual installable Linux systems
- **Package Management**: `gs-pkg` with real package repository
- **System Tools**: Custom initialization and update scripts
- **Modular Design**: Add or remove components as needed
- **Open Source**: Fully transparent and community-driven

## System Requirements

- CPU: x86_64 or ARMv7+ (32-bit and 64-bit support)
- RAM: 512MB minimum (1GB recommended)
- Storage: 5GB disk space minimum
- Graphics: Any VGA-compatible card
- Boot: USB or CD/DVD drive for installation

## Quick Start

### For Users

**Download and Test:**
1. **Get the ISO**: Download from [GitHub Actions](https://github.com/sisodiabhumca/gsiso-ai/actions)
2. **Test in VM**: Use VirtualBox or VMware for testing
3. **Create Bootable USB**: Use Etcher or dd command
4. **Install**: Follow the installation wizard

**Default Credentials:**
- Username: `gsiso`
- Password: `gsiso`
- Root Password: `root`

### For Developers

**Build from Source:**
```bash
# Clone the repository
git clone https://github.com/sisodiabhumca/gsiso-ai.git
cd gsiso-ai

# Test the Docker build
./test-docker-build.sh

# Build the real bootable ISO (requires Docker)
./iso/build.sh
```

**Package Development:**
```bash
# Build packages
sudo ./scripts/create-packages.sh

# Test package manager
sudo ./scripts/gs-pkg install gs-pkg
```

## Project Structure

```
gsiso-ai/
├── iso/              # ISO building scripts (real + minimal)
│   ├── build.sh      # Main build orchestrator
│   ├── build_real.sh # Real bootable ISO builder
│   └── build_config  # Build configuration
├── scripts/          # System scripts and tools
│   ├── gs-pkg        # Package manager
│   ├── gs-update     # System updater
│   ├── gsiso-init    # System initializer
│   └── create-packages.sh # Package builder
├── packages/         # Package definitions
├── repo/             # Package repository (generated)
├── docs/             # Documentation and website
├── wiki/             # Wiki pages
├── etc/              # System configuration files
├── docker/           # Docker build configuration
└── .github/          # GitHub Actions workflows
```

## What's New

### **Real Bootable ISO Creation**
- Creates actual Ubuntu-based Linux systems
- Includes real kernel, init system, and filesystem
- Bootable with GRUB bootloader
- Supports both UEFI and legacy BIOS

### **Functional Package Management**
- Real package repository with actual packages
- `gs-pkg` package manager with dependency handling
- Package building and distribution system
- Local and remote repository support

### **System Initialization**
- Proper system setup on first boot
- User creation and configuration
- Network and service configuration
- Security and access control

## Documentation

- **User Guide**: [Wiki](https://github.com/sisodiabhumca/gsiso-ai/wiki)
- **Installation**: [INSTALL.md](INSTALL.md)
- **Development**: [DOCUMENTATION.md](DOCUMENTATION.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Release Status**: [RELEASE_CHECKLIST.md](RELEASE_CHECKLIST.md)

## Contributing

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) to get started.

**Areas that need help:**
- Desktop environment integration
- Application ecosystem expansion
- Testing and quality assurance
- Documentation improvements
- Performance optimization

## Roadmap

### Phase 1: Foundation ✅
- [x] Project structure
- [x] Basic documentation
- [x] Package management framework
- [x] CI/CD pipeline

### Phase 2: Core System ✅
- [x] Bootable ISO with real kernel
- [x] Basic filesystem and init system
- [x] Package repository
- [x] System configuration tools

### Phase 3: User Experience (In Progress)
- [ ] Desktop environment integration
- [ ] Application ecosystem
- [ ] Installation wizard improvements
- [ ] User documentation

### Phase 4: Production Ready
- [ ] Security hardening
- [ ] Performance optimization
- [ ] Comprehensive testing
- [ ] Release management

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Linux Kernel Team
- Ubuntu Project for base system
- All open-source contributors and maintainers
- The Linux community for inspiration and tools

## Support

- **Issues**: [GitHub Issues](https://github.com/sisodiabhumca/gsiso-ai/issues)
- **Discussions**: [GitHub Discussions](https://github.com/sisodiabhumca/gsiso-ai/discussions)
- **Wiki**: [Project Wiki](https://github.com/sisodiabhumca/gsiso-ai/wiki)
