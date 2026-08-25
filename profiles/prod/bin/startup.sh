#!/bin/bash

# Set environment variables from Dockerfile
export NODE_ENV=production
export NEXT_TELEMETRY_DISABLED=1
export PORT=${PORT:-3001}
export HOSTNAME="0.0.0.0"

# Graceful shutdown handler
shutdown() {
    echo "Shutting down gracefully..."
    if [ -n "$PID" ]; then
        kill -TERM "$PID"
        wait "$PID"
    fi
    exit 0
}

trap shutdown SIGTERM SIGINT

# Start the Next.js server
echo "Starting Next.js server on port $PORT..."
node server.js &
PID=$!

# Wait for the process
wait $PID