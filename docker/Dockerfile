FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    SHELL=/bin/bash

# Update package lists
RUN apt-get update

# Install all required packages in one layer to reduce image size
RUN apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    make \
    file \
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
    grub-efi-amd64-bin \
    grub-pc-bin \
    grub2-common \
    genisoimage \
    mtools \
    xorriso \
    liblz4-tool \
    libncurses5-dev \
    python3 \
    rsync \
    sudo \
    unzip \
    wget \
    xz-utils \
    zstd \
    debootstrap \
    squashfs-tools \
    && rm -rf /var/lib/apt/lists/*

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /workspace

# Create directories first
RUN mkdir -p /workspace/iso /workspace/scripts /workspace/etc

# Copy build scripts (simple COPY commands)
COPY iso/ /workspace/iso/
COPY scripts/ /workspace/scripts/
COPY etc/ /workspace/etc/

# Set execute permissions
RUN chmod +x /workspace/iso/build.sh /workspace/iso/build_real.sh /workspace/iso/build_fallback.sh /workspace/scripts/*.sh

# Set the entry point
ENTRYPOINT ["/bin/bash"]
