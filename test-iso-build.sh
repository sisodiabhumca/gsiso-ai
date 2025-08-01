#!/bin/bash

# Test ISO Build Script
# This script tests the ISO building process locally

set -e

echo "========================================"
echo "  Testing Gsiso AI Linux ISO Build"
echo "========================================"

# Check if we're in the right directory
if [ ! -f "iso/build.sh" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo "❌ Error: Docker is not installed or not in PATH"
    exit 1
fi

# Check if we can run Docker
if ! docker info &> /dev/null; then
    echo "❌ Error: Cannot connect to Docker daemon"
    echo "Make sure Docker is running and you have permissions"
    exit 1
fi

echo "✅ Docker is available and running"

# Build Docker image
echo "Building Docker image..."
docker build --progress=plain --no-cache -t gsiso-builder -f docker/Dockerfile . 2>&1 | tee docker-build.log

if [ $? -ne 0 ]; then
    echo "❌ Docker build failed"
    cat docker-build.log
    exit 1
fi

echo "✅ Docker image built successfully"

# Create output directory
mkdir -p iso/output

# Run ISO build in container
echo "Building ISO in container..."
docker run --rm \
    --platform linux/amd64 \
    --privileged \
    -v "$(pwd):/workspace" \
    -w /workspace/iso \
    --entrypoint /bin/sh \
    gsiso-builder \
    -c "set -e; ./build.sh" 2>&1 | tee iso-build.log

if [ $? -ne 0 ]; then
    echo "❌ ISO build failed"
    cat iso-build.log
    exit 1
fi

echo "✅ ISO build completed"

# Check if ISO was created
echo "Checking for ISO file..."
if [ -f "iso/output/gsiso-ai-1.0.0-x86_64.iso" ]; then
    echo "✅ ISO file found: iso/output/gsiso-ai-1.0.0-x86_64.iso"
    echo "Size: $(du -h iso/output/gsiso-ai-1.0.0-x86_64.iso | cut -f1)"
    
    # Validate ISO
    if file "iso/output/gsiso-ai-1.0.0-x86_64.iso" | grep -q "ISO 9660"; then
        echo "✅ ISO validation passed - Valid ISO 9660 format"
    else
        echo "⚠️ ISO validation warning - Not standard ISO format"
        echo "File type: $(file iso/output/gsiso-ai-1.0.0-x86_64.iso)"
    fi
else
    echo "❌ ISO file not found"
    echo "Contents of iso/output/:"
    ls -la iso/output/ || echo "Output directory not found"
    echo "Searching for ISO files:"
    find . -name "*.iso" -type f || echo "No ISO files found"
    exit 1
fi

echo ""
echo "========================================"
echo "  Test completed successfully!"
echo "  ISO: iso/output/gsiso-ai-1.0.0-x86_64.iso"
echo "========================================" 