#!/bin/sh

# Build script for portfolio-generator to package artifacts for generic pipeline
set -e

echo "Installing dependencies..."
npm ci

echo "Building Next.js application..."
npm run build

echo "Creating artifact directory..."
ARTIFACT_DIR="build-artifact"
rm -rf "$ARTIFACT_DIR"
mkdir -p "$ARTIFACT_DIR"

echo "Copying standalone build..."
cp -r .next/standalone/. "$ARTIFACT_DIR/"

echo "Copying static files..."
mkdir -p "$ARTIFACT_DIR/.next/static"
cp -r .next/static/. "$ARTIFACT_DIR/.next/static/"

echo "Copying public files (if any)..."
if [ -d "public" ]; then
    cp -r public "$ARTIFACT_DIR/"
fi

echo "Build artifact created at: $ARTIFACT_DIR"
echo "Use ARTIFACT_PATH=$ARTIFACT_DIR in the pipeline"
