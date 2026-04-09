---
name: flutter-mix-v2
description: Style Flutter UIs with Mix v2 (BoxStyler, mix tokens, variants, MixScope, Box, StyledText). Use when adding Mix, mix_tailwinds, design tokens, hover/dark/breakpoint styling, or composable styles outside raw ThemeData; or when the user mentions Mix, MixScope, or fluttermix.com.
---

# Flutter Mix v2

**Mix** separates style definitions from widget structure: composable, type-safe styling with tokens and context-aware variants.

Read [references/mix-links.md](references/mix-links.md) for official URLs and version bounds.

## Stack posture (project defaults)

- **UI components:** Prefer [Forui](../flutter-forui/SKILL.md) for standard surfaces and controls; use Mix for **custom** layout and **token-driven** styling when Forui does not cover the need.
- **Do not** replace `FThemeData` / `context.theme` for an all-Forui screen unless the team explicitly uses Mix alongside Forui for that layer.
- **Navigation:** [go_router](../go-router/SKILL.md) stays independent; Mix does not replace routing.

## When to use Mix

- Shared **design tokens** (colors, spacing) via `MixScope` and token types.
- **Variants:** `onHovered`, `onPressed`, `onFocused`, `onDisabled`, `onDark`, `onLight`, `onBreakpoint`, `onMobile`, `onTablet`, `onDesktop`, etc.
- **Composable styles** merged and reused across widgets (`BoxStyler`, `TextStyler`, `Box`, `StyledText`, `FlexBox`, `Stack`, etc. per docs).
- Optional: **mix_tailwinds** for utility-first styling similar to Tailwind.

## Coexistence with Forui

- For **Forui widgets**, rely on `FTheme`, deltas, and CLI-generated styles first.
- Use Mix for **non-Forui** subtrees, bespoke visuals, or app-wide token systems that predate Forui adoption.
- Avoid expressing the **same** visual rule in both `FThemeData` deltas and Mix without a documented convention.

## Prerequisites

- Dart **3.11.0+**, Flutter **3.41.0+** (aligns with modern Forui and current Flutter lines).

## Patterns (high level)

- Build styles with fluent API (`BoxStyler()`, `TextStyler()`); later overrides win when chained.
- Provide tokens via `MixScope(colors: {...}, spaces: {...}, ...)` and resolve with token functions in stylers.
- Use variants for interaction and theme breakpoints instead of ad-hoc `StatefulWidget` branches when Mix fits.

See upstream guides: Styling, Dynamic styling, Design tokens, Animations (fluttermix.com).

## Validation checklist

- [ ] Confirmed Forui does not already solve the UI need before introducing Mix.
- [ ] SDK constraints in `pubspec.yaml` meet Mix v2 requirements.
- [ ] Tokens/scopes are not duplicated in conflict with `FThemeData` without team agreement.
