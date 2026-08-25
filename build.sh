#!/bin/sh

# Build script for portfolio-generator to package artifacts for generic pipeline
set -e

PERSONA="${1:-anshul}"

case "$PERSONA" in
    anshul|anshulbh9)
        NEXT_PUBLIC_PERSONA="anshulbh9"
        ;;
    vivek|vivekanand|vivekanand-07128411)
        NEXT_PUBLIC_PERSONA="vivekanand-07128411"
        ;;
    chandrima|chandrima-das-6b7b63192)
        NEXT_PUBLIC_PERSONA="chandrima-das-6b7b63192"
        ;;
    varsha|varsha-tyagi|varsha-tyagi-b55306114)
        NEXT_PUBLIC_PERSONA="varsha-tyagi-b55306114"
        ;;
    *)
        NEXT_PUBLIC_PERSONA="$PERSONA"
        ;;
esac

if [ ! -d "data/personas/$NEXT_PUBLIC_PERSONA" ]; then
    echo "Error: profile data not found for persona: $NEXT_PUBLIC_PERSONA"
    echo "Available personas:"
    find data/personas -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
    exit 1
fi

export NEXT_PUBLIC_PERSONA

echo "Target portfolio persona: $NEXT_PUBLIC_PERSONA"

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
