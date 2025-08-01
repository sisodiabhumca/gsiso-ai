FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    SHELL=/bin/bash

# Install base dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    busybox-static \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set up the shell
RUN ln -sf /bin/busybox /bin/sh \
    && ln -sf /bin/busybox /bin/bash \
    && /bin/busybox --install /bin

# Install build dependencies in a separate layer
RUN apt-get update && apt-get install -y --no-install-recommends \
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

WORKDIR /workspace

# Copy build scripts
COPY iso/ /workspace/iso/

# Set execute permissions
RUN chmod +x /workspace/iso/build.sh

# Set the entry point
ENTRYPOINT ["/bin/bash"]
