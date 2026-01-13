#!/bin/bash
# Generic Shell Toolbox Docker Test Script
# Quick script to build and run the GST test container

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME="gst-test"
CONTAINER_NAME="gst-test-container"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_usage() {
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  build         Build the Docker image"
    echo "  run           Run interactive container"
    echo "  test          Build and run automated tests"
    echo "  clean         Remove Docker image and containers"
    echo "  shell         Run container with bash shell (default)"
    echo "  help          Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 build      # Build the image"
    echo "  $0 run        # Run interactive session"
    echo "  $0 test       # Run automated tests"
}

build_image() {
    echo -e "${BLUE}Building Docker image: ${IMAGE_NAME}${NC}"
    docker build -t "${IMAGE_NAME}" "${SCRIPT_DIR}"
    echo -e "${GREEN}✓ Image built successfully${NC}"
}

run_interactive() {
    echo -e "${BLUE}Starting interactive container...${NC}"
    echo -e "${YELLOW}Run './install.bash -y -D' to test installation${NC}"
    docker run -it --rm --name "${CONTAINER_NAME}" "${IMAGE_NAME}"
}

run_tests() {
    echo -e "${BLUE}Building image and running automated tests...${NC}"
    build_image
    echo -e "${BLUE}Running test suite in container...${NC}"
    docker run --rm --name "${CONTAINER_NAME}" "${IMAGE_NAME}" /bin/bash -c "./test_installation.sh"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ All tests passed!${NC}"
    else
        echo -e "${RED}✗ Tests failed${NC}"
        exit 1
    fi
}

clean_docker() {
    echo -e "${YELLOW}Cleaning up Docker resources...${NC}"

    # Stop and remove container if running
    if docker ps -a | grep -q "${CONTAINER_NAME}"; then
        echo "Removing container: ${CONTAINER_NAME}"
        docker rm -f "${CONTAINER_NAME}" 2>/dev/null || true
    fi

    # Remove image
    if docker images | grep -q "${IMAGE_NAME}"; then
        echo "Removing image: ${IMAGE_NAME}"
        docker rmi "${IMAGE_NAME}" 2>/dev/null || true
    fi

    echo -e "${GREEN}✓ Cleanup complete${NC}"
}

# Main script logic
case "${1:-shell}" in
    build)
        build_image
        ;;
    run|shell)
        run_interactive
        ;;
    test)
        run_tests
        ;;
    clean)
        clean_docker
        ;;
    help|--help|-h)
        print_usage
        ;;
    *)
        echo -e "${RED}Unknown option: $1${NC}"
        print_usage
        exit 1
        ;;
esac
