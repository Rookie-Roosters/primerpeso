//go:build kreuzberg

package documents

import (
	"context"

	kreuzberg "github.com/kreuzberg-dev/kreuzberg/packages/go/v4"

	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/config"
)

type kreuzbergExtractor struct {
	cfg config.Config
}

func NewExtractor(cfg config.Config) OCRExtractor {
	return &kreuzbergExtractor{cfg: cfg}
}

func (e *kreuzbergExtractor) Extract(_ context.Context, content []byte, mimeType string) (OCRText, error) {
	forceOCR := true
	language := e.cfg.OCRLanguage
	result, err := kreuzberg.ExtractBytesSync(content, mimeType, &kreuzberg.ExtractionConfig{
		ForceOcr: &forceOCR,
		Ocr: &kreuzberg.OCRConfig{
			Backend:  e.cfg.OCRBackend,
			Language: &language,
		},
	})
	if err != nil {
		return OCRText{}, err
	}

	return OCRText{Content: result.Content}, nil
}
