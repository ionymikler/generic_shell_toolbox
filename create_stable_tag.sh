#!/usr/bin/env bash
# filepath: create_stable_tag.sh
# Script to create a new stable version tag and update the latest tag

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
source "${SCRIPT_DIR}/shell_utils/colored_shell.sh"

function show_help() {
    echo "Create Stable Version Tag Script"
    echo ""
    echo "Usage: $0 <version> [message]"
    echo ""
    echo "Arguments:"
    echo "  version     Version number (e.g., 1.2.4)"
    echo "  message     Optional tag message (if not provided, will prompt)"
    echo ""
    echo "Examples:"
    echo "  $0 1.2.4"
    echo "  $0 1.2.4 'Bug fixes and improvements'"
}

function validate_version() {
    local version=$1
    # Check if version follows semantic versioning pattern (x.y.z)
    if [[ ! $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        log_error "Invalid version format. Use semantic versioning (x.y.z)"
        return 1
    fi
    return 0
}

function update_version_file() {
    local version=$1
    local version_file="${SCRIPT_DIR}/version.yaml"
    
    if [ -f "$version_file" ]; then
        log_info "Updating version.yaml to version $version"
        echo "version: $version" > "$version_file"
        git add "$version_file"
        git commit -m "Bump version to $version"
    else
        log_warn "version.yaml not found, skipping version file update"
    fi
}

function create_stable_tag() {
    local version=$1
    local message=$2
    
    # Validate inputs
    if [ -z "$version" ]; then
        log_error "Version is required"
        show_help
        return 1
    fi
    
    if ! validate_version "$version"; then
        return 1
    fi
    
    # Check if we're in a git repository
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        log_error "Not inside a git repository"
        return 1
    fi
    
    # Check if there are uncommitted changes
    if ! git diff-index --quiet HEAD --; then
        log_warn "You have uncommitted changes. Please commit or stash them first."
        read -p "Do you want to continue anyway? (y/n): " continue_anyway
        if [ "$continue_anyway" != "y" ]; then
            log_info "Aborting..."
            return 1
        fi
    fi
    
    # Get tag message if not provided
    if [ -z "$message" ]; then
        read -p "Enter tag message for version $version: " message
        if [ -z "$message" ]; then
            message="Release version $version"
        fi
    fi
    
    # Update version file
    update_version_file "$version"
    
    # Create the stable version tag
    local stable_tag="stable/$version"
    log_info "Creating tag: $stable_tag"
    if git tag -a "$stable_tag" -m "$message"; then
        log_info_green "✓ Created tag: $stable_tag"
    else
        log_error "Failed to create tag: $stable_tag"
        return 1
    fi
    
    # Update the latest tag to point to the same commit
    log_info "Updating stable/latest tag to point to the same commit"
    if git tag -fa stable/latest -m "Update stable/latest to version $version"; then
        log_info_green "✓ Updated stable/latest tag"
    else
        log_error "Failed to update stable/latest tag"
        return 1
    fi
    
    # Ask if user wants to push the tags
    read -p "Do you want to push the tags to origin? (y/n): " push_tags
    if [ "$push_tags" == "y" ]; then
        log_info "Pushing tags to origin..."
        
        # Push the version tag
        if git push origin "$stable_tag"; then
            log_info_green "✓ Pushed $stable_tag to origin"
        else
            log_error "Failed to push $stable_tag to origin"
            return 1
        fi
        
        # Force push the latest tag
        if git push origin stable/latest --force; then
            log_info_green "✓ Force pushed stable/latest to origin"
        else
            log_error "Failed to push stable/latest to origin"
            return 1
        fi
        
        log_info_important "Successfully created and pushed stable version $version!"
    else
        log_info_yellow "Tags created locally. Remember to push them manually:"
        log_info "  git push origin $stable_tag"
        log_info "  git push origin stable/latest --force"
    fi
}

# Check for help flag
if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    show_help
    exit 0
fi

# Run the main function
create_stable_tag "$1" "$2"