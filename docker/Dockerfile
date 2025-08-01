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

# Install BusyBox using package manager
RUN set -ex \
    && apt-get update \
    && apt-get install -y busybox-static \
    && mkdir -p /bin \
    && ln -sf /bin/busybox /bin/sh \
    && /bin/busybox --help \
    && echo "BusyBox installation completed successfully"

WORKDIR /workspace

# Copy build scripts
COPY iso/ /workspace/iso/

# Set execute permissions
RUN chmod +x /workspace/iso/build.sh

# Set the entry point
ENTRYPOINT ["/bin/bash"]
