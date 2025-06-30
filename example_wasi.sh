#!/bin/sh

# This script demonstrates how to use the bytes2qrcode WASI module with wazero.

# Ensure you have compiled your Rust project for the WASI target:
# rustup target add wasm32-wasip1
# cargo build --profile release-wasi --target wasm32-wasip1

# Set the number of random bytes to generate for the QR code.
# The default is 32 if this variable is not set.
QR_MAX_BYTES=40

# Define the path to your compiled WASI module.
WASI_MODULE="target/wasm32-wasip1/release-wasi/rs-bytes2qrcode.wasm"

# Check if the WASI module exists.
if [ ! -f "$WASI_MODULE" ]; then
	echo "Error: WASI module not found: $WASI_MODULE"
	echo "Compile with: cargo build --profile release-wasi --target wasm32-wasip1"
	exit 1
fi

echo "Generating a QR code from $QR_MAX_BYTES random bytes using WASI..."

# Generate random bytes from /dev/urandom and pipe them to the wazero command.
# wazero will then execute the module with the piped input.
dd if=/dev/urandom bs=$QR_MAX_BYTES count=1 status=none |
	wazero run -env QR_MAX_BYTES="$QR_MAX_BYTES" "$WASI_MODULE"
