# Package Management with gs-pkg

Gsiso AI Linux uses `gs-pkg`, a simple yet powerful package manager, to handle software installation, removal, and updates.

## Basic Commands

### Update Package Database
```bash
sudo gs-pkg update
```
This command updates the local package database with the latest package information from the repositories.

### Install Packages
```bash
# Install a single package
sudo gs-pkg install package-name

# Install multiple packages
sudo gs-pkg install package1 package2 package3

# Install a specific version
sudo gs-pkg install package-name=1.2.3
```

### Remove Packages
```bash
# Remove a package but keep configuration files
sudo gs-pkg remove package-name

# Remove a package and its configuration files
sudo gs-pkg purge package-name
```

### Upgrade Packages
```bash
# Upgrade all installed packages
sudo gs-pkg upgrade

# Upgrade a specific package
sudo gs-pkg upgrade package-name
```

### Search for Packages
```bash
# Search for a package
sudo gs-pkg search query

# Show package information
sudo gs-pkg info package-name
```

### List Installed Packages
```bash
# List all installed packages
gs-pkg list-installed

# List files owned by a package
gs-pkg list-files package-name
```

## Repository Management

### List Configured Repositories
```bash
sudo gs-pkg repo list
```

### Add a Repository
```bash
sudo gs-pkg repo add https://example.com/repo/
```

### Remove a Repository
```bash
sudo gs-pkg repo remove repository-name
```

## Package Management Examples

### Install Development Tools
```bash
sudo gs-pkg install build-essential git python3 python3-pip
```

### Install Web Server Stack
```bash
sudo gs-pkg install nginx mariadb php-fpm
```

### Clean Up
```bash
# Remove orphaned dependencies
sudo gs-pkg autoremove

# Clean package cache
sudo gs-pkg clean
```

## Troubleshooting

### Fix Broken Packages
```bash
sudo gs-pkg --fix-broken install
```

### Verify Package Integrity
```bash
sudo gs-pkg verify
```

### Check for Missing Dependencies
```bash
sudo gs-pkg check
```

## Advanced Usage

### Install Local Package Files
```bash
sudo gs-pkg install /path/to/package.gspkg
```

### Download Package Without Installing
```bash
gs-pkg download package-name
```

### Show Package Dependencies
```bash
gs-pkg depends package-name
```

### Show Reverse Dependencies
```bash
gs-pkg rdepends package-name
```

For more information, see the [Package Manager API Reference](../api-reference/package-manager-api).
