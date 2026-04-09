#!/usr/bin/env bash
# After DNS is live, verify API health, CORS, and the compiled web API URL.
# Example:
#   API_BASE_URL=https://primerpeso-api-xxxxx.ondigitalocean.app \
#   WEB_BASE_URL=https://primerpeso-web-xxxxx.ondigitalocean.app \
#   ./scripts/digitalocean/post-deploy-checks.sh
set -euo pipefail

: "${API_BASE_URL:?Set API_BASE_URL to your App Platform API URL}"
: "${WEB_BASE_URL:?Set WEB_BASE_URL to your App Platform web URL}"

if [[ "$API_BASE_URL" == */ ]]; then
  echo "API_BASE_URL must not end with /" >&2
  exit 1
fi
if [[ "$WEB_BASE_URL" == */ ]]; then
  echo "WEB_BASE_URL must not end with /" >&2
  exit 1
fi

echo "[1/4] API healthz"
curl -fsS "$API_BASE_URL/healthz"
echo ""
echo "[2/4] API readyz"
curl -fsS "$API_BASE_URL/readyz"
echo ""

echo "[3/4] CORS preflight from WEB_BASE_URL"
cors_headers="$(
  curl -fsSI -X OPTIONS "$API_BASE_URL/primerpeso.finance.v1.FinanceService/ListExpenses" \
    -H "Origin: $WEB_BASE_URL" \
    -H "Access-Control-Request-Method: POST" \
    -H "Access-Control-Request-Headers: content-type,connect-protocol-version,x-device-id,authorization"
)"
cors_headers_clean="$(printf '%s' "$cors_headers" | tr -d '\r')"
echo "$cors_headers_clean"
if ! grep -qi '^HTTP/.* 204' <<<"$cors_headers_clean"; then
  echo "Expected CORS preflight status 204." >&2
  exit 1
fi
if ! grep -qi "^access-control-allow-origin: $WEB_BASE_URL\$" <<<"$cors_headers_clean"; then
  echo "Expected Access-Control-Allow-Origin to match WEB_BASE_URL." >&2
  exit 1
fi

echo "[4/4] Compiled web bundle must use API_BASE_URL and must not keep placeholder"
bundle_path="$(mktemp)"
trap 'rm -f "$bundle_path"' EXIT
curl -fsSL "$WEB_BASE_URL/main.dart.js" >"$bundle_path"
bundle_matches="$(rg -o 'https://[^\" ]+' "$bundle_path" | rg -n 'YOUR-api-host|primerpeso-api|ondigitalocean\\.app' || true)"
echo "$bundle_matches"
if rg -q 'YOUR-api-host-from-step-4' "$bundle_path"; then
  echo "main.dart.js still contains placeholder YOUR-api-host-from-step-4" >&2
  exit 1
fi
if ! rg -q "$API_BASE_URL" "$bundle_path"; then
  echo "main.dart.js does not contain expected API_BASE_URL=$API_BASE_URL" >&2
  exit 1
fi

echo "OK: all post-deploy checks passed."
