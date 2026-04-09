#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKEND_DIR="$ROOT_DIR/backend"
FRONTEND_DIR="$ROOT_DIR/frontend"

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

step() {
  printf '\n==> %s\n' "$1"
}

require_cmd go
require_cmd flutter
require_cmd buf
require_cmd sqlc

step "Generating protobuf, Connect, and sqlc code"
make -C "$BACKEND_DIR" gen

step "Running backend tests"
(
  cd "$BACKEND_DIR"
  go test ./...
)

step "Fetching frontend dependencies"
(
  cd "$FRONTEND_DIR"
  flutter pub get
)

step "Running frontend tests"
(
  cd "$FRONTEND_DIR"
  flutter test
)

step "Analyzing frontend"
(
  cd "$FRONTEND_DIR"
  flutter analyze
)

printf '\nLocal validation passed.\n'

if command -v docker >/dev/null 2>&1; then
  cat <<'EOF'

Next runtime checks:
  cd backend && make compose-up
  curl http://localhost:8080/healthz
  curl http://localhost:8080/readyz
  cd frontend && flutter run -d chrome
EOF
else
  cat <<'EOF'

Docker is not available in PATH.
Runtime validation still requires Docker for Postgres, MinIO, and Mailpit.
EOF
fi
