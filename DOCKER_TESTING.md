# Docker Testing Environment for GST

This directory contains a simple Docker test environment for the Generic Shell Toolbox (GST).

## Quick Start

### Build and Run Automated Tests
```bash
./test.sh test
```

### Build Image Only
```bash
./test.sh build
```

### Run Interactive Container
```bash
./test.sh run
# Inside container:
./install.bash -y -D
source ~/.bashrc
gst_version
```

### Clean Up
```bash
./test.sh clean
```

## What's Included

### Files
- **Dockerfile** - Ubuntu 22.04-based minimal test container
- **test.sh** - Helper script for building and running tests
- **test_installation.sh** - Automated test suite
- **.dockerignore** - Excludes unnecessary files from build

### Container Features
- **Base**: Ubuntu 22.04 (jammy)
- **User**: Non-root `testuser` for realistic testing
- **Tools**: bash, git, wget, curl
- **Size**: ~150-200 MB

### Test Coverage
The automated test suite (`test_installation.sh`) validates:
- ✓ Installation process
- ✓ .env file creation
- ✓ bashrc integration
- ✓ Toolbox sourcing
- ✓ Core commands (gst_version, gst_enable, gst_disable)
- ✓ Colored shell utilities
- ✓ Enable/disable functionality
- ✓ Git utilities

## Manual Testing Inside Container

```bash
# Start interactive session
./test.sh run

# Install GST with defaults
./install.bash -y -D

# Source the toolbox
source ~/.bashrc

# Test commands
gst_version
gst_disable
gst_enable
git_get_repo_name

# Try custom installation
gst_disable
rm .env
./install.bash  # Interactive mode
```

## Extending the Container

### Add ROS Support
Uncomment ROS installation in Dockerfile and add:
```dockerfile
RUN apt-get install -y ros-humble-desktop
```

### Add More Test Cases
Edit `test_installation.sh` and add new test functions following the pattern:
```bash
print_test "Description of test"
if [test condition]; then
    pass_test "Success message"
else
    fail_test "Failure message"
fi
```

## Troubleshooting

### Docker Not Found
Ensure Docker is installed:
```bash
# Ubuntu/Debian
sudo apt-get install docker.io

# Or use Docker Desktop
```

### Permission Denied
Add your user to docker group:
```bash
sudo usermod -aG docker $USER
# Log out and back in
```

### Container Size Too Large
Use Alpine base image instead:
```dockerfile
FROM alpine:latest
RUN apk add --no-cache bash git wget curl
```

## CI/CD Integration

Example GitHub Actions workflow:
```yaml
- name: Run Docker Tests
  run: |
    chmod +x test.sh
    ./test.sh test
```

## Notes
- Container runs as non-root user `testuser` for security
- All GST files are copied to `/opt/generic_shell_toolbox`
- No ROS support by default (keeps container minimal)
- .env files are created fresh during testing
