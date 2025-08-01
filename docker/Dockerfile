FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    SHELL=/bin/bash

# Function to retry apt-get commands
RUN echo '#!/bin/bash\n\
retry() {\n\
    local max_attempts=3\n\
    local delay=5\n\
    local attempt=1\n\
    while [ $attempt -le $max_attempts ]; do\n\
        echo "Attempt $attempt of $max_attempts"\n\
        if "$@"; then\n\
            return 0\n\
        fi\n\
        echo "Command failed. Retrying in $delay seconds..."\n\
        sleep $delay\n\
        attempt=$((attempt + 1))\n\
        delay=$((delay * 2))\n\
    done\n\
    echo "Command failed after $max_attempts attempts"\n\
    return 1\n\
}\n\
export -f retry' > /usr/local/bin/retry-apt && chmod +x /usr/local/bin/retry-apt

# Update package lists with retry
RUN . /usr/local/bin/retry-apt && retry apt-get update

# Install base dependencies with retry
RUN . /usr/local/bin/retry-apt && retry apt-get install -y --no-install-recommends \
    bash \
    busybox-static \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set up the shell
RUN ln -sf /bin/busybox /bin/sh \
    && ln -sf /bin/busybox /bin/bash \
    && /bin/busybox --install /bin

# Update package lists again
RUN . /usr/local/bin/retry-apt && retry apt-get update

# Install essential build tools first (smallest group)
RUN . /usr/local/bin/retry-apt && retry apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    make \
    file \
    && rm -rf /var/lib/apt/lists/*

# Update and install core build dependencies
RUN . /usr/local/bin/retry-apt && retry apt-get update && retry apt-get install -y --no-install-recommends \
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

# Update and install GRUB and ISO tools
RUN . /usr/local/bin/retry-apt && retry apt-get update && retry apt-get install -y --no-install-recommends \
    grub-efi-amd64-bin \
    grub-pc-bin \
    grub2-common \
    genisoimage \
    mtools \
    xorriso \
    && rm -rf /var/lib/apt/lists/*

# Update and install remaining utilities
RUN . /usr/local/bin/retry-apt && retry apt-get update && retry apt-get install -y --no-install-recommends \
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

# Install real ISO building dependencies
RUN . /usr/local/bin/retry-apt && retry apt-get update && retry apt-get install -y --no-install-recommends \
    debootstrap \
    squashfs-tools \
    && rm -rf /var/lib/apt/lists/*

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /workspace

# Copy build scripts
COPY iso/ /workspace/iso/
COPY scripts/ /workspace/scripts/
COPY etc/ /workspace/etc/

# Set execute permissions
RUN chmod +x /workspace/iso/build.sh /workspace/iso/build_real.sh /workspace/scripts/*.sh

# Set the entry point
ENTRYPOINT ["/bin/bash"]
