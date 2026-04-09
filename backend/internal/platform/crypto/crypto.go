package crypto

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/hmac"
	"crypto/rand"
	"crypto/sha256"
	"encoding/base64"
	"encoding/hex"
	"errors"
	"fmt"
	"io"
	"regexp"
	"strings"
)

const gcmNonceSize = 12

var (
	emailPattern = regexp.MustCompile(`[\w.\-+]+@[\w.\-]+\.[A-Za-z]{2,}`)
	phonePattern = regexp.MustCompile(`(?:\+?52[\s-]?)?(?:\d[\s-]?){10}`)
	cardPattern  = regexp.MustCompile(`\b(?:\d[ -]?){13,19}\b`)
	clabePattern = regexp.MustCompile(`\b\d{18}\b`)
)

type Service struct {
	masterKey []byte
	hashKey   []byte
}

func New(masterKey, hashKey string) (*Service, error) {
	master, err := decodeKey(masterKey)
	if err != nil {
		return nil, fmt.Errorf("decode master key: %w", err)
	}

	hashSecret, err := decodeKey(hashKey)
	if err != nil {
		return nil, fmt.Errorf("decode hash key: %w", err)
	}

	return &Service{masterKey: master, hashKey: hashSecret}, nil
}

func (s *Service) EncryptBytes(plaintext []byte) ([]byte, error) {
	return sealWithKey(s.masterKey, plaintext)
}

func (s *Service) DecryptBytes(ciphertext []byte) ([]byte, error) {
	return openWithKey(s.masterKey, ciphertext)
}

func (s *Service) EncryptString(value string) ([]byte, error) {
	return s.EncryptBytes([]byte(value))
}

func (s *Service) DecryptString(ciphertext []byte) (string, error) {
	plaintext, err := s.DecryptBytes(ciphertext)
	if err != nil {
		return "", err
	}
	return string(plaintext), nil
}

func (s *Service) SealObject(plaintext []byte) (sealedObject, encryptedDataKey, keyNonce []byte, err error) {
	dataKey := make([]byte, 32)
	if _, err = io.ReadFull(rand.Reader, dataKey); err != nil {
		return nil, nil, nil, err
	}

	sealedObject, err = sealWithKey(dataKey, plaintext)
	if err != nil {
		return nil, nil, nil, err
	}

	encryptedDataKey, keyNonce, err = sealDetached(s.masterKey, dataKey)
	if err != nil {
		return nil, nil, nil, err
	}

	return sealedObject, encryptedDataKey, keyNonce, nil
}

func (s *Service) OpenObject(sealedObject, encryptedDataKey, keyNonce []byte) ([]byte, error) {
	dataKey, err := openDetached(s.masterKey, encryptedDataKey, keyNonce)
	if err != nil {
		return nil, err
	}
	return openWithKey(dataKey, sealedObject)
}

func (s *Service) HMACHex(purpose, value string) string {
	mac := hmac.New(sha256.New, s.hashKey)
	_, _ = mac.Write([]byte(purpose))
	_, _ = mac.Write([]byte{':'})
	_, _ = mac.Write([]byte(value))
	return hex.EncodeToString(mac.Sum(nil))
}

func (s *Service) RedactPII(text string) string {
	redacted := emailPattern.ReplaceAllString(text, "[email]")
	redacted = phonePattern.ReplaceAllString(redacted, "[phone]")
	redacted = clabePattern.ReplaceAllString(redacted, "[clabe]")
	redacted = cardPattern.ReplaceAllString(redacted, "[card]")
	return redacted
}

func decodeKey(raw string) ([]byte, error) {
	raw = strings.TrimSpace(raw)
	if raw == "" {
		return nil, errors.New("empty key")
	}

	if decoded, err := base64.StdEncoding.DecodeString(raw); err == nil && len(decoded) >= 32 {
		return decoded[:32], nil
	}

	if decoded, err := base64.RawStdEncoding.DecodeString(raw); err == nil && len(decoded) >= 32 {
		return decoded[:32], nil
	}

	if decoded, err := hex.DecodeString(raw); err == nil && len(decoded) >= 32 {
		return decoded[:32], nil
	}

	sum := sha256.Sum256([]byte(raw))
	return sum[:], nil
}

func sealWithKey(key, plaintext []byte) ([]byte, error) {
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}

	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return nil, err
	}

	nonce := make([]byte, gcmNonceSize)
	if _, err := io.ReadFull(rand.Reader, nonce); err != nil {
		return nil, err
	}

	ciphertext := gcm.Seal(nil, nonce, plaintext, nil)
	return append(nonce, ciphertext...), nil
}

func openWithKey(key, ciphertext []byte) ([]byte, error) {
	if len(ciphertext) < gcmNonceSize {
		return nil, errors.New("ciphertext too short")
	}

	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}

	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return nil, err
	}

	return gcm.Open(nil, ciphertext[:gcmNonceSize], ciphertext[gcmNonceSize:], nil)
}

func sealDetached(key, plaintext []byte) (ciphertext, nonce []byte, err error) {
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, nil, err
	}

	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return nil, nil, err
	}

	nonce = make([]byte, gcmNonceSize)
	if _, err := io.ReadFull(rand.Reader, nonce); err != nil {
		return nil, nil, err
	}

	return gcm.Seal(nil, nonce, plaintext, nil), nonce, nil
}

func openDetached(key, ciphertext, nonce []byte) ([]byte, error) {
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}

	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return nil, err
	}

	return gcm.Open(nil, nonce, ciphertext, nil)
}
