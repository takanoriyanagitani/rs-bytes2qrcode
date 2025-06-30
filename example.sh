#!/bin/sh

# This script demonstrates how to use the bytes2qrcode CLI tool.

# Set the number of random bytes to generate for the QR code.
# The default is 32 if this variable is not set.
export QR_MAX_BYTES=64

# Generate random bytes from /dev/urandom and pipe them to the application.
# Use 'dd' for precise control over bytes read.
echo "Generating a QR code from $QR_MAX_BYTES random bytes..."
dd if=/dev/urandom bs=$QR_MAX_BYTES count=1 status=none | cargo run
