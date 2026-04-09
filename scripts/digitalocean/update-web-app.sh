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

API_BASE_URL="$(
  awk -F= '/^PRIMERPESO_API_BASE_URL=/{print $2; exit}' "$ENV_FILE" \
    | tr -d '"' \
    | tr -d "'"
)"
if [[ -z "$API_BASE_URL" ]]; then
  echo "PRIMERPESO_API_BASE_URL is empty in $ENV_FILE" >&2
  exit 1
fi
if [[ "$API_BASE_URL" == *"YOUR-api-host"* ]]; then
  echo "PRIMERPESO_API_BASE_URL still uses a placeholder in $ENV_FILE: $API_BASE_URL" >&2
  exit 1
fi
if [[ "$API_BASE_URL" != https://* ]]; then
  echo "PRIMERPESO_API_BASE_URL must start with https:// in $ENV_FILE: $API_BASE_URL" >&2
  exit 1
fi
if [[ "$API_BASE_URL" == */ ]]; then
  echo "PRIMERPESO_API_BASE_URL must not end with / in $ENV_FILE: $API_BASE_URL" >&2
  exit 1
fi

OUT="/tmp/primerpeso-app-web.${USER:-deploy}.yaml"
python3 "$ROOT_DIR/scripts/digitalocean/render_do_specs.py" web "$OUT"
doctl apps spec validate "$OUT"

APP_NAME="${APP_NAME:-primerpeso-web}"
APP_ID="${APP_ID:-$(doctl apps list --format ID,Spec.Name --no-header | awk -v name="$APP_NAME" '$2 == name {print $1; exit}')}"
if [[ -z "$APP_ID" ]]; then
  echo "Could not find app id for APP_NAME=$APP_NAME. Set APP_ID explicitly." >&2
  exit 1
fi

echo "Updating web app $APP_NAME ($APP_ID) from $OUT ..."
doctl apps update "$APP_ID" --spec "$OUT" --update-sources --wait
