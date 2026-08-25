#!/bin/sh

# Build script for prodhub-static to package artifacts for generic pipeline
set -e

# Capture the persona argument ($1) or fallback to default
PERSONA="${1:-anshul}"

echo "Target portfolio persona: $PERSONA..."

echo "Installing dependencies..."
npm ci

echo "Building Next.js application for persona: $PERSONA..."
npm run "build:$PERSONA"

echo "Creating artifact directory..."
ARTIFACT_DIR="build-artifact"
rm -rf "$ARTIFACT_DIR"
mkdir -p "$ARTIFACT_DIR"

# For Next.js static exports (output: 'export')
if [ -d "out" ]; then
    echo "Copying static export directory (out)..."
    cp -r out/. "$ARTIFACT_DIR/"
fi

# For Next.js standalone builds (output: 'standalone')
if [ -d ".next/standalone" ]; then
    echo "Copying standalone server build..."
    cp -r .next/standalone/. "$ARTIFACT_DIR/"
    mkdir -p "$ARTIFACT_DIR/.next/static"
    cp -r .next/static/. "$ARTIFACT_DIR/.next/static/"
fi

echo "Copying public files (if any)..."
if [ -d "public" ]; then
    cp -r public "$ARTIFACT_DIR/"
fi

echo "Copying server.js and package.json to artifact..."
if [ -f "server.js" ]; then
    cp server.js "$ARTIFACT_DIR/"
fi

if [ -f "package.json" ]; then
    cp package.json "$ARTIFACT_DIR/"
fi

echo "Build artifact created at: $ARTIFACT_DIR"
echo "Use ARTIFACT_PATH=$ARTIFACT_DIR in the pipeline"
