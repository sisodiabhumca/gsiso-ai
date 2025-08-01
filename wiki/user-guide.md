# User Guide

## Welcome to Gsiso AI Linux!

This guide will help you get the most out of your Gsiso AI Linux system. Whether you're new to Linux or an experienced user, you'll find everything you need to know about using Gsiso AI Linux effectively.

## Getting Started

### First Login

After installation, you'll be greeted by the LightDM login screen:

1. **Select Your User**: Click on your username
2. **Enter Password**: Type your password
3. **Login**: Press Enter or click the login button

### Welcome Screen

On first boot, a welcome browser window will automatically open showing:
- Project information
- Quick links to documentation
- System status

You can close this window when ready to start using your system.

## Desktop Environment (XFCE4)

### Overview

Gsiso AI Linux uses the XFCE4 desktop environment, which is:
- **Lightweight**: Fast and efficient
- **Customizable**: Easy to personalize
- **User-friendly**: Intuitive interface
- **Stable**: Reliable and consistent

### Desktop Elements

#### Panel (Top Bar)
The top panel contains:
- **Applications Menu**: Access to all installed software
- **Quick Launcher**: Shortcuts to frequently used applications
- **Window List**: Shows open applications
- **System Tray**: Network, sound, clock, and system indicators

#### Desktop
The main desktop area features:
- **Desktop Icons**: Shortcuts to common locations
- **Right-click Menu**: Context menu for various actions
- **Workspace Switcher**: Multiple virtual desktops

### Basic Navigation

#### Applications Menu
- **Click the Applications icon** (top-left) to open the menu
- **Browse categories**: Access, Graphics, Internet, Office, etc.
- **Search**: Type to quickly find applications
- **Favorites**: Pin frequently used applications

#### File Manager (Thunar)
- **Open**: Click the folder icon or press `Ctrl+E`
- **Navigate**: Use the sidebar for quick access
- **View Options**: Change icon size, list view, etc.
- **Bookmarks**: Save frequently used locations

## Essential Applications

### Web Browser (Firefox)

Firefox is pre-installed and ready to use:

```bash
# Launch Firefox
firefox

# Or from Applications menu: Internet → Firefox
```

**Features**:
- Fast and secure browsing
- Built-in privacy protection
- Extensions support
- Sync across devices

### Office Suite (LibreOffice)

LibreOffice provides complete office functionality:

#### Writer (Word Processor)
```bash
libreoffice --writer
```
- Create and edit documents
- Rich formatting options
- Templates and styles
- Export to PDF

#### Calc (Spreadsheet)
```bash
libreoffice --calc
```
- Spreadsheet calculations
- Charts and graphs
- Data analysis tools
- Formula support

#### Impress (Presentations)
```bash
libreoffice --impress
```
- Create presentations
- Slide transitions
- Templates and themes
- Export to various formats

### Media Applications

#### VLC Media Player
```bash
vlc
```
- Play video and audio files
- Support for most formats
- Streaming capabilities
- Advanced playback controls

#### GIMP (Image Editor)
```bash
gimp
```
- Professional image editing
- Photo retouching
- Graphic design tools
- Plugin support

#### Audacity (Audio Editor)
```bash
audacity
```
- Record and edit audio
- Multiple tracks
- Effects and filters
- Export to various formats

### Development Tools

#### VS Code
```bash
code
```
- Modern code editor
- Syntax highlighting
- Extensions support
- Integrated terminal

#### Terminal
```bash
# Open terminal
xfce4-terminal

# Or press Ctrl+Alt+T
```

**Common Commands**:
```bash
# System information
gsiso-system-info

# Package management
gs-pkg list-installed
gs-pkg search package-name

# System updates
sudo gs-update

# File operations
ls -la
cd directory
cp file1 file2
mv file1 file2
rm file
```

## Package Management

### Using gs-pkg

Gsiso AI Linux includes a custom package manager:

#### Update Package Lists
```bash
sudo gs-pkg update
```

#### Search for Packages
```bash
gs-pkg search package-name
```

#### Install Packages
```bash
sudo gs-pkg install package-name
```

#### List Installed Packages
```bash
gs-pkg list-installed
```

#### Remove Packages
```bash
sudo gs-pkg remove package-name
```

### Available Packages

#### Core System Packages
- `gs-pkg`: Package manager
- `gs-update`: System updater
- `gsiso-init`: System initialization

#### Desktop and Applications
- `gsiso-desktop`: XFCE4 desktop environment
- `gsiso-apps`: Essential applications
- `gsiso-tools`: System utilities

### Installing Additional Software

#### From Ubuntu Repositories
```bash
# Update package lists
sudo apt update

# Install software
sudo apt install package-name

# Search for packages
apt search package-name
```

#### From Snap Store
```bash
# Install snapd (if not already installed)
sudo apt install snapd

# Install snap packages
sudo snap install package-name
```

