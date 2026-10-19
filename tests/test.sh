#!/bin/bash
echo "=== Running Student Tests (8 Test Cases) ==="
FAILED=0

run_test() {
    local name="$1"
    local cmd="$2"
    local expected_code="$3"
    
    eval "$cmd" > /dev/null 2>&1
    local actual_code=$?
    
    if [ $actual_code -eq $expected_code ]; then
        echo "[PASS] $name"
    else
        echo "[FAIL] $name (Expected $expected_code, got $actual_code)"
        FAILED=$((FAILED + 1))
    fi
}

run_test "1. Help Command" "./app/app.sh help" 0
run_test "2. System Info" "./app/app.sh system-info" 0
run_test "3. Invalid Command" "./app/app.sh unknown-cmd" 2
run_test "4. Missing Host" "./app/app.sh check-host" 2
run_test "5. Valid Host" "./app/app.sh check-host localhost" 0
run_test "6. Missing Port" "./app/app.sh check-port localhost" 2
run_test "7. Non-Numeric Port" "./app/app.sh check-port localhost abc" 2
run_test "8. Out of Range Port" "./app/app.sh check-port localhost 70000" 2

if [ $FAILED -gt 0 ]; then
    echo "$FAILED tests failed!" >&2
    exit 1
else
    echo "All tests passed successfully."
    exit 0
fi
