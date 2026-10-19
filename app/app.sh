#!/bin/bash

case "$1" in
    system-info)
        echo "OS: $(uname -s)"
        echo "Kernel: $(uname -r)"
        echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
        ;;
    check-host)
        if [ -z "$2" ]; then
            echo "Error: Missing host parameter." >&2
            exit 2
        fi
        if getent hosts "$2" > /dev/null; then
            echo "Host '$2' resolved successfully."
        else
            echo "Error: Could not resolve host '$2'." >&2
            exit 1
        fi
        ;;
    check-port)
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Error: Missing host or port parameter." >&2
            exit 2
        fi
        
        # Validate numeric port
        if [[ ! "$3" =~ ^[0-9]+$ ]]; then
            echo "Error: Port must be numeric." >&2
            exit 2
        fi
        
        # Validate port range
        if [ "$3" -lt 1 ] || [ "$3" -gt 65535 ]; then
            echo "Error: Port out of range (1-65535)." >&2
            exit 2
        fi
        
        # Check TCP connectivity using built-in /dev/tcp
        if (echo > /dev/tcp/"$2"/"$3") 2>/dev/null; then
            echo "Port $3 on $2 is OPEN."
        else
            echo "Port $3 on $2 is CLOSED or unreachable." >&2
            exit 1
        fi
        ;;
    help|"")
        echo "Usage: $0 {system-info|check-host <host>|check-port <host> <port>|help}"
        ;;
    *)
        echo "Error: Invalid command '$1'." >&2
        exit 2
        ;;
esac
