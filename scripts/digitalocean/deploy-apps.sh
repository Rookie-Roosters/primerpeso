#!/usr/bin/env bash
# Validates App Platform YAML (requires doctl auth). For deploys:
#   create-* = create a brand-new app
#   update-* = update an existing app and redeploy sources
#
# To create with real secrets, use:
#   ./scripts/digitalocean/create-api-app.sh
#   ./scripts/digitalocean/create-web-app.sh
# To update existing apps, use:
#   ./scripts/digitalocean/update-api-app.sh
#   ./scripts/digitalocean/update-web-app.sh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

./scripts/digitalocean/doctl-auth.sh
./scripts/digitalocean/validate-app-specs.sh

echo ""
echo "Spec structure OK. Deploy with secrets from api.local.env / web.local.env:"
echo "  ./scripts/digitalocean/create-api-app.sh"
echo "  ./scripts/digitalocean/create-web-app.sh"
echo "  ./scripts/digitalocean/update-api-app.sh"
echo "  ./scripts/digitalocean/update-web-app.sh"