#### From Flatpak
```bash
# Install flatpak (if not already installed)
sudo apt install flatpak

# Add flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install flatpak packages
flatpak install package-name
```

## System Configuration

### Display Settings

#### Change Resolution
1. **Settings** → **Display**
2. **Select Monitor**: Choose your display
3. **Resolution**: Set desired resolution
4. **Apply**: Test and confirm changes

#### Multiple Monitors
1. **Settings** → **Display**
2. **Detect Displays**: Find connected monitors
3. **Arrange**: Position monitors as needed
4. **Apply**: Confirm configuration

### Network Configuration

#### Wireless Networks
1. **Click Network Icon** (system tray)
2. **Select Network**: Choose your WiFi network
3. **Enter Password**: Provide network credentials
4. **Connect**: Wait for connection

#### Wired Networks
- **Automatic**: DHCP configuration (default)
- **Manual**: Configure IP settings if needed

#### Network Settings
```bash
# Check network status
ip addr show

# Test connectivity
ping google.com

# View network interfaces
nmcli device status
```

### Sound Configuration

#### Audio Settings
1. **Settings** → **Audio**
2. **Output**: Select audio device
3. **Volume**: Adjust system volume
4. **Test**: Play test sound

#### Audio Applications
```bash
# Volume control
pavucontrol

# Audio mixer
alsamixer
```

### Power Management

#### Power Settings
1. **Settings** → **Power Manager**
2. **Display**: Set screen timeout
3. **System**: Configure sleep settings
4. **Battery**: Optimize for battery life

#### Power Commands
```bash
# Suspend system
systemctl suspend

# Hibernate system
systemctl hibernate

# Shutdown
sudo shutdown -h now

# Restart
sudo reboot
```

## File Management

### Using Thunar File Manager

#### Basic Operations
- **Open**: Double-click files/folders
- **Copy**: `Ctrl+C` or right-click → Copy
- **Paste**: `Ctrl+V` or right-click → Paste
- **Cut**: `Ctrl+X` or right-click → Cut
- **Delete**: `Delete` key or right-click → Move to Trash
- **Rename**: `F2` or right-click → Rename

#### Advanced Features
- **Split View**: View two locations side by side
- **Bookmarks**: Save frequently used locations
- **Custom Actions**: Add custom right-click actions
- **Bulk Rename**: Rename multiple files at once

### File Permissions

#### Understanding Permissions
```bash
# View file permissions
ls -la filename

# Change permissions
chmod 755 filename

# Change ownership
sudo chown user:group filename
```

#### Common Permission Settings
- **755**: Executable (directories, scripts)
- **644**: Readable/writable by owner, readable by others
- **600**: Readable/writable by owner only

### Backup and Sync

#### Creating Backups
```bash
# Backup important files
cp -r ~/Documents ~/Backups/

# Create compressed archive
tar -czf backup.tar.gz ~/Documents/

# Sync with external drive
rsync -av ~/Documents/ /media/external/backup/
```

#### Cloud Storage
- **Nextcloud**: Self-hosted cloud storage
- **Dropbox**: Commercial cloud storage
- **Google Drive**: Web-based storage

## System Maintenance

### Regular Updates

#### System Updates
```bash
# Update system packages
sudo gs-update

# Update package lists
sudo apt update

# Upgrade installed packages
sudo apt upgrade

# Full system upgrade
sudo apt dist-upgrade
```

#### Kernel Updates
```bash
# Check current kernel
uname -r

# Install new kernel (if available)
sudo apt install linux-image-generic
```

### System Monitoring

#### System Information
```bash
# Comprehensive system info
gsiso-system-info

# CPU information
lscpu

# Memory usage
free -h

# Disk usage
df -h

# System load
uptime
```

#### Process Management
```bash
# View running processes
ps aux

# Interactive process viewer
htop

# Kill processes
kill process-id
```

### Disk Management

#### Disk Usage
```bash
# Check disk space
df -h

# Check directory sizes
du -sh directory/

# Find large files
find /path -type f -size +100M
```

#### Disk Cleanup
```bash
# Clean package cache
sudo apt clean

# Remove old kernels
sudo apt autoremove

# Clean temporary files
sudo rm -rf /tmp/*
```

## Customization

### Desktop Customization

#### Change Wallpaper
1. **Right-click Desktop** → **Desktop Settings**
2. **Background**: Choose new wallpaper
3. **Style**: Set wallpaper style (fill, stretch, etc.)

#### Panel Configuration
1. **Right-click Panel** → **Panel Preferences**
2. **Items**: Add/remove panel items
3. **Appearance**: Change panel style
4. **Behavior**: Configure panel behavior

#### Theme and Icons
1. **Settings** → **Appearance**
2. **Style**: Choose window theme
3. **Icons**: Select icon theme
4. **Fonts**: Configure system fonts

### Application Customization

#### Firefox Settings
- **Preferences**: Customize browser behavior
- **Add-ons**: Install extensions and themes
- **Privacy**: Configure privacy settings

