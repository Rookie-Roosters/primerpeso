FROM golang:1.26-bookworm AS builder

WORKDIR /app

ARG TARGETARCH

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

RUN go run github.com/kreuzberg-dev/kreuzberg/packages/go/v4/cmd/install@v4.8.0 --dir /opt/kreuzberg --no-generate

COPY . .

RUN case "${TARGETARCH}" in \
      amd64) KREUZBERG_LIB_DIR=/opt/kreuzberg/lib/linux_amd64 ;; \
      arm64) KREUZBERG_LIB_DIR=/opt/kreuzberg/lib/linux_arm64 ;; \
      *) echo "unsupported TARGETARCH: ${TARGETARCH}" >&2; exit 1 ;; \
    esac && \
    CGO_ENABLED=1 \
    GOOS=linux \
    CGO_CFLAGS="-I/opt/kreuzberg/include" \
    CGO_LDFLAGS="-L${KREUZBERG_LIB_DIR} -Wl,-Bstatic -lkreuzberg_ffi -Wl,-Bdynamic -lpthread -ldl -lm -lstdc++" \
    go build -tags kreuzberg -o /out/server ./cmd/server

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
