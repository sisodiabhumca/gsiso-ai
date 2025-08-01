#!/bin/bash

# Gsiso AI Linux - Fallback ISO Builder
# This script creates a simple ISO for testing when the real builder fails

set -e

# Configuration
VERSION="1.0.0"
ARCH="x86_64"
ISO_NAME="gsiso-ai-${VERSION}-${ARCH}"
BUILD_DIR="$(pwd)/build"
OUTPUT_DIR="$(pwd)/output"

# Ensure directories exist
mkdir -p "${BUILD_DIR}" "${OUTPUT_DIR}"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_header() {
    echo -e "${GREEN}"
    echo "========================================"
    echo "  Gsiso AI Linux - Fallback ISO Builder"
    echo "  Version: ${VERSION}"
    echo "  Architecture: ${ARCH}"
    echo "========================================"
    echo -e "${NC}"
}

# Create simple ISO content
create_iso_content() {
    echo -e "${YELLOW}Creating ISO content...${NC}"
    
    # Create a simple filesystem structure
    mkdir -p "${BUILD_DIR}/iso-content"
    
    # Create a README file
    cat > "${BUILD_DIR}/iso-content/README.txt" << 'EOF'
Gsiso AI Linux - Fallback ISO
================================

This is a fallback ISO created when the full build process encountered issues.

Features:
- Basic Linux system structure
- Package management scripts
- Documentation and guides

To use this ISO:
1. Extract the contents
2. Follow the installation guide in docs/
3. Use the package manager scripts in scripts/

For more information, visit: https://github.com/sisodiabhumca/gsiso-ai

Created on: $(date)
EOF

    # Copy project files
    if [ -d "../scripts" ]; then
        cp -r ../scripts "${BUILD_DIR}/iso-content/"
    fi
    
    if [ -d "../docs" ]; then
        cp -r ../docs "${BUILD_DIR}/iso-content/"
    fi
    
    if [ -d "../wiki" ]; then
        cp -r ../wiki "${BUILD_DIR}/iso-content/"
    fi
    
    if [ -d "../website" ]; then
        cp -r ../website "${BUILD_DIR}/iso-content/"
    fi
    
    # Copy configuration files
    if [ -d "../etc" ]; then
        cp -r ../etc "${BUILD_DIR}/iso-content/"
    fi
    
    echo -e "${GREEN}ISO content created${NC}"
}

# Create ISO file
create_iso() {
    echo -e "${YELLOW}Creating ISO file...${NC}"
    
    local iso_file="${OUTPUT_DIR}/${ISO_NAME}.iso"
    
    # Try different ISO creation methods
    if command -v genisoimage &> /dev/null; then
        echo "Using genisoimage..."
        genisoimage -o "${iso_file}" -r -V "GsisoAI" "${BUILD_DIR}/iso-content"
    elif command -v mkisofs &> /dev/null; then
        echo "Using mkisofs..."
        mkisofs -o "${iso_file}" -r -V "GsisoAI" "${BUILD_DIR}/iso-content"
    elif command -v xorrisofs &> /dev/null; then
        echo "Using xorrisofs..."
        xorrisofs -o "${iso_file}" -r -V "GsisoAI" "${BUILD_DIR}/iso-content"
    else
        echo -e "${YELLOW}No ISO creation tools available, creating archive instead...${NC}"
        # Create a tar.gz as fallback
        tar -czf "${OUTPUT_DIR}/${ISO_NAME}.tar.gz" -C "${BUILD_DIR}/iso-content" .
        echo -e "${GREEN}Created archive: ${OUTPUT_DIR}/${ISO_NAME}.tar.gz${NC}"
        return 0
    fi
    
    # Verify ISO was created
    if [ -f "${iso_file}" ]; then
        echo -e "${GREEN}ISO created successfully: ${iso_file}${NC}"
        echo -e "${GREEN}Size: $(du -h "${iso_file}" | cut -f1)${NC}"
    else
        echo -e "${RED}Error: ISO file was not created${NC}"
        exit 1
    fi
}

# Main build process
main() {
    print_header
    create_iso_content
    create_iso
    
    echo -e "${GREEN}"
    echo "========================================"
    echo "  Fallback build completed!"
    echo "  Output: ${OUTPUT_DIR}/${ISO_NAME}.iso"
    echo ""
    echo "  Note: This is a fallback ISO with basic content."
    echo "  For full functionality, ensure all dependencies are available."
    echo "========================================"
    echo -e "${NC}"
}

# Run main function
main "$@" 