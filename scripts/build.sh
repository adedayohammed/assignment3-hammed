#!/bin/bash
echo "=== Building Docker Image ==="
docker build -t devops-tool .
if [ $? -ne 0 ]; then
    echo "Docker build failed!" >&2
    exit 1
fi

echo "=== Running Docker Smoke Tests ==="

# Test 1: Help command
docker run --rm devops-tool help | grep -q "Usage:"
if [ $? -ne 0 ]; then
    echo "Smoke Test Failed: help command" >&2
    exit 1
fi

# Test 2: System info command
docker run --rm devops-tool system-info | grep -q "OS:"
if [ $? -ne 0 ]; then
    echo "Smoke Test Failed: system-info command" >&2
    exit 1
fi

# Test 3: Invalid command handling (expects exit code 2)
docker run --rm devops-tool invalid-command
if [ $? -ne 2 ]; then
    echo "Smoke Test Failed: invalid command exit code was not 2" >&2
    exit 1
fi

echo "Docker build and smoke tests completed successfully."
