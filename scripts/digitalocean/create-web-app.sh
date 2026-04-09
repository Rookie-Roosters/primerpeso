#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

ENV_FILE="$ROOT_DIR/scripts/digitalocean/web.local.env"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing $ENV_FILE" >&2
  echo "Create it with one line, no trailing slash:" >&2
  echo '  PRIMERPESO_API_BASE_URL=https://primerpeso-api-xxxxx.ondigitalocean.app' >&2
  exit 1
fi

OUT="/tmp/primerpeso-app-web.${USER:-deploy}.yaml"
python3 "$ROOT_DIR/scripts/digitalocean/render_do_specs.py" web "$OUT"
doctl apps spec validate "$OUT"

echo "Creating web app from $OUT ..."
doctl apps create --spec "$OUT"
