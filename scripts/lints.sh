#!/bin/bash
echo "=== Running Lint Verification ==="

REQUIRED_FILES=(
    "app/app.sh"
    "scripts/lint.sh"
    "scripts/build.sh"
    "tests/test.sh"
    "Dockerfile"
    "compose.yaml"
    ".dockerignore"
    ".github/workflows/ci.yml"
)

# Check required files existence
for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Missing required file: $file" >&2
        exit 1
    fi
done

# Check Bash syntax errors
for script in app/*.sh scripts/*.sh tests/*.sh; do
    if [ -f "$script" ]; then
        bash -n "$script"
        if [ $? -ne 0 ]; then
            echo "Syntax error found in $script" >&2
            exit 1
        fi
    fi
done

echo "Lint verification passed successfully."
