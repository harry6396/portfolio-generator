#!/bin/bash

# Set environment variables from Dockerfile
export NODE_ENV=production
export NEXT_TELEMETRY_DISABLED=1
export PORT=${PORT:-3001}
export HOSTNAME="0.0.0.0"

# Navigate to application root directory where server.js resides
APP_DIR="/${APP:-prodhub-static}"
if [ -d "$APP_DIR" ]; then
    cd "$APP_DIR"
fi

# Graceful shutdown handler
shutdown() {
    echo "Shutting down gracefully..."
    if [ -n "$PID" ]; then
        kill -TERM "$PID" 2>/dev/null || true
        wait "$PID"
    fi
    exit 0
}

trap shutdown SIGTERM SIGINT

# Start the Next.js server
echo "Starting Next.js server on port $PORT from directory $(pwd)..."
node server.js &
PID=$!

# Wait for the process
wait $PID