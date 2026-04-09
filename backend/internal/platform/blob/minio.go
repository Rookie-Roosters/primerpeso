package blob

import (
	"bytes"
	"context"
	"fmt"
	"io"

	"github.com/minio/minio-go/v7"
	"github.com/minio/minio-go/v7/pkg/credentials"

	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/config"
)

type Store interface {
	EnsureBucket(ctx context.Context) error
	PutObject(ctx context.Context, objectKey, contentType string, body []byte) error
	GetObject(ctx context.Context, objectKey string) ([]byte, error)
}

type MinIOStore struct {
	client *minio.Client
	bucket string
}

func NewMinIO(cfg config.Config) (*MinIOStore, error) {
	client, err := minio.New(cfg.MinIOEndpoint, &minio.Options{
		Creds:  credentials.NewStaticV4(cfg.MinIOAccessKey, cfg.MinIOSecretKey, ""),
		Secure: cfg.MinIOUseSSL,
	})
	if err != nil {
		return nil, err
	}

	return &MinIOStore{client: client, bucket: cfg.MinIOBucket}, nil
}

func (s *MinIOStore) EnsureBucket(ctx context.Context) error {
	exists, err := s.client.BucketExists(ctx, s.bucket)
	if err != nil {
		return err
	}
	if exists {
		return nil
	}
	return s.client.MakeBucket(ctx, s.bucket, minio.MakeBucketOptions{})
}

func (s *MinIOStore) PutObject(ctx context.Context, objectKey, contentType string, body []byte) error {
	_, err := s.client.PutObject(ctx, s.bucket, objectKey, bytes.NewReader(body), int64(len(body)), minio.PutObjectOptions{
		ContentType: contentType,
	})
	return err
}

func (s *MinIOStore) GetObject(ctx context.Context, objectKey string) ([]byte, error) {
	obj, err := s.client.GetObject(ctx, s.bucket, objectKey, minio.GetObjectOptions{})
	if err != nil {
		return nil, err
	}
	defer obj.Close()

	content, err := io.ReadAll(obj)
	if err != nil {
		return nil, fmt.Errorf("read object %s: %w", objectKey, err)
	}

	return content, nil
}
