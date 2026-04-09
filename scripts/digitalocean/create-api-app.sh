#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

ENV_FILE="$ROOT_DIR/scripts/digitalocean/api.local.env"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing $ENV_FILE" >&2
  echo "Copy scripts/digitalocean/api.local.env.example and fill in secrets (Spaces, XAI, SMTP)." >&2
  echo "Generate AUTH_SECRET, MASTER_KEY, HASH_KEY: openssl rand -hex 32" >&2
  exit 1
fi

OUT="/tmp/primerpeso-app-api.${USER:-deploy}.yaml"
python3 "$ROOT_DIR/scripts/digitalocean/render_do_specs.py" api "$OUT"
doctl apps spec validate "$OUT"

echo "Creating App Platform app from $OUT ..."
doctl apps create --spec "$OUT"
echo ""
echo "Watch: doctl apps list"
echo "Logs: doctl apps logs <APP_ID> --type run --follow"
echo "After deploy, add web URL to tighten CORS: set ALLOWED_ORIGINS on the api component (optional; '*' works for dev)."
