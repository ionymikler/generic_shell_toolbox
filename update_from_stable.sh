#!/bin/bash

# Generic Shell Toolbox - Update from stable/latest
# This script updates an existing GST installation to the latest stable release
# Use case: For installations done via tarball (wget), not git clone

set -e

REPO_URL="https://github.com/ionymikler/generic_shell_toolbox"
RELEASE_TAG="stable/latest"
DOWNLOAD_URL="${REPO_URL}/archive/refs/tags/${RELEASE_TAG}.tar.gz"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running in git repository
if [ -d "${SCRIPT_DIR}/.git" ]; then
    print_warning "This appears to be a git repository."
    print_warning "This script is intended for tarball installations."
    print_warning "For git installations, use: git fetch && git checkout stable/latest"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Update cancelled."
        exit 0
    fi
fi

print_info "Generic Shell Toolbox - Update to ${RELEASE_TAG}"
echo

# Check for required commands
for cmd in wget tar; do
    if ! command -v $cmd &> /dev/null; then
        print_error "Required command '$cmd' not found. Please install it first."
        exit 1
    fi
done

# Create temporary directory
TEMP_DIR=$(mktemp -d)
trap "rm -rf ${TEMP_DIR}" EXIT

print_info "Downloading ${RELEASE_TAG} from GitHub..."
if ! wget -q --show-progress "${DOWNLOAD_URL}" -O "${TEMP_DIR}/gst-latest.tar.gz"; then
    print_error "Failed to download latest release."
    exit 1
fi

print_info "Extracting archive..."
tar -xzf "${TEMP_DIR}/gst-latest.tar.gz" -C "${TEMP_DIR}"

# Find the extracted directory (GitHub creates a directory named repo-tag)
EXTRACTED_DIR=$(find "${TEMP_DIR}" -maxdepth 1 -type d -name "generic_shell_toolbox-*" | head -n 1)

if [ -z "${EXTRACTED_DIR}" ]; then
    print_error "Failed to locate extracted files."
    exit 1
fi

# Backup current installation
BACKUP_DIR="${SCRIPT_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
print_info "Creating backup at: ${BACKUP_DIR}"
mkdir -p "${BACKUP_DIR}"

# Copy current installation to backup (excluding .git if present)
rsync -a --exclude='.git' --exclude='*.backup.*' "${SCRIPT_DIR}/" "${BACKUP_DIR}/"

print_success "Backup created successfully."

# Preserve configuration files
print_info "Preserving configuration files..."
CONFIG_FILES=()

# Check for .env files
if [ -f "${SCRIPT_DIR}/.env" ]; then
    CONFIG_FILES+=(".env")
fi

if [ -f "${SCRIPT_DIR}/.extensions/.env" ]; then
    CONFIG_FILES+=(".extensions/.env")
fi

# Copy preserved files to temp location
PRESERVE_DIR="${TEMP_DIR}/preserved"
mkdir -p "${PRESERVE_DIR}"

for config in "${CONFIG_FILES[@]}"; do
    if [ -f "${SCRIPT_DIR}/${config}" ]; then
        print_info "  Preserving ${config}"
        mkdir -p "${PRESERVE_DIR}/$(dirname ${config})"
        cp "${SCRIPT_DIR}/${config}" "${PRESERVE_DIR}/${config}"
    fi
done

# Remove old files (except backups and .git)
print_info "Removing old installation files..."
find "${SCRIPT_DIR}" -mindepth 1 -maxdepth 1 \
    ! -name '.git' \
    ! -name '*.backup.*' \
    -exec rm -rf {} +

# Copy new files
print_info "Installing new version..."
cp -r "${EXTRACTED_DIR}"/* "${SCRIPT_DIR}/"

# Restore preserved configuration files
if [ -d "${PRESERVE_DIR}" ]; then
    print_info "Restoring configuration files..."
    for config in "${CONFIG_FILES[@]}"; do
        if [ -f "${PRESERVE_DIR}/${config}" ]; then
            print_info "  Restoring ${config}"
            mkdir -p "${SCRIPT_DIR}/$(dirname ${config})"
            cp "${PRESERVE_DIR}/${config}" "${SCRIPT_DIR}/${config}"
        fi
    done
fi

# Make scripts executable
print_info "Setting executable permissions..."
chmod +x "${SCRIPT_DIR}"/*.sh "${SCRIPT_DIR}"/*.bash 2>/dev/null || true

# Get version from new installation
NEW_VERSION="unknown"
if [ -f "${SCRIPT_DIR}/version.yaml" ]; then
    NEW_VERSION=$(grep -oP 'version:\s*\K.*' "${SCRIPT_DIR}/version.yaml" || echo "unknown")
fi

echo
print_success "Update completed successfully!"
print_success "New version: ${NEW_VERSION}"
echo
print_info "Backup location: ${BACKUP_DIR}"
print_info "To rollback: rm -rf ${SCRIPT_DIR}/* && cp -r ${BACKUP_DIR}/* ${SCRIPT_DIR}/"
echo
print_warning "Please reload your shell or run 'source ~/.bashrc' to apply changes."
echo

# Ask if user wants to delete backup
read -p "Keep backup directory? (Y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
    rm -rf "${BACKUP_DIR}"
    print_info "Backup removed."
else
    print_info "Backup kept at: ${BACKUP_DIR}"
fi
