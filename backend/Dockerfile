FROM golang:1.26-bookworm AS builder

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    libtesseract-dev \
    libleptonica-dev \
    pkg-config \
    tesseract-ocr \
    tesseract-ocr-spa \
  && rm -rf /var/lib/apt/lists/*

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=1 \
    GOOS=linux \
    go build -o /out/server ./cmd/server

FROM debian:bookworm-slim AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libtesseract5 \
    libleptonica-dev \
    tesseract-ocr \
    tesseract-ocr-spa \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=builder /out/server /app/server
COPY sql /app/sql

EXPOSE 8080

CMD ["/app/server"]
