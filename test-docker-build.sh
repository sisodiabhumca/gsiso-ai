#!/bin/bash

# Test script for Docker build
set -e

echo "Testing Docker build for Gsiso AI..."

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed or not in PATH"
    exit 1
fi

# Build the Docker image
echo "Building Docker image..."
docker build --progress=plain --no-cache -t gsiso-builder-test -f docker/Dockerfile .

if [ $? -eq 0 ]; then
    echo "✅ Docker build successful!"
    
    # Test running the container
    echo "Testing container execution..."
    docker run --rm gsiso-builder-test echo "Container test successful"
    
    if [ $? -eq 0 ]; then
        echo "✅ Container test successful!"
        echo "Docker build is ready for GitHub Actions"
    else
        echo "❌ Container test failed"
        exit 1
    fi
else
    echo "❌ Docker build failed"
    exit 1
fi 