#!/usr/bin/env bash
# After DNS is live, verify the API responds (set API_BASE_URL including scheme, no trailing slash).
# Example:
#   API_BASE_URL=https://primerpeso-api-xxxxx.ondigitalocean.app ./scripts/digitalocean/post-deploy-checks.sh
set -euo pipefail

: "${API_BASE_URL:?Set API_BASE_URL to your App Platform API URL}"

curl -fsS "$API_BASE_URL/healthz"
echo ""
curl -fsS "$API_BASE_URL/readyz"
echo ""
echo "OK: healthz and readyz succeeded."
