# Generic Shell Toolbox (GST)

A modular collection of shell utilities and tools that enhance the everyday development experience with colored output, git integration, ROS workspace management, and extensible functionality.

## Features

### Core Features
- **Git integration** - Branch parsing and repository name detection for prompts
- **resourcing of your `bashrc`** - `rebash` command to reload shell configuration
- **Custom PS1** - Optional enhanced shell prompt configuration

### ROS Extension
- **ROS Workspace shortcuts**
- **ROS Package deletion from workspace** - Delete build/install/log directories for specific packages
- **Smart sourcing** - Source your workspace with a short command
- **Workspace navigation** - `cdws` command with optional sourcing

### Extension System
- **Modular design** - Extensions can be developed and loaded independently
- **Currently includes** - ROS extension with comprehensive workspace tools

## Quick Start

### Installation
```bash
./install.bash              # Interactive installation
./install.bash -y           # Auto-accept prompts
./install.bash -D           # Use default configuration
./install.bash -y -D        # Non-interactive with defaults
```

### Management
```bash
gst_enable                  # Enable toolbox
gst_disable                 # Disable toolbox
gst_uninstall               # Complete removal
gst_version                 # Show version info
```

### ROS Tools (if ROS extension enabled)
```bash
gst_ros_set_ws /path/to/workspace    # Set workspace (any path)
gst_ros_get_ws                       # Show current workspace
cdws [-s]                            # Navigate to workspace (optionally source)
rsrc [-g]                            # Source workspace (optionally with Gazebo)
rospkg_del pkg1 pkg2                # Delete package build artifacts
```

## Configuration

GST uses an environment-based configuration system with `.env` files. The toolbox can be enabled/disabled without uninstalling, and supports custom PS1 prompts and bashrc integration.

## Development

### Release Management
```bash
./create_stable_tag.sh 1.4.0 "Release message"
```

### Git Workflow
```bash
git checkout stable/latest      # Latest stable version
git tag -a stable/x.y.z -m "Release message"
git push origin stable/latest --force
```