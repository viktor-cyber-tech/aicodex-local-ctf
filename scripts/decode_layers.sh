#!/usr/bin/env bash
set -euo pipefail

payload='1f8b08000000000000034b36ce294df128a94ac9752b4d0db32c8bcc8dca8d30f22b8dca8daa4c8e30b0e5020008b6302721000000'

decode_hex() {
  if command -v xxd >/dev/null 2>&1; then
    xxd -r -p
  else
    python3 -c 'import sys; sys.stdout.buffer.write(bytes.fromhex(sys.stdin.read().strip()))'
  fi
}

printf '%s' "$payload"   | decode_hex   | gzip -dc   | base64 -d   | tr 'a-zA-Z' 'n-za-mN-ZA-M'
