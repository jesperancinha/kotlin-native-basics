#!/usr/bin/env bash
#!/bin/bash

set -e

TARGET_DIR="/bin"

# Detect platform
OS="$(uname -s)"
ARCH="$(uname -m)"

if [[ "$OS" == "Linux" ]]; then
  PLATFORM="linux-x86_64"
elif [[ "$OS" == "Darwin" ]]; then
  if [[ "$ARCH" == "arm64" ]]; then
    PLATFORM="macos-aarch64"
  else
    PLATFORM="macos-x86_64"
  fi
else
  echo "Unsupported OS: $OS"
  exit 1
fi

# Get latest Kotlin version from GitHub API
VERSION=$(curl -s https://api.github.com/repos/JetBrains/kotlin/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

echo "Installing Kotlin/Native $VERSION for $PLATFORM..."

TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

FILENAME="kotlin-native-prebuilt-${PLATFORM}-${VERSION}.tar.gz"
URL="https://github.com/JetBrains/kotlin/releases/download/v${VERSION}/${FILENAME}"

echo "$URL"
curl -LO "$URL"
tar -xvzf "$FILENAME"

# Copy konanc and related scripts to target dir
yes | sudo cp kotlin-native-*/bin/konanc "$TARGET_DIR"
yes | sudo cp kotlin-native-*/bin/run_konan "$TARGET_DIR"
yes | sudo cp kotlin-native-*/bin/cinterop "$TARGET_DIR"

# Ensure executable
sudo chmod +x "$TARGET_DIR/konanc" "$TARGET_DIR/run_konan"

echo "✅ konanc installed to $TARGET_DIR"
echo "➡️ Run: $TARGET_DIR/konanc -version"

# Cleanup
cd ~
rm -rf "$TMP_DIR"
