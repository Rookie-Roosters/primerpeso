#!/usr/bin/env bash
# Verifies doctl can talk to the DigitalOcean API.
# One-time setup: create a token at https://cloud.digitalocean.com/account/api/tokens
#   doctl auth init
# Or non-interactive: doctl auth init --access-token "$DIGITALOCEAN_ACCESS_TOKEN"
set -euo pipefail

if ! command -v doctl >/dev/null 2>&1; then
  echo "doctl is not installed. On macOS: brew install doctl" >&2
  exit 1
fi

if ! doctl account get >/dev/null 2>&1; then
  echo "doctl is not authenticated." >&2
  echo "Run: doctl auth init" >&2
  echo "Or pass a token: doctl -t \"\$DIGITALOCEAN_ACCESS_TOKEN\" account get" >&2
  exit 1
fi

echo "doctl OK: $(doctl account get --format Email --no-header 2>/dev/null || echo connected)"
