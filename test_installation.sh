#!/bin/bash
# Automated test script for GST installation
# Tests core functionality of Generic Shell Toolbox

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

TEST_COUNT=0
PASSED_COUNT=0
FAILED_COUNT=0

print_test_header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  GST Installation Test Suite${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""
}

print_test() {
    TEST_COUNT=$((TEST_COUNT + 1))
    echo -e "${YELLOW}[TEST ${TEST_COUNT}]${NC} $1"
}

pass_test() {
    PASSED_COUNT=$((PASSED_COUNT + 1))
    echo -e "${GREEN}  ✓ PASS${NC}: $1"
}

fail_test() {
    FAILED_COUNT=$((FAILED_COUNT + 1))
    echo -e "${RED}  ✗ FAIL${NC}: $1"
}

print_summary() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Test Summary${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "Total Tests:  ${TEST_COUNT}"
    echo -e "${GREEN}Passed:       ${PASSED_COUNT}${NC}"

    if [ $FAILED_COUNT -gt 0 ]; then
        echo -e "${RED}Failed:       ${FAILED_COUNT}${NC}"
        echo ""
        echo -e "${RED}TEST SUITE FAILED${NC}"
        return 1
    else
        echo -e "${GREEN}Failed:       ${FAILED_COUNT}${NC}"
        echo ""
        echo -e "${GREEN}ALL TESTS PASSED!${NC}"
        return 0
    fi
}

# Start tests
print_test_header

# Test 1: Check if install.bash exists
print_test "Checking if install.bash exists"
if [ -f "./install.bash" ]; then
    pass_test "install.bash found"
else
    fail_test "install.bash not found"
    exit 1
fi

# Test 2: Run installation with default options
print_test "Running installation with default options"
if ./install.bash -y -D > /tmp/install.log 2>&1; then
    pass_test "Installation completed successfully"
else
    fail_test "Installation failed"
    cat /tmp/install.log
    exit 1
fi

# Test 3: Check if .env file was created
print_test "Checking if .env file was created"
if [ -f "./.env" ]; then
    pass_test ".env file created"
else
    fail_test ".env file not created"
fi

# Test 4: Check if bashrc was modified
print_test "Checking if bashrc was modified"
if grep -q "generic_shell_toolbox.sh" "$HOME/.bashrc"; then
    pass_test "bashrc modified with GST source line"
else
    fail_test "bashrc not modified"
fi

# Test 5: Source the toolbox
print_test "Sourcing generic_shell_toolbox.sh"
if source ./generic_shell_toolbox.sh > /tmp/source.log 2>&1; then
    pass_test "Toolbox sourced successfully"
else
    fail_test "Failed to source toolbox"
    cat /tmp/source.log
fi

# Test 6: Check if gst_version command exists
print_test "Checking if gst_version command exists"
if command -v gst_version &> /dev/null; then
    pass_test "gst_version command available"
else
    fail_test "gst_version command not found"
fi

# Test 7: Run gst_version
print_test "Running gst_version command"
if gst_version > /tmp/version.log 2>&1; then
    VERSION_OUTPUT=$(cat /tmp/version.log)
    if echo "$VERSION_OUTPUT" | grep -q "version:"; then
        pass_test "gst_version executed successfully: $(echo $VERSION_OUTPUT | grep 'version:')"
    else
        fail_test "gst_version output unexpected"
    fi
else
    fail_test "gst_version command failed"
fi

# Test 8: Check if gst_enable command exists
print_test "Checking if gst_enable command exists"
if command -v gst_enable &> /dev/null; then
    pass_test "gst_enable command available"
else
    fail_test "gst_enable command not found"
fi

# Test 9: Check if gst_disable command exists
print_test "Checking if gst_disable command exists"
if command -v gst_disable &> /dev/null; then
    pass_test "gst_disable command available"
else
    fail_test "gst_disable command not found"
fi

# Test 10: Check if colored shell utilities are loaded
print_test "Checking if colored shell utilities are available"
if command -v log_info &> /dev/null; then
    pass_test "Colored shell utilities loaded (log_info found)"
else
    fail_test "Colored shell utilities not loaded"
fi

# Test 11: Test gst_disable
print_test "Testing gst_disable functionality"
if gst_disable > /tmp/disable.log 2>&1; then
    pass_test "gst_disable executed successfully"
else
    fail_test "gst_disable failed"
fi

# Test 12: Verify toolbox is disabled
print_test "Verifying toolbox is disabled"
if grep -q "TOOLBOX_ENABLED=false" ./.env; then
    pass_test "Toolbox disabled in .env"
else
    fail_test "Toolbox not disabled"
fi

# Test 13: Test gst_enable
print_test "Testing gst_enable functionality"
if gst_enable > /tmp/enable.log 2>&1; then
    pass_test "gst_enable executed successfully"
else
    fail_test "gst_enable failed"
fi

# Test 14: Verify toolbox is enabled
print_test "Verifying toolbox is enabled"
if grep -q "TOOLBOX_ENABLED=true" ./.env; then
    pass_test "Toolbox enabled in .env"
else
    fail_test "Toolbox not enabled"
fi

# Test 15: Check git integration
print_test "Checking git utilities are available"
if command -v git_get_repo_name &> /dev/null; then
    pass_test "Git utilities loaded"
else
    fail_test "Git utilities not loaded"
fi

# Print summary and exit
print_summary
exit $?
