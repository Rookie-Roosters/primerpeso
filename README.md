# PrimerPeso

PrimerPeso is a mobile-first personal finance app with:

- A Flutter frontend in `frontend/`
- A Go backend in `backend/`
- ConnectRPC + protobuf contracts shared through `backend/proto/`
- Postgres + sqlc sources under `backend/sql/`
- Auth, agent streaming, receipt OCR/extraction, expense confirmation, and score retrieval in the first backend slice

## Repository Layout

- `backend/`: Go application, local ops files, compose, Dockerfile, proto, and SQL sources
- `frontend/`: Flutter client using generated Connect-Dart clients

Important backend paths:

- `backend/proto/`: `.proto` files plus Buf config
- `backend/sql/`: migrations, queries, and `sqlc.yaml`
- `frontend/buf.gen.yaml`: Dart codegen template for frontend client generation
- `backend/cmd/server/`: application entrypoint
- `backend/internal/`: feature-oriented application packages

## Requirements

- Go
- Flutter
- Buf
- sqlc
- Docker, if you want to run the local stack or validate runtime behavior end-to-end

## Generate Code

All codegen now runs from `backend/`.

```bash
cd backend
make gen
```

That does:

- `buf lint`
- Go protobuf/connect generation from `backend/proto/`
- Dart protobuf/connect generation into `frontend/lib/gen/`
- sqlc generation from `backend/sql/sqlc.yaml`

## Quick Validation

Run the static validation flow from the repository root:

```bash
./scripts/validate-local.sh
```

That runs codegen, backend tests, `flutter pub get`, frontend tests, and
`flutter analyze`.

## Run The Backend

There are two supported local modes.

### Full Stack In Docker

This starts Postgres, MinIO, Mailpit, and the backend container together:

```bash
cd backend
make compose-up
```

The backend listens on `http://localhost:8080`.

Useful local services from Compose:

- Postgres: `localhost:5432`
- MinIO API: `localhost:9000`
- MinIO Console: `localhost:9001`
- Mailpit SMTP: `localhost:1025`
- Mailpit UI: `http://localhost:8025`

Stop and clean the stack:

```bash
cd backend
make compose-down
```

### Backend On Host + Infra In Docker

If you want to run the Go backend directly on your machine, start only the
supporting services first:

```bash
cd backend
make infra-up
```

Then start the backend on your host with local defaults wired in:

```bash
cd backend
make backend-run-local
```

This uses:

- Postgres at `localhost:5432`
- MinIO at `localhost:9000`
- Mailpit at `localhost:1025`

Stop and clean the local services:

```bash
cd backend
make infra-down
```

Important:

- `make compose-up` already starts a backend container on port `8080`. Do not
  run `make backend-run` or `make backend-run-local` at the same time unless you
  change ports.
- `make backend-run-local` uses your host OCR dependencies (`tesseract` +
  language data). If OCR fails locally, verify those packages are installed.

## Run The Frontend

```bash
cd frontend
flutter pub get
flutter run
```

For web performance checks, avoid debug mode because startup and rendering are
significantly slower than production:

```bash
cd frontend
flutter run -d chrome --profile
# or:
flutter build web --release
```

The app defaults to:

- `http://10.0.2.2:8080` on Android emulators
- `http://localhost:8080` on web and other local targets

You can override the API base URL with:

```bash
flutter run --dart-define=PRIMERPESO_API_BASE_URL=http://your-host:8080
```

For example, if you run the backend remotely or on a physical device, point the
frontend at that reachable host.

## Tests

Backend:

```bash
cd backend
go test ./...
```

Frontend:

```bash
cd frontend
flutter test
```

Or run both from the backend Makefile:

```bash
cd backend
make test
```

Runtime smoke checks after the backend is up:

```bash
curl http://localhost:8080/healthz
curl http://localhost:8080/readyz
```

## Notes

- The frontend uses generated Connect-Dart clients from `frontend/lib/gen/`.
- A vendored `connectrpc` package lives in `frontend/packages/connectrpc/` because the published package version and the protobuf runtime required by the generated Dart code were incompatible in this environment.
- Receipt originals are stored as encrypted blobs. Sensitive extracted fields are encrypted or anonymized before storage and redacted before model use.
- The current slice is chat-first: auth, streaming agent events, receipt upload/review, expense confirmation, and score summary are wired; broader finance management remains future work.
- Google OAuth stays disabled until `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` are set.
- Agent chat can run without `XAI_API_KEY`, but it will use fallback replies instead of the xAI-backed model path.
