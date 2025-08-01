# Frequently Asked Questions (FAQ)

## General Questions

### What is Gsiso AI Linux?

**Gsiso AI Linux** is a complete, modern Linux distribution based on Ubuntu 22.04 LTS. It features:

- **XFCE4 Desktop Environment**: Lightweight and customizable desktop
- **Real Bootable ISO**: Actual installable Linux distribution
- **Custom Package Management**: Built-in package manager with 6 comprehensive packages
- **Professional Installation**: Graphical installer with multiple options
- **Complete Applications**: Firefox, LibreOffice, VLC, GIMP, VS Code, and more

### Is Gsiso AI Linux ready for production use?

**Current Status**: Gsiso AI Linux is in **ALPHA RELEASE** (v1.0.0). While it's a complete, functional Linux distribution, it's still under active development.

**What's Ready**:
- ✅ Complete bootable ISO creation
- ✅ XFCE4 desktop environment
- ✅ Package management system
- ✅ Essential applications
- ✅ Professional installation process

**What's in Development**:
- 🔄 Additional applications and packages
- 🔄 Enhanced system tools
- 🔄 Performance optimizations
- 🔄 Extended hardware support

### How is Gsiso AI Linux different from other distributions?

**Key Differentiators**:
- **Custom Package System**: Built-in `gs-pkg` package manager
- **Integrated Tools**: `gs-update` for system updates, `gsiso-init` for initialization
- **Complete Desktop**: Pre-configured XFCE4 with essential applications
- **Modern Base**: Based on Ubuntu 22.04 LTS for stability and compatibility
- **Community-Driven**: Open development with transparent processes

## Installation Questions

### What are the system requirements?

**Minimum Requirements**:
- **CPU**: x86_64 processor
- **RAM**: 2GB
- **Storage**: 10GB free space
- **Graphics**: Any VGA-compatible card
- **Boot**: USB or CD/DVD drive

**Recommended Requirements**:
- **CPU**: Multi-core x86_64 processor
- **RAM**: 4GB or more
- **Storage**: 20GB or more
- **Graphics**: Modern graphics card with 3D acceleration
- **Network**: Internet connection for updates

### How do I download Gsiso AI Linux?

