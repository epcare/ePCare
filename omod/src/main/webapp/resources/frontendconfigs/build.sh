#!/bin/bash

# Clean up previous build artifacts
echo "Cleaning up previous build artifacts ..."
rm -rf frontend
# Assemble assets
echo "Assembling assets ..."
npx --legacy-peer-deps openmrs@next assemble \
  --manifest \
  --mode config \
  --config ./configuration/spa-build-config.json \
  --target ./frontend
# Build assets
echo "Building assets for ePcare..."
CWD=$(pwd)
npx --legacy-peer-deps openmrs@next build \
  --build-config ./configuration/spa-build-config.json \
  --target ./frontend \
  --page-title "ePcare" \
  --support-offline false
# Copy required files
echo "Copying required files ..."
cp -r "${CWD}/assets/" "${CWD}/frontend"
# cp "${CWD}/assets/favicon.ico" "${CWD}/frontend"
cp "${CWD}/configuration/frontend-config.json" "${CWD}/frontend"
mv "${CWD}/frontend/frontend-config.json" "${CWD}/frontend/config.json"
cp -r assets/* frontend/.
zip -r frontend.zip frontend/*

# Exit with success status
exit 0