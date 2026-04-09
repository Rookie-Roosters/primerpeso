package documents

import (
	"context"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"log/slog"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
	"time"

	"connectrpc.com/connect"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgtype"
	"google.golang.org/protobuf/types/known/timestamppb"

	documentsv1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/documents/v1"
	financev1 "github.com/Rookie-Roosters/primerpeso/backend/gen/proto/primerpeso/finance/v1"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/documents/store"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/authn"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/blob"
	"github.com/Rookie-Roosters/primerpeso/backend/internal/platform/connectx"
	cryptox "github.com/Rookie-Roosters/primerpeso/backend/internal/platform/crypto"
)

type OCRText struct {
	Content string
}

type OCRExtractor interface {
	Extract(ctx context.Context, content []byte, mimeType string) (OCRText, error)
}

type Service struct {
	logger    *slog.Logger
	queries   *store.Queries
	crypto    *cryptox.Service
	blobs     blob.Store
	extractor OCRExtractor
}

type storedLineItem struct {
	Description  string `json:"description"`
	CurrencyCode string `json:"currency_code"`
	Units        int64  `json:"units"`
	Nanos        int32  `json:"nanos"`
	Quantity     int32  `json:"quantity"`
}

type normalizedReceipt struct {
	MerchantName     string
	SuggestedCategory string
	RedactedText     string
	LineItems        []*documentsv1.ReceiptLineItem
	Total            *financev1.Money
	PurchasedAt      *timestamppb.Timestamp
}

var (
	amountPattern = regexp.MustCompile(`(?i)(?:total|importe|amount)?\s*[:$]?\s*([0-9]+(?:[.,][0-9]{2})?)`)
	datePatterns  = []*regexp.Regexp{
		regexp.MustCompile(`\b(\d{2}/\d{2}/\d{4})\b`),
		regexp.MustCompile(`\b(\d{4}-\d{2}-\d{2})\b`),
	}
)

func NewService(logger *slog.Logger, queries *store.Queries, crypto *cryptox.Service, blobs blob.Store, extractor OCRExtractor) *Service {
	return &Service{
		logger:    logger,
		queries:   queries,
		crypto:    crypto,
		blobs:     blobs,
		extractor: extractor,
	}
}

