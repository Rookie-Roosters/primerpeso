package agent

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"sort"
	"strings"
	"unicode"
)

type aprendeCreceArticle struct {
	Title    string
	URL      string
	Summary  string
	Category string
	tokens   map[string]struct{}
}

type aprendeCreceSource struct {
	Title string
	URL   string
}

type aprendeCreceIndex struct {
	articles []aprendeCreceArticle
}

var (
	aprendeCreceHeadingRe = regexp.MustCompile(`^##\s+(.+?)\s*$`)
	aprendeCreceArticleRe = regexp.MustCompile(`^\d+\.\s+\[(.+)\]\((https?://[^)]+)\)\s*$`)
	aprendeCreceSummaryRe = regexp.MustCompile(`^\s*-\s+Resumen:\s*(.+)\s*$`)
	aprendeCreceLinkRe    = regexp.MustCompile(`\[(.+?)\]\((https?://[^)]+)\)`)
	aprendeCreceContextRe = regexp.MustCompile(`^-\s+\[(.+?)\]\((https?://[^)]+)\)\s+\[(.+?)\]:\s*(.+)\s*$`)
)

func loadAprendeCreceIndex(path string) (*aprendeCreceIndex, error) {
	trimmed := strings.TrimSpace(path)
	if trimmed == "" {
		return nil, fmt.Errorf("aprende y crece path is empty")
	}

	contents, err := os.ReadFile(trimmed)
	if err != nil {
		return nil, fmt.Errorf("read aprende y crece markdown: %w", err)
	}

	articles, err := parseAprendeCreceArticles(string(contents))
	if err != nil {
		return nil, err
	}
	if len(articles) == 0 {
		return nil, fmt.Errorf("aprende y crece markdown has no parsable articles")
	}
	return &aprendeCreceIndex{articles: articles}, nil
}

func parseAprendeCreceArticles(markdown string) ([]aprendeCreceArticle, error) {
	scanner := bufio.NewScanner(strings.NewReader(markdown))
	category := "general"
	articles := make([]aprendeCreceArticle, 0, 128)
	var pending *aprendeCreceArticle

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line == "" {
			continue
		}

		if heading := parseAprendeCreceHeading(line); heading != "" {
			if pending != nil {
				pending.tokens = tokenizeAprendeCrece(strings.Join([]string{pending.Title, pending.Summary, pending.Category}, " "))
				articles = append(articles, *pending)
				pending = nil
			}
			if !skipAprendeCreceHeading(heading) {
				category = heading
			}
			continue
		}

		if title, url, ok := parseAprendeCreceArticle(line); ok {
			if pending != nil {
				pending.tokens = tokenizeAprendeCrece(strings.Join([]string{pending.Title, pending.Summary, pending.Category}, " "))
				articles = append(articles, *pending)
			}
			pending = &aprendeCreceArticle{
				Title:    title,
				URL:      url,
				Category: category,
			}
			continue
		}

		if pending == nil {
			continue
		}
		if summary := parseAprendeCreceSummary(line); summary != "" {
			pending.Summary = summary
		}
	}

	if err := scanner.Err(); err != nil {
		return nil, fmt.Errorf("scan aprende y crece markdown: %w", err)
	}

	if pending != nil {
		pending.tokens = tokenizeAprendeCrece(strings.Join([]string{pending.Title, pending.Summary, pending.Category}, " "))
		articles = append(articles, *pending)
	}

	return articles, nil
}

func parseAprendeCreceHeading(line string) string {
	match := aprendeCreceHeadingRe.FindStringSubmatch(line)
	if len(match) != 2 {
		return ""
	}
	return strings.TrimSpace(match[1])
}

func parseAprendeCreceArticle(line string) (title, url string, ok bool) {
	match := aprendeCreceArticleRe.FindStringSubmatch(line)
	if len(match) != 3 {
		return "", "", false
	}
	title = strings.TrimSpace(match[1])
	url = strings.TrimSpace(match[2])
	if title == "" || url == "" {
		return "", "", false
	}
	return title, url, true
}

func parseAprendeCreceSummary(line string) string {
	match := aprendeCreceSummaryRe.FindStringSubmatch(line)
	if len(match) != 2 {
		return ""
	}
	return strings.TrimSpace(match[1])
}

func skipAprendeCreceHeading(heading string) bool {
	normalized := normalizeAprendeCreceText(heading)
	switch normalized {
	case "", "indice por categoria", "instrucciones de uso para el agente":
		return true
	default:
		return false
	}
}

func (i *aprendeCreceIndex) Search(query string, maxResults int) []aprendeCreceArticle {
	if i == nil || maxResults <= 0 {
		return nil
	}
	queryTokens := tokenizeAprendeCrece(query)
	if len(queryTokens) == 0 {
		return nil
	}

	type scoredArticle struct {
		article aprendeCreceArticle
		score   int
	}
	scored := make([]scoredArticle, 0, len(i.articles))
	for _, article := range i.articles {
		score := 0
		for token := range queryTokens {
			if _, ok := article.tokens[token]; ok {
				score++
			}
		}
		if score > 0 {
			scored = append(scored, scoredArticle{article: article, score: score})
		}
	}

	sort.Slice(scored, func(a, b int) bool {
		if scored[a].score != scored[b].score {
			return scored[a].score > scored[b].score
		}
		return scored[a].article.Title < scored[b].article.Title
	})

	if len(scored) > maxResults {
		scored = scored[:maxResults]
	}
	out := make([]aprendeCreceArticle, 0, len(scored))
	for _, item := range scored {
		out = append(out, item.article)
	}
	return out
}

