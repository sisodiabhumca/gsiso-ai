<div align="center">
  <img src="assets/img/logo.jpg" alt="gsiso ai logo" width="200">
  <h1>gsiso ai - lightweight linux distribution</h1>
  
  [![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
  [![GitHub Release](https://img.shields.io/github/v/release/sisodiabhumca/gsiso-ai)](https://github.com/sisodiabhumca/gsiso-ai/releases)
  [![GitHub Issues](https://img.shields.io/github/issues/sisodiabhumca/gsiso-ai)](https://github.com/sisodiabhumca/gsiso-ai/issues)
  [![Build Status](https://github.com/sisodiabhumca/gsiso-ai/workflows/Build%20ISO/badge.svg)](https://github.com/sisodiabhumca/gsiso-ai/actions)
</div>

## ⚠️ **Development Status**

**gsiso ai is currently in active development and is NOT ready for production use.**

This is a proof-of-concept Linux distribution that demonstrates the basic structure and tooling for a lightweight Linux system. The current version includes:

- ✅ **Project structure and documentation**
- ✅ **Package management framework**
- ✅ **CI/CD pipeline for ISO building**
- ✅ **Basic system scripts and configuration**
- ⚠️ **Minimal bootable ISO (development only)**
- ❌ **Full Linux distribution (not yet implemented)**

## Features

- **Lightweight**: Designed for minimal resource usage
- **Modular**: Add or remove components as needed
- **Open Source**: Fully transparent and community-driven
- **Custom Package Manager**: `gs-pkg` for software management
- **CI/CD Pipeline**: Automated ISO building and testing

## System Requirements

- CPU: x86_64 or ARMv7+ (32-bit and 64-bit support)
- RAM: 512MB minimum (1GB recommended)
- Storage: 5GB disk space minimum
- Graphics: Any VGA-compatible card
- Boot: USB or CD/DVD drive for installation

## Quick Start

### For Developers

If you want to contribute or experiment:

```bash
# Clone the repository
git clone https://github.com/sisodiabhumca/gsiso-ai.git
cd gsiso-ai

# Test the Docker build
./test-docker-build.sh

# Build the ISO (requires Docker)
./iso/build.sh
```

### For Users

**Note**: The current ISO is a minimal development build and not suitable for daily use.

1. **Download**: Get the latest build from [GitHub Actions](https://github.com/sisodiabhumca/gsiso-ai/actions)
2. **Test**: Use in a virtual machine for testing
3. **Report Issues**: Help improve the project by reporting bugs

## Project Structure

```
gsiso-ai/
├── iso/              # ISO building scripts and configuration
├── scripts/          # System scripts (gs-pkg, gs-update, etc.)
├── packages/         # Package definitions and lists
├── docs/             # Documentation and website
├── wiki/             # Wiki pages
├── etc/              # System configuration files
├── docker/           # Docker build configuration
└── .github/          # GitHub Actions workflows
```

## Documentation

- **User Guide**: [Wiki](https://github.com/sisodiabhumca/gsiso-ai/wiki)
- **Installation**: [INSTALL.md](INSTALL.md)
- **Development**: [DOCUMENTATION.md](DOCUMENTATION.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)

## Contributing

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) to get started.

**Areas that need help:**
- Kernel configuration and optimization
- Package repository setup
- System initialization improvements
- Documentation and testing
- User interface development

## Roadmap

### Phase 1: Foundation ✅
- [x] Project structure
- [x] Basic documentation
- [x] Package management framework
- [x] CI/CD pipeline

### Phase 2: Core System (In Progress)
- [ ] Bootable ISO with real kernel
- [ ] Basic filesystem and init system
- [ ] Package repository
- [ ] System configuration tools

### Phase 3: User Experience
- [ ] Installation wizard
- [ ] Desktop environment
- [ ] Application ecosystem
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
- All open-source contributors and maintainers
- The Linux community for inspiration and tools

## Support

- **Issues**: [GitHub Issues](https://github.com/sisodiabhumca/gsiso-ai/issues)
- **Discussions**: [GitHub Discussions](https://github.com/sisodiabhumca/gsiso-ai/discussions)
- **Wiki**: [Project Wiki](https://github.com/sisodiabhumca/gsiso-ai/wiki)