1. **Visit GitHub Actions**: Go to [GitHub Actions](https://github.com/sisodiabhumca/gsiso-ai/actions)
2. **Find Latest Build**: Look for the most recent successful workflow run
3. **Download Artifact**: Click on the `gsiso-ai-bootable-iso` artifact
4. **Extract ISO**: Extract the downloaded file to get the `.iso` file

### How do I create a bootable USB drive?

**Method 1: Using dd Command (Linux/macOS)**
```bash
# Identify your USB device
lsblk  # Linux
diskutil list  # macOS

# Create bootable USB (replace /dev/sdX with your device)
sudo dd if=gsiso-ai-1.0.0-x86_64.iso of=/dev/sdX bs=4M status=progress
sync
```

**Method 2: Using Rufus (Windows)**
1. Download Rufus from [rufus.ie](https://rufus.ie/)
2. Insert USB drive
3. Open Rufus as administrator
4. Select your USB drive and ISO file
5. Click "START"

**Method 3: Using Etcher (Cross-platform)**
1. Download Etcher from [balena.io/etcher](https://www.balena.io/etcher/)
2. Launch Etcher
3. Select ISO and USB drive
4. Click "Flash!"

### Can I install Gsiso AI Linux alongside Windows?

**Yes!** Gsiso AI Linux supports dual-boot installation:

1. **Prepare**: Create free space on your hard drive
2. **Boot**: Boot from USB drive
3. **Install**: Choose "Install alongside existing OS"
4. **Configure**: Set partition sizes and proceed
5. **Complete**: Restart and choose OS at boot

**Important**: Always backup your data before dual-boot installation.

### What are the default login credentials?

- **Username**: `gsiso`
- **Password**: `gsiso`
- **Root Password**: `root`
- **SSH**: Enabled by default

**Security Note**: Change these passwords after first login for security.

## Usage Questions

### How do I install additional software?

**Using gs-pkg (Custom Package Manager)**:
```bash
# Update package lists
sudo gs-pkg update

# Search for packages
gs-pkg search package-name

# Install packages
sudo gs-pkg install package-name

# List installed packages
gs-pkg list-installed
```

**Using Ubuntu Repositories**:
```bash
# Update package lists
sudo apt update

# Install software
sudo apt install package-name

# Search for packages
apt search package-name
```

**Using Snap Store**:
```bash
# Install snapd (if not already installed)
sudo apt install snapd

# Install snap packages
sudo snap install package-name
```

### How do I update the system?

**Using gs-update (Recommended)**:
```bash
sudo gs-update
```

**Using apt (Traditional)**:
```bash
sudo apt update
sudo apt upgrade
```

**Automatic Updates**: You can configure automatic updates in System Settings.

### How do I customize the desktop?

**Change Wallpaper**:
1. Right-click desktop → Desktop Settings
2. Choose new wallpaper
3. Set wallpaper style

**Panel Configuration**:
1. Right-click panel → Panel Preferences
2. Add/remove panel items
3. Change panel style and behavior

**Theme and Icons**:
1. Settings → Appearance
2. Choose window theme
3. Select icon theme
4. Configure fonts

### How do I access the terminal?

**Multiple Ways**:
- **Keyboard Shortcut**: `Ctrl+Alt+T`
- **Applications Menu**: Accessories → Terminal
- **Right-click Menu**: Open in Terminal (in file manager)
- **Run Dialog**: `Alt+F2`, then type `xfce4-terminal`

### What applications are included?

**Web Browser**: Firefox
**Office Suite**: LibreOffice (Writer, Calc, Impress)
**Media Player**: VLC
**Image Editor**: GIMP
**Audio Editor**: Audacity
**Code Editor**: VS Code
**File Manager**: Thunar
**Terminal**: XFCE4 Terminal
**System Tools**: Various utilities and tools

## Technical Questions

### What package format does Gsiso AI Linux use?

Gsiso AI Linux uses a **custom package format**:
- **Format**: `.tar.xz` archives with metadata
- **Manager**: `gs-pkg` custom package manager
- **Repository**: Local package repository
- **Metadata**: `.PKGINFO` files for package information

**Compatibility**: The system also supports standard Ubuntu packages via `apt`.

### How do I check system information?

**Using gsiso-system-info**:
```bash
gsiso-system-info
```

**Using standard commands**:
```bash
# CPU information
lscpu

# Memory usage
free -h

# Disk usage
df -h

# System load
uptime

# Kernel version
uname -r
```

### How do I troubleshoot boot issues?

**Common Solutions**:

1. **Check Boot Order**: Ensure hard drive is first in BIOS
2. **Disable Secure Boot**: May be required for some systems
3. **Try Safe Mode**: Use "Gsiso AI Linux (Safe Mode)" boot option
4. **Check Disk**: Run disk diagnostics
5. **Reinstall Bootloader**: Fix GRUB if needed

**Advanced Troubleshooting**:
```bash
# Check GRUB configuration
sudo grub-install /dev/sda
sudo update-grub

# Check disk health
sudo smartctl -a /dev/sda

# Check filesystem
sudo fsck /dev/sda
```

### How do I enable SSH access?

**SSH is enabled by default**, but you can configure it:

```bash
# Check SSH status
sudo systemctl status ssh

# Enable SSH (if disabled)
sudo systemctl enable ssh
sudo systemctl start ssh

# Configure SSH
sudo nano /etc/ssh/sshd_config

# Restart SSH service
sudo systemctl restart ssh
```

**Connect from another computer**:
```bash
ssh gsiso@your-computer-ip
```

## Development Questions

### How can I contribute to Gsiso AI Linux?

**Ways to Contribute**:
1. **Report Bugs**: Create issues on GitHub
2. **Suggest Features**: Use GitHub Discussions
3. **Write Documentation**: Improve wiki pages
4. **Create Packages**: Build custom packages
5. **Submit Code**: Create pull requests
6. **Test Builds**: Test and report issues

**Getting Started**:
- Read the [Developer Guide](developer-guide.md)
- Check [Contributing Guidelines](https://github.com/sisodiabhumca/gsiso-ai/blob/main/CONTRIBUTING.md)
- Join [GitHub Discussions](https://github.com/sisodiabhumca/gsiso-ai/discussions)

### How do I build Gsiso AI Linux from source?

**Using Docker (Recommended)**:
```bash
# Clone repository
git clone https://github.com/sisodiabhumca/gsiso-ai.git
cd gsiso-ai

# Build Docker image
docker build -t gsiso-builder -f docker/Dockerfile .

# Run build process
docker run --rm --privileged -v $(pwd):/workspace gsiso-builder ./build.sh
```

**Direct Build**:
```bash
# Install dependencies
sudo apt install debootstrap squashfs-tools xorriso grub-pc-bin

# Run build
cd iso
sudo ./build.sh
```

### How do I create custom packages?

**Using Package Builder**:
```bash
sudo ./scripts/create-packages.sh
```

**Manual Creation**:
```bash
# Create package structure
mkdir -p my-package/usr/bin
cp my-script my-package/usr/bin/
chmod +x my-package/usr/bin/my-script

# Create metadata
cat > my-package/.PKGINFO << EOF
pkgname = my-package
pkgver = 1.0.0
pkgdesc = My custom package
depend = bash
EOF

# Create package
cd my-package
tar -cJf ../my-package-1.0.0.tar.xz .
```

## Troubleshooting Questions

### The system won't boot from USB

**Common Solutions**:
1. **Check BIOS Settings**: Enable USB boot, disable Secure Boot
2. **Try Different USB**: Some USB drives may not work
3. **Check ISO Integrity**: Verify download wasn't corrupted
4. **Try Different USB Port**: Use USB 2.0 port if available
5. **Check Boot Menu**: Press correct key (F12, F2, ESC, etc.)

### Applications won't start

**Troubleshooting Steps**:
1. **Check Dependencies**: Install missing packages
2. **Check Logs**: View application error logs
3. **Reinstall Application**: Remove and reinstall
4. **Check Permissions**: Verify file permissions
5. **Try Terminal**: Run application from terminal to see errors

### Network connection issues

**Solutions**:
1. **Check Hardware**: Verify network adapter is working
2. **Check Drivers**: Install missing network drivers
3. **Check Configuration**: Verify network settings
4. **Restart Services**: Restart network services
5. **Check Firewall**: Configure firewall settings

### Performance problems

**Optimization Steps**:
1. **Check Resource Usage**: Monitor CPU/memory usage
2. **Close Unused Applications**: Free up system resources
3. **Check Startup Programs**: Disable unnecessary autostart
4. **Update System**: Install latest updates
5. **Check Disk Space**: Ensure sufficient free space

### Package installation fails

**Troubleshooting**:
1. **Update Package Lists**: `sudo gs-pkg update`
2. **Check Dependencies**: Verify all dependencies are available
3. **Check Permissions**: Ensure you have necessary permissions
4. **Check Logs**: Review package manager logs
5. **Try Alternative Method**: Use `apt` instead of `gs-pkg`

## Community Questions

### Where can I get help?

**Support Channels**:
- **Documentation**: [Wiki](https://github.com/sisodiabhumca/gsiso-ai/wiki)
- **Issues**: [GitHub Issues](https://github.com/sisodiabhumca/gsiso-ai/issues)
- **Discussions**: [GitHub Discussions](https://github.com/sisodiabhumca/gsiso-ai/discussions)
- **Repository**: [GitHub Repository](https://github.com/sisodiabhumca/gsiso-ai)

### How do I report a bug?

**Bug Report Process**:
1. **Search Existing Issues**: Check if bug is already reported
2. **Create New Issue**: Use GitHub Issues
3. **Provide Details**: Include system info, steps to reproduce
4. **Attach Logs**: Include relevant error logs
5. **Follow Up**: Respond to questions and provide additional info

**Bug Report Template**:
```
**Description**: Brief description of the issue
**Steps to Reproduce**: 
1. Step 1
2. Step 2
3. Step 3

**Expected Behavior**: What should happen
**Actual Behavior**: What actually happens
**System Information**:
- Gsiso AI Linux version:
- Hardware:
- Steps taken:

**Additional Information**: Any other relevant details
```

### How do I request a feature?

**Feature Request Process**:
1. **Search Discussions**: Check if feature is already discussed
2. **Create Discussion**: Use GitHub Discussions
3. **Describe Feature**: Explain what you want and why
4. **Provide Examples**: Show similar implementations if possible
5. **Engage Community**: Discuss with other users

### Can I use Gsiso AI Linux for commercial purposes?

**License Information**:
- **Base System**: Ubuntu 22.04 LTS (GPL and other open source licenses)
- **Custom Components**: GPL v3 and similar open source licenses
- **Commercial Use**: Generally allowed under open source licenses
- **Attribution**: May be required for some components

**Recommendation**: Review specific license terms for components you plan to use commercially.

## Future Questions

### What's planned for future releases?

**Upcoming Features**:
- **Additional Applications**: More software packages
- **Enhanced Desktop**: Improved desktop experience
- **Better Hardware Support**: Extended device compatibility
- **Performance Optimizations**: System speed improvements
- **Additional Package Sources**: More software repositories

### Will there be different editions?

**Potential Editions**:
- **Desktop Edition**: Full desktop experience (current)
- **Server Edition**: Server-focused installation
- **Minimal Edition**: Lightweight installation
- **Development Edition**: Development tools included

### How often are releases made?

**Release Schedule**:
- **Major Releases**: Every 6-12 months
- **Minor Updates**: Monthly or as needed
- **Security Updates**: As vulnerabilities are discovered
- **Development Builds**: Continuous integration builds

### Can I help with development?

**Absolutely!** We welcome contributions:

1. **Start Small**: Begin with documentation or testing
2. **Choose Area**: Pick an area that interests you
3. **Join Community**: Participate in discussions
4. **Submit Changes**: Create pull requests
5. **Stay Active**: Regular participation helps

**Areas Needing Help**:
- Documentation improvements
- Package creation
- Testing and bug reports
- Feature development
- Community support

---

## Still Have Questions?

If your question isn't answered here:

1. **Search the Wiki**: Check other wiki pages
2. **Search Issues**: Look for similar questions in GitHub Issues
3. **Ask in Discussions**: Post your question in GitHub Discussions
4. **Create an Issue**: If it's a bug or feature request

**Remember**: The Gsiso AI Linux community is here to help! Don't hesitate to ask questions and contribute to the project. 🐧✨ 