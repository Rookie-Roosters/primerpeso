FRONTEND_DIR := ../frontend
PROTO_DIR := proto
SQL_DIR := sql

.PHONY: proto sqlc gen test backend-run compose-up compose-down smoke

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

compose-up:
	docker compose -f compose.yaml up --build -d

compose-down:
	docker compose -f compose.yaml down -v

smoke: gen
	go test ./...