func formatAprendeCreceContext(results []aprendeCreceArticle) string {
	if len(results) == 0 {
		return ""
	}

	var b strings.Builder
	b.WriteString("APRENDE_CRECE_CONTEXT:\n")
	for _, article := range results {
		summary := strings.TrimSpace(article.Summary)
		if summary == "" {
			summary = "Sin resumen disponible en la base local."
		}
		b.WriteString(fmt.Sprintf("- [%s](%s) [%s]: %s\n", article.Title, article.URL, article.Category, shortenAprendeCreceSummary(summary, 240)))
	}
	b.WriteString("APRENDE_CRECE_SOURCES:\n")
	for _, article := range results {
		b.WriteString(fmt.Sprintf("- [%s](%s)\n", article.Title, article.URL))
	}
	return strings.TrimSpace(b.String())
}

func extractAprendeCreceSources(toolContext string) []aprendeCreceSource {
	if !strings.Contains(toolContext, "APRENDE_CRECE_SOURCES:") {
		return nil
	}

	lines := strings.Split(toolContext, "\n")
	inSources := false
	seen := map[string]struct{}{}
	sources := make([]aprendeCreceSource, 0, 4)

	for _, raw := range lines {
		line := strings.TrimSpace(raw)
		if line == "" {
			continue
		}
		if strings.HasPrefix(line, "APRENDE_CRECE_SOURCES:") {
			inSources = true
			continue
		}
		if strings.HasPrefix(line, "APRENDE_CRECE_") && inSources {
			break
		}
		if !inSources {
			continue
		}
		match := aprendeCreceLinkRe.FindStringSubmatch(line)
		if len(match) != 3 {
			continue
		}
		title := strings.TrimSpace(match[1])
		url := strings.TrimSpace(match[2])
		if title == "" || url == "" {
			continue
		}
		if _, ok := seen[url]; ok {
			continue
		}
		seen[url] = struct{}{}
		sources = append(sources, aprendeCreceSource{
			Title: title,
			URL:   url,
		})
	}

	return sources
}

func ensureAprendeCreceSourceLink(reply, toolContext string) string {
	trimmedReply := strings.TrimSpace(reply)
	sources := extractAprendeCreceSources(toolContext)
	if len(sources) == 0 {
		return trimmedReply
	}
	for _, source := range sources {
		if strings.Contains(trimmedReply, source.URL) {
			return trimmedReply
		}
	}

	sourceLine := fmt.Sprintf("Fuente: [%s](%s)", sources[0].Title, sources[0].URL)
	if trimmedReply == "" {
		return sourceLine
	}
	return trimmedReply + "\n\n" + sourceLine
}

func fallbackAprendeCreceReply(toolContext string) string {
	items := extractAprendeCreceContextItems(toolContext)
	if len(items) == 0 {
		return ""
	}

	first := items[0]
	summary := strings.TrimSpace(first.Summary)
	if summary == "" {
		return fmt.Sprintf("Encontré una guía relevante de Aprende y Crece: %s.", first.Title)
	}
	if strings.HasSuffix(summary, ".") {
		return "Encontré esta explicación en Aprende y Crece: " + summary
	}
	return "Encontré esta explicación en Aprende y Crece: " + summary + "."
}

func extractAprendeCreceContextItems(toolContext string) []aprendeCreceArticle {
	if !strings.Contains(toolContext, "APRENDE_CRECE_CONTEXT:") {
		return nil
	}

	lines := strings.Split(toolContext, "\n")
	inContext := false
	items := make([]aprendeCreceArticle, 0, 4)

	for _, raw := range lines {
		line := strings.TrimSpace(raw)
		if line == "" {
			continue
		}
		if strings.HasPrefix(line, "APRENDE_CRECE_CONTEXT:") {
			inContext = true
			continue
		}
		if strings.HasPrefix(line, "APRENDE_CRECE_SOURCES:") {
			break
		}
		if !inContext {
			continue
		}
		match := aprendeCreceContextRe.FindStringSubmatch(line)
		if len(match) != 5 {
			continue
		}
		items = append(items, aprendeCreceArticle{
			Title:    strings.TrimSpace(match[1]),
			URL:      strings.TrimSpace(match[2]),
			Category: strings.TrimSpace(match[3]),
			Summary:  strings.TrimSpace(match[4]),
		})
	}

	return items
}

func tokenizeAprendeCrece(text string) map[string]struct{} {
	normalized := normalizeAprendeCreceText(text)
	fields := strings.Fields(normalized)
	out := make(map[string]struct{}, len(fields))
	for _, token := range fields {
		if len(token) < 3 {
			continue
		}
		out[token] = struct{}{}
	}
	return out
}

func normalizeAprendeCreceText(text string) string {
	lower := strings.ToLower(strings.TrimSpace(text))
	if lower == "" {
		return ""
	}
	replacer := strings.NewReplacer(
		"á", "a",
		"é", "e",
		"í", "i",
		"ó", "o",
		"ú", "u",
		"ü", "u",
		"ñ", "n",
	)
	lower = replacer.Replace(lower)

	var b strings.Builder
	for _, r := range lower {
		switch {
		case unicode.IsLetter(r), unicode.IsDigit(r), unicode.IsSpace(r):
			b.WriteRune(r)
		default:
			b.WriteRune(' ')
		}
	}
	return strings.Join(strings.Fields(b.String()), " ")
}

func shortenAprendeCreceSummary(summary string, limit int) string {
	if limit <= 0 || len(summary) <= limit {
		return summary
	}
	cut := limit
	if idx := strings.LastIndex(summary[:limit], " "); idx > 0 {
		cut = idx
	}
	return strings.TrimSpace(summary[:cut]) + "..."
}
