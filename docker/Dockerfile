FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    grub2-common \
    grub-pc-bin \
    grub-efi-amd64-bin \
    mtools \
    xorriso \
    squashfs-tools \
    wget \
    cpio \
    genisoimage \
    git \
    file \
    dosfstools \
    fakeroot \
    gcc \
    libc6-dev \
    liblz4-tool \
    make \
    python3 \
    rsync \
    sudo \
    unzip \
    wget \
    xz-utils \
    zstd \
    && rm -rf /var/lib/apt/lists/*

# Install BusyBox
RUN wget https://busybox.net/downloads/busybox-1.36.1.tar.bz2 \
    && tar -xjf busybox-*.tar.bz2 \
    && cd busybox-* \
    && make defconfig \
    && make -j$(nproc) \
    && make install \
    && cd .. \
    && rm -rf busybox-* \
    && cp /bin/busybox /bin/busybox

WORKDIR /workspace

# Copy build scripts
COPY iso/ /workspace/iso/

# Set execute permissions
RUN chmod +x /workspace/iso/build.sh

# Set the entry point
ENTRYPOINT ["/bin/bash"]