#### Terminal Customization
```bash
# Edit terminal preferences
# Settings → Preferences → Appearance
```

#### File Manager Customization
- **View**: Change default view mode
- **Sidebar**: Configure sidebar content
- **Toolbar**: Customize toolbar buttons

## Troubleshooting

### Common Issues

#### System Won't Boot
1. **Check Boot Order**: Ensure hard drive is first
2. **Boot in Safe Mode**: Use recovery options
3. **Check Disk**: Run disk diagnostics
4. **Reinstall Bootloader**: Fix GRUB if needed

#### Applications Won't Start
1. **Check Dependencies**: Install missing packages
2. **Check Logs**: View application error logs
3. **Reinstall Application**: Remove and reinstall
4. **Check Permissions**: Verify file permissions

#### Network Problems
1. **Check Hardware**: Verify network adapter
2. **Check Drivers**: Install missing drivers
3. **Check Configuration**: Verify network settings
4. **Restart Services**: Restart network services

#### Performance Issues
1. **Check Resource Usage**: Monitor CPU/memory
2. **Close Unused Applications**: Free up resources
3. **Check Startup Programs**: Disable unnecessary autostart
4. **Update System**: Install latest updates

### Getting Help

#### Built-in Help
```bash
# Command help
man command-name

# Application help
application-name --help

# System documentation
info topic
```

#### Online Resources
- **Wiki**: [Gsiso AI Linux Wiki](https://github.com/sisodiabhumca/gsiso-ai/wiki)
- **Issues**: [GitHub Issues](https://github.com/sisodiabhumca/gsiso-ai/issues)
- **Discussions**: [GitHub Discussions](https://github.com/sisodiabhumca/gsiso-ai/discussions)
- **Documentation**: [Project Documentation](https://github.com/sisodiabhumca/gsiso-ai/tree/main/docs)

#### Community Support
- **Ask Questions**: Post in GitHub Discussions
- **Report Bugs**: Create GitHub Issues
- **Share Solutions**: Help other users
- **Contribute**: Improve documentation

## Advanced Usage

### Command Line Mastery

#### Essential Commands
```bash
# File operations
ls, cd, cp, mv, rm, mkdir, rmdir

# Text processing
cat, less, grep, sed, awk

# System administration
sudo, su, systemctl, journalctl

# Network tools
ping, wget, curl, ssh, scp
```

#### Shell Scripting
```bash
#!/bin/bash
# Create executable scripts
chmod +x script.sh
./script.sh
```

### System Administration

#### User Management
```bash
# Add user
sudo adduser username

# Change password
passwd username

# Add to groups
sudo usermod -aG group username
```

#### Service Management
```bash
# Start service
sudo systemctl start service-name

# Enable service
sudo systemctl enable service-name

# Check status
sudo systemctl status service-name
```

#### Log Management
```bash
# View system logs
journalctl

# View specific service logs
journalctl -u service-name

# Follow logs in real-time
journalctl -f
```

## Tips and Tricks

### Productivity Tips

#### Keyboard Shortcuts
- `Ctrl+Alt+T`: Open terminal
- `Ctrl+Alt+L`: Lock screen
- `Ctrl+Alt+Delete`: Logout menu
- `Alt+F2`: Run command dialog
- `Ctrl+Alt+Arrow`: Switch workspaces

#### Workspace Management
- **Multiple Workspaces**: Organize applications across workspaces
- **Workspace Switcher**: Use panel workspace switcher
- **Keyboard Navigation**: Use keyboard shortcuts for workspace switching

#### Application Launchers
- **Alt+F2**: Quick command execution
- **Applications Menu**: Browse installed software
- **Desktop Shortcuts**: Create custom shortcuts

### Performance Optimization

#### Startup Optimization
```bash
# Check startup applications
# Settings → Session and Startup → Application Autostart
```

#### Memory Management
```bash
# Monitor memory usage
free -h

# Clear memory cache
sudo sync && sudo sysctl -w vm.drop_caches=3
```

#### Disk Optimization
```bash
# Check disk health
sudo smartctl -a /dev/sda

# Optimize filesystem
sudo fsck /dev/sda
```

## Conclusion

Congratulations! You now have a comprehensive understanding of how to use Gsiso AI Linux effectively. This guide covers the essential aspects of using your system, from basic navigation to advanced customization.

### Next Steps

1. **Explore Further**: Try different applications and features
2. **Customize Your System**: Make it your own
3. **Join the Community**: Participate in discussions and contribute
4. **Stay Updated**: Keep your system current with regular updates

### Additional Resources

- **Installation Guide**: [Installation Guide](installation-guide.md)
- **Developer Guide**: [Developer Guide](developer-guide.md)
- **FAQ**: [Frequently Asked Questions](faq.md)
- **Project Home**: [GitHub Repository](https://github.com/sisodiabhumca/gsiso-ai)

---

**Enjoy using Gsiso AI Linux!** 🐧✨ 