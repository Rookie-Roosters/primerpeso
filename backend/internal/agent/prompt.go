package agent

import (
	"fmt"
	"os"
	"strings"
)

const fallbackSystemPrompt = `Eres Peso, asistente financiero de PrimerPeso.
Responde en español claro y breve.
Usa herramientas para ejecutar acciones de ledger (ingresos/gastos/movimientos) y nunca mandes al usuario a hacerlo manualmente cuando tengas herramientas disponibles.
Si un mensaje es de ledger, primero usa el contexto de movimientos recientes antes de responder o mutar.
No afirmes acciones no ejecutadas y no expongas datos sensibles completos.`

func loadSystemPrompt(path string) (string, error) {
	trimmed := strings.TrimSpace(path)
	if trimmed == "" {
		return fallbackSystemPrompt, nil
	}

	contents, err := os.ReadFile(trimmed)
	if err != nil {
		return fallbackSystemPrompt, fmt.Errorf("load system prompt: %w", err)
	}
	loaded := strings.TrimSpace(string(contents))
	if loaded == "" {
		return fallbackSystemPrompt, nil
	}
	return loaded, nil
}
