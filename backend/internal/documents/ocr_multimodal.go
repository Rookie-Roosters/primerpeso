package documents

import (
	"bytes"
	"context"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/config"
)

type multimodalExtractor struct {
	cfg config.Config
}

func newMultimodalExtractor(cfg config.Config) OCRExtractor {
	return &multimodalExtractor{cfg: cfg}
}

func (e *multimodalExtractor) Extract(ctx context.Context, content []byte, mimeType string) (OCRText, error) {
	if len(content) == 0 {
		return OCRText{}, nil
	}
	if strings.TrimSpace(e.cfg.XAIAPIKey) == "" {
		return OCRText{}, nil
	}

	raw, err := e.callXAI(ctx, content, mimeType)
	if err != nil {
		return OCRText{}, err
	}
	return OCRText{Content: strings.TrimSpace(raw)}, nil
}

func (e *multimodalExtractor) callXAI(ctx context.Context, content []byte, mimeType string) (string, error) {
	payload := map[string]any{
		"model": e.cfg.XAIModel,
		"messages": []map[string]any{
			{
				"role":    "system",
				"content": "You extract text from receipts/documents. Return plain text only, no markdown.",
			},
			{
				"role": "user",
				"content": []map[string]any{
					{
						"type": "text",
						"text": "Extract all visible text from this receipt or document, preserving line breaks when possible.",
					},
					{
						"type": "image_url",
						"image_url": map[string]any{
							"url": dataURL(content, mimeType),
						},
					},
				},
			},
		},
		"temperature": 0.0,
	}

	body, err := json.Marshal(payload)
	if err != nil {
		return "", err
	}

	requestCtx, cancel := context.WithTimeout(ctx, 25*time.Second)
	defer cancel()

	req, err := http.NewRequestWithContext(
		requestCtx,
		http.MethodPost,
		strings.TrimRight(e.cfg.XAIBaseURL, "/")+"/chat/completions",
		bytes.NewReader(body),
	)
	if err != nil {
		return "", err
	}
	req.Header.Set("Authorization", "Bearer "+e.cfg.XAIAPIKey)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	if err != nil {
		return "", err
	}
	defer res.Body.Close()

	if res.StatusCode >= 300 {
		return "", fmt.Errorf("xai extraction failed with status %d", res.StatusCode)
	}

	var parsed map[string]any
	if err := json.NewDecoder(res.Body).Decode(&parsed); err != nil {
		return "", err
	}

	choices, _ := parsed["choices"].([]any)
	if len(choices) == 0 {
		return "", nil
	}
	first, _ := choices[0].(map[string]any)
	message, _ := first["message"].(map[string]any)

	if content, ok := message["content"].(string); ok {
		return content, nil
	}

	contentParts, _ := message["content"].([]any)
	var out strings.Builder
	for _, part := range contentParts {
		item, _ := part.(map[string]any)
		if text, ok := item["text"].(string); ok {
			if out.Len() > 0 {
				out.WriteString("\n")
			}
			out.WriteString(text)
		}
	}
	return out.String(), nil
}

func dataURL(content []byte, mimeType string) string {
	kind := mimeType
	if strings.TrimSpace(kind) == "" {
		kind = "application/octet-stream"
	}
	return fmt.Sprintf(
		"data:%s;base64,%s",
		kind,
		base64.StdEncoding.EncodeToString(content),
	)
}
