---
name: go-router
description: Configure Flutter navigation with go_router (GoRouter, routes, redirects, ShellRoute, deep links, type-safe routes). Use when adding or changing app routing, URL-based navigation, auth redirects, nested shells, or when the user mentions go_router, context.go, or GoRoute.
---

# Flutter go_router

Declarative routing with URL-based navigation, redirects, and nested shells. Use **official** [go_router documentation](https://pub.dev/packages/go_router) (README links) for API details.

Read [references/go-router-links.md](references/go-router-links.md) for canonical URLs.

## Stack posture (project defaults)

- **App shell:** `MaterialApp.router` with `routerConfig: GoRouter(...)` (or equivalent setup per package version).
- **Forui:** Keep **`FTheme`**, **`FToaster`**, and **`FTooltipGroup`** in `MaterialApp.router(..., builder: (_, child) => ...)` so every route’s `child` sits under Forui overlays and theme (same idea as Forui’s router template).
- **UI:** Prefer [Forui](../flutter-forui/SKILL.md) inside route pages; **Mix** only when needed ([flutter-mix-v2](../flutter-mix-v2/SKILL.md)).

## Core concepts

- **GoRouter:** top-level configuration; `routes`, `initialLocation`, `redirect`, `errorBuilder`, etc.
- **GoRoute:** path, `builder`, nested `routes`, path/query parameters.
- **ShellRoute:** persistent UI (e.g. bottom navigation, sidebar) with an inner navigator; read ShellRoute docs for nested `Navigator` behavior.
- **Navigation:** `context.go`, `context.push`, `context.pop` (and named variants) per project conventions; `go` replaces stack; `push` stacks.

## Redirects and guards

- Use `redirect` on `GoRouter` or routes for auth, onboarding, or feature flags.
- Keep redirect logic deterministic and testable; avoid heavy async in redirect unless documented.

## Deep linking and web

- Follow package guides for path parameters, query parameters, and web URL sync.

## Type-safe routes

- Optional codegen or typed routes; follow the chosen project pattern if already present.

## Validation checklist

- [ ] Forui `builder` wraps route `child` when the app uses Forui.
- [ ] Shell routes match product UX (tabs/sidebar) without breaking back stack expectations.
- [ ] Redirects handle logged-out and deep-link edge cases as required.
