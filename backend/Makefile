FRONTEND_DIR := ../frontend
PROTO_DIR := proto
SQL_DIR := sql

.PHONY: proto sqlc gen test backend-run backend-run-local infra-up infra-down compose-up compose-down smoke

proto:
	cd $(PROTO_DIR) && buf lint
	cd $(PROTO_DIR) && buf generate
	cd $(PROTO_DIR) && buf generate --template ../../frontend/buf.gen.yaml

sqlc:
	cd $(SQL_DIR) && sqlc generate

gen: proto sqlc

test:
	go test ./...
	cd $(FRONTEND_DIR) && flutter test

backend-run:
	go run ./cmd/server

backend-run-local:
	APP_ENV=development \
	HTTP_ADDR=:8080 \
	PUBLIC_BASE_URL=http://localhost:8080 \
	DATABASE_URL=postgres://primerpeso:primerpeso@localhost:5432/primerpeso?sslmode=disable \
	ALLOWED_ORIGINS=http://localhost:3000,http://localhost:8080 \
	AUTH_SECRET=primerpeso-auth-secret-change-me \
	MASTER_KEY=primerpeso-master-key-change-me \
	HASH_KEY=primerpeso-hash-key-change-me \
	MINIO_ENDPOINT=localhost:9000 \
	MINIO_ACCESS_KEY=minioadmin \
	MINIO_SECRET_KEY=minioadmin \
	MINIO_BUCKET=primerpeso-receipts \
	MINIO_USE_SSL=false \
	SMTP_HOST=localhost \
	SMTP_PORT=1025 \
	SMTP_FROM=hola@primerpeso.local \
	MOBILE_DEEP_LINK_SCHEME=primerpeso \
	XAI_MODEL=grok-4-1-fast-reasoning \
	OCR_BACKEND=tesseract \
	OCR_LANGUAGE=spa+eng \
	go run ./cmd/server

infra-up:
	docker compose -f compose.yaml up -d postgres minio minio-init mailpit

infra-down:
	docker compose -f compose.yaml down -v

compose-up:
	docker compose -f compose.yaml up --build -d

compose-down:
	docker compose -f compose.yaml down -v

smoke: gen
	go test ./...
