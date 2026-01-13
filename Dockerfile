# Generic Shell Toolbox Test Container
# Minimal environment for testing GST installation and features

FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install minimal dependencies
RUN apt-get update && apt-get install -y \
    bash \
    git \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a test user for realistic testing (non-root)
RUN useradd -m -s /bin/bash testuser && \
    echo "testuser:testuser" | chpasswd

# Create toolbox directory and set ownership
RUN mkdir -p /opt/generic_shell_toolbox && \
    chown -R testuser:testuser /opt/generic_shell_toolbox

# Copy GST files into the container
COPY --chown=testuser:testuser . /opt/generic_shell_toolbox/

# Switch to test user
USER testuser
WORKDIR /opt/generic_shell_toolbox

# Set up environment
ENV HOME=/home/testuser
ENV SHELL=/bin/bash

# Default command: interactive bash shell
CMD ["/bin/bash"]
