FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    bc \
    bison \
    build-essential \
    cpio \
    curl \
    dosfstools \
    fakeroot \
    file \
    flex \
    g++ \
    gcc \
    genisoimage \
    git \
    grub-efi-amd64-bin \
    grub-pc-bin \
    grub2-common \
    libc6-dev \
    libelf-dev \
    liblz4-tool \
    libncurses5-dev \
    libssl-dev \
    make \
    mtools \
    python3 \
    rsync \
    sudo \
    unzip \
    wget \
    xorriso \
    xz-utils \
    zstd \
    && rm -rf /var/lib/apt/lists/*

# Install BusyBox with static build
RUN set -ex \
    && cd /tmp \
    # Install static build dependencies
    && apt-get update \
    && apt-get install -y gcc-aarch64-linux-gnu gcc-arm-linux-gnueabihf \
    # Download and verify busybox
    && wget -q https://busybox.net/downloads/busybox-1.36.1.tar.bz2 \
    && wget -q https://busybox.net/downloads/busybox-1.36.1.tar.bz2.sha256 \
    && sha256sum -c busybox-1.36.1.tar.bz2.sha256 \
    # Extract and build
    && tar -xjf busybox-1.36.1.tar.bz2 \
    && cd busybox-1.36.1 \
    # Use static build configuration
    && make defconfig \
    # Enable static build
    && sed -i 's/^.*CONFIG_STATIC.*/CONFIG_STATIC=y/' .config \
    # Build with verbose output and save logs
    && make -j$(nproc) V=1 2>&1 | tee /tmp/busybox-build.log \
    || { cat /tmp/busybox-build.log; exit 1; } \
    # Install and verify
    && make install \
    && mkdir -p /bin \
    && cp ./busybox /bin/ \
    && /bin/busybox --help \
    # Clean up
    && cd /tmp \
    && rm -rf busybox-1.36.1* \
    && echo "BusyBox build and installation completed successfully"

WORKDIR /workspace

# Copy build scripts
COPY iso/ /workspace/iso/

# Set execute permissions
RUN chmod +x /workspace/iso/build.sh

# Set the entry point
ENTRYPOINT ["/bin/bash"]