func (s *Service) UploadReceipt(ctx context.Context, req *connect.Request[documentsv1.UploadReceiptRequest]) (*connect.Response[documentsv1.UploadReceiptResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	if len(req.Msg.GetContent()) == 0 {
		return nil, connectx.InvalidArgument("receipt content is required")
	}

	sealedObject, encryptedDataKey, keyNonce, err := s.crypto.SealObject(req.Msg.GetContent())
	if err != nil {
		return nil, connectx.Internal("failed to encrypt receipt")
	}

	objectKey := fmt.Sprintf("%s/%s%s", userID, uuid.NewString(), filepath.Ext(req.Msg.GetFilename()))
	if err := s.blobs.PutObject(ctx, objectKey, "application/octet-stream", sealedObject); err != nil {
		return nil, connectx.Internal("failed to store encrypted receipt")
	}

	contentHash := sha256.Sum256(req.Msg.GetContent())
	upload, err := s.queries.CreateReceiptUpload(ctx, store.CreateReceiptUploadParams{
		UserID:           userID,
		ObjectKey:        objectKey,
		Filename:         req.Msg.GetFilename(),
		MimeType:         req.Msg.GetMimeType(),
		EncryptedDataKey: encryptedDataKey,
		KeyNonce:         keyNonce,
		ContentSha256:    hex.EncodeToString(contentHash[:]),
	})
	if err != nil {
		return nil, connectx.Internal("failed to persist receipt upload")
	}

	ocrText, err := s.extractor.Extract(ctx, req.Msg.GetContent(), req.Msg.GetMimeType())
	if err != nil {
		s.logger.Warn("receipt OCR fell back to filename-only extraction", "error", err)
	}

	normalized := s.normalizeReceipt(req.Msg.GetFilename(), ocrText.Content)
	encryptedMerchantName, err := s.crypto.EncryptString(normalized.MerchantName)
	if err != nil {
		return nil, connectx.Internal("failed to encrypt merchant name")
	}

	encryptedText, err := s.crypto.EncryptString(normalized.RedactedText)
	if err != nil {
		return nil, connectx.Internal("failed to encrypt OCR text")
	}

	lineItemsJSON, err := json.Marshal(toStoredLineItems(normalized.LineItems))
	if err != nil {
		return nil, connectx.Internal("failed to encode line items")
	}

	if _, err := s.queries.UpsertReceiptExtraction(ctx, store.UpsertReceiptExtractionParams{
		ReceiptID:             upload.ID,
		Status:                "ready",
		EncryptedMerchantName: encryptedMerchantName,
		MerchantHash:          s.crypto.HMACHex("merchant", strings.ToLower(normalized.MerchantName)),
		EncryptedRedactedText: encryptedText,
		DocumentFingerprint: s.crypto.HMACHex(
			"document_fingerprint",
			strings.ToLower(normalized.MerchantName)+"|"+normalized.RedactedText+"|"+moneyFingerprint(normalized.Total),
		),
		SuggestedCategory: normalized.SuggestedCategory,
		PurchasedAt:       toPGTimestamp(normalized.PurchasedAt),
		TotalCurrency:     normalized.Total.GetCurrencyCode(),
		TotalUnits:        normalized.Total.GetUnits(),
		TotalNanos:        normalized.Total.GetNanos(),
		LineItems:         lineItemsJSON,
	}); err != nil {
		return nil, connectx.Internal("failed to persist receipt extraction")
	}

	draft, err := s.LookupDraft(ctx, userID, upload.ID.String())
	if err != nil {
		return nil, connectx.Internal("failed to load receipt draft")
	}

	return connect.NewResponse(&documentsv1.UploadReceiptResponse{
		Draft: draft,
	}), nil
}

func (s *Service) GetReceiptDraft(ctx context.Context, req *connect.Request[documentsv1.GetReceiptDraftRequest]) (*connect.Response[documentsv1.GetReceiptDraftResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	draft, err := s.LookupDraft(ctx, userID, req.Msg.GetReceiptId())
	if err != nil {
		if connectx.IsNotFound(err) {
			return nil, err
		}
		return nil, connectx.Internal(err.Error())
	}

	return connect.NewResponse(&documentsv1.GetReceiptDraftResponse{Draft: draft}), nil
}

func (s *Service) ListReceiptDrafts(ctx context.Context, req *connect.Request[documentsv1.ListReceiptDraftsRequest]) (*connect.Response[documentsv1.ListReceiptDraftsResponse], error) {
	userID, ok := authn.UserID(ctx)
	if !ok {
		return nil, connectx.Unauthenticated("missing access token")
	}

	drafts, err := s.ListDrafts(ctx, userID, req.Msg.GetPageSize())
	if err != nil {
		return nil, connectx.Internal(err.Error())
	}

	return connect.NewResponse(&documentsv1.ListReceiptDraftsResponse{Drafts: drafts}), nil
}

func (s *Service) LookupDraft(ctx context.Context, userID, receiptID string) (*documentsv1.ReceiptDraft, error) {
	id, err := uuid.Parse(receiptID)
	if err != nil {
		return nil, connectx.InvalidArgument("invalid receipt id")
	}

	row, err := s.queries.GetReceiptDraft(ctx, store.GetReceiptDraftParams{
		UserID: userID,
		ID:     id,
	})
	if err != nil {
		return nil, connectx.NotFound("receipt draft not found")
	}

	return s.toDraft(row.ReceiptUpload, row.ReceiptExtraction)
}

func (s *Service) LatestDraft(ctx context.Context, userID string) (*documentsv1.ReceiptDraft, error) {
	drafts, err := s.ListDrafts(ctx, userID, 1)
	if err != nil {
		return nil, err
	}
	if len(drafts) == 0 {
		return nil, connectx.NotFound("receipt draft not found")
	}
	return drafts[0], nil
}

func (s *Service) ListDrafts(ctx context.Context, userID string, limit int32) ([]*documentsv1.ReceiptDraft, error) {
	if limit <= 0 {
		limit = 20
	}

	rows, err := s.queries.ListReceiptDrafts(ctx, store.ListReceiptDraftsParams{
		UserID: userID,
		Limit:  limit,
	})
	if err != nil {
		return nil, err
	}

	drafts := make([]*documentsv1.ReceiptDraft, 0, len(rows))
	for _, row := range rows {
		draft, err := s.toDraft(row.ReceiptUpload, row.ReceiptExtraction)
		if err != nil {
			return nil, err
		}
		drafts = append(drafts, draft)
	}

	return drafts, nil
}

func (s *Service) toDraft(upload store.ReceiptUpload, extraction store.ReceiptExtraction) (*documentsv1.ReceiptDraft, error) {
	merchantName, err := s.crypto.DecryptString(extraction.EncryptedMerchantName)
	if err != nil {
		return nil, err
	}
	rawText, err := s.crypto.DecryptString(extraction.EncryptedRedactedText)
	if err != nil {
		return nil, err
	}

	var storedItems []storedLineItem
	if len(extraction.LineItems) > 0 {
		if err := json.Unmarshal(extraction.LineItems, &storedItems); err != nil {
			return nil, err
		}
	}

	lineItems := make([]*documentsv1.ReceiptLineItem, 0, len(storedItems))
	for _, item := range storedItems {
		lineItems = append(lineItems, &documentsv1.ReceiptLineItem{
			Description: item.Description,
			Amount: &financev1.Money{
				CurrencyCode: item.CurrencyCode,
				Units:        item.Units,
				Nanos:        item.Nanos,
			},
			Quantity: item.Quantity,
		})
	}

	return &documentsv1.ReceiptDraft{
		Id:                upload.ID.String(),
		Status:            fromStatus(extraction.Status),
		MerchantName:      merchantName,
		SuggestedCategory: extraction.SuggestedCategory,
		RedactedRawText:   rawText,
		LineItems:         lineItems,
		Total: &financev1.Money{
			CurrencyCode: extraction.TotalCurrency,
			Units:        extraction.TotalUnits,
			Nanos:        extraction.TotalNanos,
		},
		PurchasedAt: fromPGTimestamp(extraction.PurchasedAt),
		CreatedAt:   fromPGTimestamp(upload.CreatedAt),
	}, nil
}

func (s *Service) normalizeReceipt(filename, rawText string) normalizedReceipt {
	redacted := strings.TrimSpace(s.crypto.RedactPII(rawText))
	lines := make([]string, 0)
	for _, line := range strings.Split(redacted, "\n") {
		trimmed := strings.TrimSpace(line)
		if trimmed != "" {
			lines = append(lines, trimmed)
		}
	}

	merchant := merchantFromLines(lines)
	if merchant == "" {
		merchant = merchantFromFilename(filename)
	}

	total := parseAmount(redacted)
	if total == nil {
		total = &financev1.Money{CurrencyCode: "MXN"}
	}

	return normalizedReceipt{
		MerchantName:      merchant,
		SuggestedCategory: suggestCategory(redacted),
		RedactedText:      redacted,
		LineItems:         nil,
		Total:             total,
		PurchasedAt:       parseDate(redacted),
	}
}

func merchantFromLines(lines []string) string {
	for _, line := range lines {
		line = strings.TrimSpace(line)
		if len(line) >= 3 {
			return line
		}
	}
	return ""
}

func merchantFromFilename(filename string) string {
	base := strings.TrimSuffix(filepath.Base(filename), filepath.Ext(filename))
	base = strings.ReplaceAll(base, "_", " ")
	base = strings.ReplaceAll(base, "-", " ")
	base = strings.TrimSpace(base)
	if base == "" {
		return "Comercio sin nombre"
	}
	return strings.Title(strings.ToLower(base))
}

func parseAmount(text string) *financev1.Money {
	matches := amountPattern.FindAllStringSubmatch(text, -1)
	if len(matches) == 0 {
		return nil
	}

	last := matches[len(matches)-1][1]
	value := strings.ReplaceAll(last, ",", ".")
	parts := strings.SplitN(value, ".", 2)
	units, _ := strconv.ParseInt(parts[0], 10, 64)

	var nanos int32
	if len(parts) == 2 {
		decimals := parts[1]
		if len(decimals) == 1 {
			decimals += "0"
		}
		if len(decimals) > 2 {
			decimals = decimals[:2]
		}
		cents, _ := strconv.ParseInt(decimals, 10, 32)
		nanos = int32(cents) * 10_000_000
	}

	return &financev1.Money{
		CurrencyCode: "MXN",
		Units:        units,
		Nanos:        nanos,
	}
}

func parseDate(text string) *timestamppb.Timestamp {
	for _, pattern := range datePatterns {
		match := pattern.FindStringSubmatch(text)
		if len(match) < 2 {
			continue
		}

		layout := "02/01/2006"
		if strings.Contains(match[1], "-") {
			layout = "2006-01-02"
		}

		if parsed, err := time.Parse(layout, match[1]); err == nil {
			return timestamppb.New(parsed)
		}
	}

	return nil
}

func suggestCategory(text string) string {
	lower := strings.ToLower(text)
	switch {
	case strings.Contains(lower, "uber"), strings.Contains(lower, "didi"), strings.Contains(lower, "gasolina"), strings.Contains(lower, "caseta"):
		return "transport"
	case strings.Contains(lower, "oxxo"), strings.Contains(lower, "super"), strings.Contains(lower, "walmart"), strings.Contains(lower, "abarrotes"):
		return "groceries"
	case strings.Contains(lower, "cafe"), strings.Contains(lower, "restaurant"), strings.Contains(lower, "restaurante"), strings.Contains(lower, "taqueria"), strings.Contains(lower, "taquería"):
		return "food"
	case strings.Contains(lower, "netflix"), strings.Contains(lower, "spotify"), strings.Contains(lower, "cine"):
		return "entertainment"
	default:
		return "general"
	}
}

func toStoredLineItems(items []*documentsv1.ReceiptLineItem) []storedLineItem {
	if len(items) == 0 {
		return nil
	}
	out := make([]storedLineItem, 0, len(items))
	for _, item := range items {
		out = append(out, storedLineItem{
			Description:  item.GetDescription(),
			CurrencyCode: item.GetAmount().GetCurrencyCode(),
			Units:        item.GetAmount().GetUnits(),
			Nanos:        item.GetAmount().GetNanos(),
			Quantity:     item.GetQuantity(),
		})
	}
	return out
}

func toPGTimestamp(ts *timestamppb.Timestamp) pgtype.Timestamptz {
	if ts == nil {
		return pgtype.Timestamptz{}
	}
	return pgtype.Timestamptz{Time: ts.AsTime(), Valid: true}
}

func fromPGTimestamp(ts pgtype.Timestamptz) *timestamppb.Timestamp {
	if !ts.Valid {
		return nil
	}
	return timestamppb.New(ts.Time)
}

func fromStatus(status string) documentsv1.ReceiptStatus {
	switch status {
	case "processing":
		return documentsv1.ReceiptStatus_RECEIPT_STATUS_PROCESSING
	case "failed":
		return documentsv1.ReceiptStatus_RECEIPT_STATUS_FAILED
	default:
		return documentsv1.ReceiptStatus_RECEIPT_STATUS_READY
	}
}

func moneyFingerprint(money *financev1.Money) string {
	if money == nil {
		return ""
	}
	return fmt.Sprintf("%s:%d:%d", money.GetCurrencyCode(), money.GetUnits(), money.GetNanos())
}
