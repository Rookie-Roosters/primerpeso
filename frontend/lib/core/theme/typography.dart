import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'green_tokens.dart';

/// PrimerPeso typography scale.
///
/// Single source of truth for every text style in the app.
///
/// Custom widgets read from the static getters below. Forui widgets pick up
/// these rules through [forui]. Material widgets pick them up through
/// [textTheme] (wired into `MaterialApp.router`'s `ThemeData`).
class PTypography {
  PTypography._();

  /// Hero numbers and screen-level display headlines (e.g. balance amount).
  static TextStyle get display => const TextStyle(
    fontSize: 44,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.4,
    height: 1.0,
    color: ink,
  );

  /// Top-of-screen headlines (e.g. "Tu dinero", "Hola, soy Peso").
  static TextStyle get headline => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.9,
    height: 1.05,
    color: ink,
  );

  /// Card titles, section heads.
  static TextStyle get title => const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    height: 1.15,
    color: ink,
  );

  /// Sub-section heads (smaller than [title]).
  static TextStyle get subtitle => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.2,
    color: ink,
  );

  /// Default body text.
  static TextStyle get body => const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: ink,
  );

  /// Emphasized body (semi-bold).
  static TextStyle get bodyStrong => const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: ink,
  );

  /// Captions, pill labels, nav labels.
  static TextStyle get label => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 1.2,
    color: inkMuted,
  );

  /// Tabular money digits via font features.
  static TextStyle get mono => const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFeatures: [FontFeature.tabularFigures()],
    color: ink,
  );

  /// Returns a Forui [FTypography] with package font bindings removed so web
  /// startup does not wait on custom font payloads before painting.
  static FTypography forui(FTypography base) {
    TextStyle unbound(TextStyle slot) =>
        slot.copyWith(fontFamily: null, fontFamilyFallback: const <String>[]);
    return base.copyWith(
      xs: unbound(base.xs),
      sm: unbound(base.sm),
      base: unbound(base.base),
      lg: unbound(base.lg),
      xl: unbound(base.xl),
      xl2: unbound(base.xl2),
      xl3: unbound(base.xl3),
      xl4: unbound(base.xl4),
      xl5: unbound(base.xl5),
      xl6: unbound(base.xl6),
      xl7: unbound(base.xl7),
      xl8: unbound(base.xl8),
    );
  }

  /// Returns a Material [TextTheme] used by Material widgets.
  static TextTheme textTheme() {
    return ThemeData.light().textTheme.apply(bodyColor: ink, displayColor: ink);
  }
}
