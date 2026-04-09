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
- Docker, if you want to use local Postgres/MinIO/Mailpit through Compose

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

## Run The Backend

Start infrastructure:

```bash
cd backend
make compose-up
```

Run the API locally:

```bash
cd backend
make backend-run
```

The backend listens on `http://localhost:8080` by default.

Useful local services from Compose:

- Postgres: `localhost:5432`
- MinIO API: `localhost:9000`
- MinIO Console: `localhost:9001`
- Mailpit SMTP: `localhost:1025`
- Mailpit UI: `http://localhost:8025`

Stop and clean local infra:

```bash
cd backend
make compose-down
```

## Run The Frontend

```bash
cd frontend
flutter pub get
flutter run
```

The app defaults to:

- `http://10.0.2.2:8080` on Android emulators
- `http://localhost:8080` on web and other local targets

You can override the API base URL with:

```bash
flutter run --dart-define=PRIMERPESO_API_BASE_URL=http://your-host:8080
```

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

## Notes

- The frontend uses generated Connect-Dart clients from `frontend/lib/gen/`.
- A vendored `connectrpc` package lives in `frontend/packages/connectrpc/` because the published package version and the protobuf runtime required by the generated Dart code were incompatible in this environment.
- Receipt originals are stored as encrypted blobs. Sensitive extracted fields are encrypted or anonymized before storage and redacted before model use.
- The current slice is chat-first: auth, streaming agent events, receipt upload/review, expense confirmation, and score summary are wired; broader finance management remains future work.
