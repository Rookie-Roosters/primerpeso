---
name: flutter-forui
description: Build, refactor, or review Flutter UIs with the Forui component library (FTheme, FScaffold, forms, overlays, theming). Use when adding screens or widgets with Forui, customizing FThemeData, using Forui CLI for styles/themes, integrating FLocalizations, or when the user mentions Forui, FButton, FScaffold, or shadcn-style Flutter UI.
---

# Flutter Forui

Prefer **Forui** widgets over Material/Cupertino when an equivalent exists. Before building a custom control, confirm Forui does not already ship it (docs + CLI).

Read [references/forui-links.md](references/forui-links.md) for URLs. For exhaustive API and examples, use the project’s network access to open **https://forui.dev/docs/llms-full.txt** or browse https://forui.dev/docs/llms.txt.

## Stack posture (project defaults)

- **UI:** Forui first; check [llms-full.txt](https://forui.dev/docs/llms-full.txt) and/or `dart run forui style ls` before inventing widgets.
- **Styling extras:** Use [Mix v2](../flutter-mix-v2/SKILL.md) only for surfaces/tokens outside Forui’s coverage; do not duplicate `FThemeData` without a project convention.
- **Navigation:** Use [go_router](../go-router/SKILL.md) at the app shell; wrap the routed subtree with `FTheme` / `FToaster` / `FTooltipGroup` in `MaterialApp.router`’s `builder`.

## App shell

- Use `MaterialApp` or `MaterialApp.router` with `theme: theme.toApproximateMaterialTheme()` where `theme` is `FThemeData` (e.g. `FThemes.neutral.light.touch`).
- Wrap the child: `builder: (_, child) => FTheme(data: theme, child: FToaster(child: FTooltipGroup(child: child!)))`.
- Add `supportedLocales` and `localizationsDelegates` from `FLocalizations` when the app should localize Forui widgets (see docs).
- Pick **touch** vs **desktop** theme variants per platform (`FThemes.*.*.touch` vs `.desktop`) or override with `FTheme(platform: ...)`.

## Prefer Forui widgets

Use Forui for: layout (`FScaffold`, `FHeader`, sidebars, bottom nav), actions (`FButton`, tiles, items), forms (`FTextField`, `FTextFormField`, selects, date/time fields, checkboxes, switches, sliders), feedback (`FAlert`, progress, toast via `showFToast`), overlays (`showFDialog`, `showFSheet`, `FPopover`, tooltips), and lists (`FItemGroup`, `FTileGroup`), etc.

Avoid `ElevatedButton`, `TextField`, `Card`, `Scaffold`, `AlertDialog`, etc., when Forui provides a counterpart.

## When Material/Cupertino is acceptable

- APIs that only exist on Material/Cupertino and have no Forui equivalent.
- Existing files already committed to Material; do not mass-migrate unless asked.
- Prefer `package:flutter/widgets.dart` for imports where the file does not need Material types.

## Controls (lifted vs managed)

Forui uses **controls** instead of passing raw controllers everywhere.

- **Lifted:** Parent owns state; widget reflects values (like React controlled components). Use when syncing with app state (e.g. Riverpod).
- **Managed (internal):** Widget owns state; good for prototypes and simple defaults.
- **Managed (external controller):** You own the controller lifecycle; use for hooks or imperative show/hide.

Start with managed internal; switch to lifted when bidirectional sync with app logic is required.

## CLI discovery

From the Flutter project:

- `dart run forui init` — basic or `--template=router` app scaffold.
- `dart run forui style ls` / `dart run forui style create <name>` — generated widget styles.
- `dart run forui theme ls` / `dart run forui theme create <name>` — generated themes.
- `dart run forui snippet create material-mapping` — tune Material theme mapping.

## Theming

- Access via `context.theme` (`FThemeData`: colors, typography, style, breakpoints).
- Customize with **deltas** (`style: .delta(...)`) for small tweaks; use CLI-generated styles for large changes.
- Optional: `ThemeExtension` on `FThemeData.extensions` for app-specific tokens (see Forui “Adding Theme Properties”).

## Version

Forui **0.18.0+** requires Flutter **3.41.0+**. Run `flutter --version` before upgrading.

## Validation checklist

- [ ] Looked up or listed styles/widgets before adding a bespoke component.
- [ ] `FTheme` wraps the subtree that shows Forui widgets; toaster/tooltip ancestors present if using those APIs.
- [ ] Localization delegates/locales set if using translated Forui strings.
