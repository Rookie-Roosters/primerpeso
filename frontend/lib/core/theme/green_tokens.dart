import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// Brand palette for PrimerPeso.
///
/// **Mix-only surfaces.** These tokens drive non-Forui visuals: chat bubbles,
/// the score gauge, the mobile-canvas frame bezel, and flat chat backgrounds.
/// Forui widgets read styling from `FThemeData` (see `app_theme.dart`); do not
/// duplicate a color rule in both places.

const Color primaryGreen = Color(0xFF0E5B3C);
const Color midGreen = Color(0xFF2FA366);
const Color lightGreenTint = Color(0xFFE7F5EC);
const Color gradientStart = Color(0xFFFFFFFF);
const Color gradientEnd = Color(0xFFDDEEE2);

/// Solid chat canvas (no full-screen gradient — avoids banding on some GPUs).
const Color chatCanvas = Color(0xFFE7F5EC);
const Color ink = Color(0xFF0B1B14);
const Color inkMuted = Color(0xFF597265);
const Color surface = Color(0xFFFFFFFF);
const Color dangerRed = Color(0xFFC4362A);

/// Subtle page background — slightly warmer than pure white for card contrast.
const Color warmSurface = Color(0xFFF5F8F6);

/// Dividers, input outlines, and card borders.
const Color borderSubtle = Color(0xFFE0EBE5);

/// Soft elevation used by every hero card and floating surface in the
/// revamped UI. Single source of truth so cards stay visually consistent.
const List<BoxShadow> cardShadowSoft = [
  BoxShadow(color: Color(0x0E000000), blurRadius: 24, offset: Offset(0, 8)),
];

/// Width in logical pixels above which the web build draws a fixed mobile
/// canvas instead of filling the window.
const double mobileFrameBreakpoint = 600;

/// Logical canvas size for the web mobile-frame mode.
const Size mobileFrameSize = Size(390, 844);

/// Color tokens consumed by `MixScope`.
const ColorToken tkPrimary = ColorToken('primary');
const ColorToken tkPrimaryMid = ColorToken('primaryMid');
const ColorToken tkPrimaryTint = ColorToken('primaryTint');
const ColorToken tkBgStart = ColorToken('bgStart');
const ColorToken tkBgEnd = ColorToken('bgEnd');
const ColorToken tkInk = ColorToken('ink');
const ColorToken tkInkMuted = ColorToken('inkMuted');
const ColorToken tkSurface = ColorToken('surface');
const ColorToken tkDanger = ColorToken('danger');

final Map<ColorToken, Color> appColorTokens = {
  tkPrimary: primaryGreen,
  tkPrimaryMid: midGreen,
  tkPrimaryTint: lightGreenTint,
  tkBgStart: gradientStart,
  tkBgEnd: gradientEnd,
  tkInk: ink,
  tkInkMuted: inkMuted,
  tkSurface: surface,
  tkDanger: dangerRed,
};

/// Spacing tokens consumed by `MixScope`.
const SpaceToken tkSpaceXs = SpaceToken('xs');
const SpaceToken tkSpaceSm = SpaceToken('sm');
const SpaceToken tkSpaceMd = SpaceToken('md');
const SpaceToken tkSpaceLg = SpaceToken('lg');
const SpaceToken tkSpaceXl = SpaceToken('xl');
const SpaceToken tkSpace2xl = SpaceToken('2xl');

final Map<SpaceToken, double> appSpaceTokens = {
  tkSpaceXs: 4,
  tkSpaceSm: 8,
  tkSpaceMd: 16,
  tkSpaceLg: 24,
  tkSpaceXl: 32,
  tkSpace2xl: 48,
};

/// Radius tokens consumed by `MixScope`.
const RadiusToken tkRadiusSm = RadiusToken('sm');
const RadiusToken tkRadiusMd = RadiusToken('md');
const RadiusToken tkRadiusLg = RadiusToken('lg');
const RadiusToken tkRadiusXl = RadiusToken('xl');
const RadiusToken tkRadius2xl = RadiusToken('2xl');

final Map<RadiusToken, Radius> appRadiusTokens = {
  tkRadiusSm: Radius.circular(8),
  tkRadiusMd: Radius.circular(16),
  tkRadiusLg: Radius.circular(24),
  tkRadiusXl: Radius.circular(32),
  tkRadius2xl: Radius.circular(36),
};
