// Forui widget styling lives here as `FThemeData` deltas built on top of
// `FThemes.green.light`. Mix tokens (`green_tokens.dart`) are used ONLY by
// non-Forui surfaces: chat bubbles, the score gauge, the mobile-frame bezel,
// and flat chat canvas fills. Do not duplicate a color rule in both places.

import 'package:forui/forui.dart';

import 'green_tokens.dart';

/// Builds the project's `FThemeData`.
///
/// Starts from Forui's built-in `green.light` palette and overrides the
/// primary tone toward our deeper forest brand green so headers, primary
/// buttons and accents feel cohesive with the reference UI.
FThemeData buildAppTheme() {
  final base = FThemes.green.light;
  return base.copyWith(
    colors: base.colors.copyWith(
      primary: primaryGreen,
      primaryForeground: surface,
    ),
  );
}
