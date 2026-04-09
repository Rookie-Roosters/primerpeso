#!/usr/bin/env bash
# Optional: create a standalone DigitalOcean Managed PostgreSQL cluster (outside App Platform).
# If you use the dev database inside .do/app-api.yaml, you do not need this.
#
# Usage (edit region/size first):
#   ./scripts/digitalocean/doctl-auth.sh
#   ./scripts/digitalocean/provision-managed-postgres.sh
#
# Then set DATABASE_URL on the API app to the connection string from:
#   doctl databases connection primerpeso-pg --format ConnectionString
set -euo pipefail

NAME="${DO_PG_CLUSTER_NAME:-primerpeso-pg}"
REGION="${DO_REGION:-nyc1}"
SIZE="${DO_PG_SIZE:-db-s-1vcpu-1gb}"
VERSION="${DO_PG_VERSION:-16}"

doctl databases create "$NAME" \
  --engine pg \
  --region "$REGION" \
  --size "$SIZE" \
  --num-nodes 1 \
  --version "$VERSION"

echo "Cluster provisioning started: $NAME"
echo "Watch status: doctl databases get $NAME"
echo "Connection string: doctl databases connection $NAME"
