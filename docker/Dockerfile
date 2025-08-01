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

# Update package lists
RUN apt-get update

# Install essential build tools first
RUN apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    make \
    file \
    && rm -rf /var/lib/apt/lists/*

# Install remaining build dependencies in groups
RUN apt-get update && apt-get install -y --no-install-recommends \
    bc \
    bison \
    cpio \
    curl \
    dosfstools \
    fakeroot \
    flex \
    git \
    libc6-dev \
    libelf-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install GRUB and ISO tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    grub-efi-amd64-bin \
    grub-pc-bin \
    grub2-common \
    genisoimage \
    mtools \
    xorriso \
    && rm -rf /var/lib/apt/lists/*

# Install remaining utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    liblz4-tool \
    libncurses5-dev \
    python3 \
    rsync \
    sudo \
    unzip \
    wget \
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
