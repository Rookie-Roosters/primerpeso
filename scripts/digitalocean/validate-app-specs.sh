#!/usr/bin/env bash
# Validates .do/app-api.yaml and .do/app-web.yaml (requires doctl authentication).
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

DOCTL=(doctl)
if [[ -n "${DIGITALOCEAN_ACCESS_TOKEN:-}" ]]; then
  DOCTL=(doctl -t "$DIGITALOCEAN_ACCESS_TOKEN")
fi

if ! "${DOCTL[@]}" account get >/dev/null 2>&1; then
  echo "doctl is not authenticated. Run ./scripts/digitalocean/doctl-auth.sh" >&2
  echo "Or set DIGITALOCEAN_ACCESS_TOKEN and retry." >&2
  exit 1
fi

"${DOCTL[@]}" apps spec validate "$ROOT_DIR/.do/app-api.yaml"
"${DOCTL[@]}" apps spec validate "$ROOT_DIR/.do/app-web.yaml"
echo "App specs OK."
