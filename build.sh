#!/bin/sh
set -e

PERSONA="${1:-anshul}"

echo "Target portfolio persona: $PERSONA"

echo "Installing dependencies..."
npm ci

echo "Building Next.js application..."
npm run "build:$PERSONA"

echo "Creating artifact directory..."
ARTIFACT_DIR="build-artifact"
rm -rf "$ARTIFACT_DIR"
mkdir -p "$ARTIFACT_DIR"

if [ -d ".next/standalone" ]; then
    echo "Copying standalone build..."
    cp -r .next/standalone/. "$ARTIFACT_DIR/"
    mkdir -p "$ARTIFACT_DIR/.next/static"
    cp -r .next/static/. "$ARTIFACT_DIR/.next/static/"
elif [ -d "out" ]; then
    echo "Copying static export directory (out)..."
    cp -r out/. "$ARTIFACT_DIR/"
else
    echo "❌ Error: Neither .next/standalone nor out directory exists!"
    exit 1
fi

echo "Copying public files (if any)..."
if [ -d "public" ]; then
    cp -r public "$ARTIFACT_DIR/"
fi

echo "Copying server.js to artifact..."
if [ -f "server.js" ]; then
    cp server.js "$ARTIFACT_DIR/"
fi

echo "Build artifact created at: $ARTIFACT_DIR"