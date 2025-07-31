# Gsiso AI - Lightweight Linux Distribution

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

Gsiso AI is a lightweight, user-friendly Linux distribution designed for efficiency and ease of use. Built with minimalism in mind, it's perfect for older hardware, embedded systems, or anyone who values speed and simplicity.

## Features

- **Lightweight**: Optimized for performance on low-resource systems
- **Easy to Use**: Intuitive interface and simple configuration
- **Modular**: Add or remove components as needed
- **Secure**: Regular updates and security patches
- **Open Source**: Fully transparent and community-driven

## System Requirements

- CPU: x86_64 or ARMv7+ (32-bit and 64-bit support)
- RAM: 512MB minimum (1GB recommended)
- Storage: 5GB disk space minimum
- Graphics: Any VGA-compatible card
- Boot: USB or CD/DVD drive for installation

## Quick Start

### Download

Download the latest stable release from our [Releases page](https://github.com/sisodiabhumca/gsiso-ai/releases/latest).

### Installation

1. **Create Bootable USB** (choose one method):
   - **Recommended**: Use [Etcher](https://www.balena.io/etcher/)
   - **Using dd** (Linux/macOS):
     ```bash
     # Replace /dev/sdX with your USB device
     dd if=gsiso-ai-1.0.0-x86_64.iso of=/dev/sdX bs=4M status=progress
     ```
   - **Using Rufus** (Windows): [Download Rufus](https://rufus.ie/)

2. **Boot from USB**:
   - Restart your computer
   - Enter boot menu (usually F12, F2, or DEL during startup)
   - Select your USB drive

3. **Follow the on-screen installation wizard**

### Building from Source

If you want to build from source:

```bash
# Clone the repository
git clone https://github.com/sisodiabhumca/gsiso-ai.git
cd gsiso-ai

# Build the ISO (requires Docker)
./iso/build.sh
```

## Documentation

For detailed documentation, please visit our [Wiki](https://github.com/sisodiabhumca/gsiso-ai/wiki).

## Contributing

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) to get started.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Linux Kernel Team
- All open-source contributors and maintainers
