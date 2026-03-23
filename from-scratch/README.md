# From-Scratch Linux (Minimal, Installable ISO)

This is a minimal, from-scratch Linux OS build system that produces a bootable, installable ISO using:

- Linux kernel
- BusyBox userland
- Initramfs root filesystem
- GRUB bootloader

The result is a lightweight ISO that boots to a shell and can be installed by writing the ISO to USB or disk.

## Quick Start

```bash
cd from-scratch
./build.sh
```

The ISO will be produced at:

```
from-scratch/output/gsiso-minlinux.iso
```

## Requirements

You will need the following tools installed on the build machine:

- `bash`, `make`, `gcc`, `g++`, `bc`, `bison`, `flex`, `libssl-dev`, `libelf-dev`
- `curl` or `wget`
- `xorriso`, `grub-mkrescue`
- `cpio`, `gzip`, `xz`
- Optional: `qemu-system-x86_64` for smoke testing
- Optional: `grub-install`, `sgdisk`, `mkfs.vfat`, `mkfs.ext4` for disk install

On Ubuntu/Debian, install with:

```bash
sudo apt-get update
sudo apt-get install -y build-essential bc bison flex libssl-dev libelf-dev \
  xorriso grub-pc-bin grub-efi-amd64-bin cpio gzip xz-utils curl
```

## Configuration

Versions are pinned for reproducibility. Override by exporting env vars before running `build.sh`:

```bash
export KERNEL_VERSION=6.6.6
export BUSYBOX_VERSION=1.36.1
./build.sh
```

## What You Get

- Bootable ISO with GRUB
- Lightweight initramfs with BusyBox and a minimal init system
- Console login on `tty1`
- Package layers with `gs-pkg`
- QEMU smoke test script

## Notes

- This is a minimal foundation meant to be extended.
- Default kernel config is `defconfig` plus a small fragment in `config/kernel.fragment`.
- BusyBox is built static for a small, dependency-free initramfs.
- Building device nodes inside the initramfs may require root privileges on some systems; the build script will attempt `mknod` and continue if it fails.

## Output

- `output/gsiso-minlinux.iso` — bootable ISO
- `output/bzImage` — kernel image
- `output/initramfs.cpio.gz` — initramfs

## Install

To install to USB:

```bash
sudo dd if=output/gsiso-minlinux.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

Replace `/dev/sdX` with your USB device.

For a disk install from the build host (creates EFI + root partitions):

```bash
sudo ./scripts/install-to-disk.sh /dev/sdX
```

## QEMU Smoke Test

```bash
./scripts/qemu-test.sh
```

## Package Layers

Packages are simple `tar.gz` layers created from directories under `packages/`.
Builds happen automatically during `build-rootfs.sh`, and packages are embedded at `/packages` inside the ISO.

Example:

```bash
gs-pkg list
gs-pkg install hello
hello
```
