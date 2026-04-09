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

ALLOWED_ORIGINS="$(
  awk -F= '/^ALLOWED_ORIGINS=/{print $2; exit}' "$ENV_FILE" \
    | tr -d '"' \
    | tr -d "'"
)"
if [[ -z "$ALLOWED_ORIGINS" ]]; then
  echo "ALLOWED_ORIGINS is required in $ENV_FILE" >&2
  exit 1
fi
if [[ "$ALLOWED_ORIGINS" == "*" ]]; then
  echo "Warning: ALLOWED_ORIGINS=* is permissive and high-risk in production." >&2
fi

OUT="/tmp/primerpeso-app-api.${USER:-deploy}.yaml"
python3 "$ROOT_DIR/scripts/digitalocean/render_do_specs.py" api "$OUT"
doctl apps spec validate "$OUT"

APP_NAME="${APP_NAME:-primerpeso-api}"
APP_ID="${APP_ID:-$(doctl apps list --format ID,Spec.Name --no-header | awk -v name="$APP_NAME" '$2 == name {print $1; exit}')}"
if [[ -z "$APP_ID" ]]; then
  echo "Could not find app id for APP_NAME=$APP_NAME. Set APP_ID explicitly." >&2
  exit 1
fi

echo "Updating API app $APP_NAME ($APP_ID) from $OUT ..."
doctl apps update "$APP_ID" --spec "$OUT" --update-sources --wait
