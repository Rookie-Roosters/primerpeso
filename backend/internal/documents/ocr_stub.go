//go:build !kreuzberg

package documents

import (
	"context"

	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/config"
)

type stubExtractor struct{}

func NewExtractor(cfg config.Config) OCRExtractor {
	return newMultimodalExtractor(cfg)
}

func (stubExtractor) Extract(_ context.Context, content []byte, mimeType string) (OCRText, error) {
	if len(content) == 0 {
		return OCRText{}, nil
	}

	if mimeType == "text/plain" {
		return OCRText{Content: string(content)}, nil
	}

	return OCRText{}, nil
}
