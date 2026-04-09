import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:google_fonts/google_fonts.dart';

import 'green_tokens.dart';

/// PrimerPeso typography scale.
///
/// Single source of truth for every text style in the app. Built on Inter
/// (loaded via `google_fonts`) so the heavy weights and tight tracking the
/// design relies on are guaranteed to be present at runtime.
///
/// Custom widgets read from the static getters below. Forui widgets pick up
/// Inter through [forui] (called from `buildAppTheme`). Material widgets pick
/// it up through [textTheme] (wired into `MaterialApp.router`'s `ThemeData`).
class PTypography {
  PTypography._();

  /// Hero numbers and screen-level display headlines (e.g. balance amount).
  static TextStyle get display => GoogleFonts.inter(
    fontSize: 44,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.4,
    height: 1.0,
    color: ink,
  );

  /// Top-of-screen headlines (e.g. "Tu dinero", "Hola, soy Peso").
  static TextStyle get headline => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.9,
    height: 1.05,
    color: ink,
  );

  /// Card titles, section heads.
  static TextStyle get title => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    height: 1.15,
    color: ink,
  );

  /// Sub-section heads (smaller than [title]).
  static TextStyle get subtitle => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.2,
    color: ink,
  );

  /// Default body text.
  static TextStyle get body => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: ink,
  );

  /// Emphasized body (semi-bold).
  static TextStyle get bodyStrong => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: ink,
  );

  /// Captions, pill labels, nav labels.
  static TextStyle get label => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 1.2,
    color: inkMuted,
  );

  /// Tabular money digits (uses Inter's tabular figures via fontFeatures).
  static TextStyle get mono => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFeatures: const [FontFeature.tabularFigures()],
    color: ink,
  );

  /// Returns a Forui [FTypography] whose every slot uses Inter via
  /// `google_fonts`. Pass this into [FThemeData.copyWith] to keep Forui
  /// widgets visually consistent with the rest of the app.
  static FTypography forui(FTypography base) {
    TextStyle inter(TextStyle slot) => GoogleFonts.inter(textStyle: slot);
    return base.copyWith(
      xs: inter(base.xs),
      sm: inter(base.sm),
      base: inter(base.base),
      lg: inter(base.lg),
      xl: inter(base.xl),
      xl2: inter(base.xl2),
      xl3: inter(base.xl3),
      xl4: inter(base.xl4),
      xl5: inter(base.xl5),
      xl6: inter(base.xl6),
      xl7: inter(base.xl7),
      xl8: inter(base.xl8),
    );
  }

  /// Returns a Material [TextTheme] derived from Inter so any stray Material
  /// widget (dialogs, snackbars, default `Text`) also picks up the brand font.
  static TextTheme textTheme() {
    return GoogleFonts.interTextTheme().apply(
      bodyColor: ink,
      displayColor: ink,
    );
  }
}
