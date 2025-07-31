# System Configuration

Gsiso AI Linux provides a simple yet powerful configuration system. This guide covers the main configuration files and tools.

## Main Configuration File

The primary configuration file is located at `/etc/gsiso.conf`. This file contains system-wide settings.

### Example Configuration
```ini
[System]
NAME="Gsiso AI Linux"
VERSION="1.0.0"
CODENAME="Stable"
ARCH="x86_64"

[Network]
HOSTNAME="gsiso-ai"
DOMAINNAME="local"

[Updates]
CHECK_UPDATES=1
AUTO_DOWNLOAD=0
AUTO_INSTALL_SECURITY=1
```

## Network Configuration

### Static IP Configuration
Edit `/etc/network/interfaces`:
```
auto eth0
iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 8.8.8.8 8.8.4.4
```

### DHCP Configuration
```
auto eth0
iface eth0 inet dhcp
```

## User Management

### Add a New User
```bash
# Add a new user
sudo useradd -m -G wheel,users username

# Set password
sudo passwd username
```

### Add User to Sudoers
Edit `/etc/sudoers` using `visudo`:
```
username ALL=(ALL) ALL
```

## System Services

### List Available Services
```bash
ls /etc/init.d/
```

### Manage Services
```bash
# Start a service
sudo service servicename start

# Stop a service
sudo service servicename stop

# Restart a service
sudo service servicename restart

# Check service status
sudo service servicename status
```

## Logging

### View System Logs
```bash
# View system logs
journalctl -xe

# View kernel logs
dmesg | less

# View authentication logs
sudo tail -f /var/log/auth.log
```

## Time and Date

### Set Timezone
```bash
sudo timedatectl set-timezone Region/City
```

### Enable NTP
```bash
sudo systemctl enable --now systemd-timesyncd
```

## Package Management

See the [Package Management](package-management) guide for details on managing software packages.

## Security

### Firewall Configuration
Gsiso AI uses `ufw` (Uncomplicated Firewall):

```bash
# Enable firewall
sudo ufw enable

# Allow SSH
sudo ufw allow ssh

# Allow HTTP/HTTPS
sudo ufw allow http
sudo ufw allow https

# View firewall status
sudo ufw status
```

### Automatic Security Updates
Enable automatic security updates by editing `/etc/gsiso.conf`:
```ini
[Updates]
AUTO_INSTALL_SECURITY=1
```

## Troubleshooting

### Check System Resources
```bash
# CPU and memory usage
top

# Disk usage
df -h

# Memory usage
free -m
```

### Check Network
```bash
# Network interfaces
ip addr show

# Network connections
ss -tulpn

# Test connectivity
ping -c 4 google.com
```

For more advanced configuration, refer to the [Administrator's Guide](../admin-guide/).
