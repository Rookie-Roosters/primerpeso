//go:build kreuzberg

package documents

import "github.com/Rookie-Roosters/primerpeso/backend/internal/platform/config"

func NewExtractor(cfg config.Config) OCRExtractor {
	return newMultimodalExtractor(cfg)
}
