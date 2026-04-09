import 'package:flutter/widgets.dart';

import '../theme/green_tokens.dart';

/// Warm vertical gradient that backs every screen in the revamped UI.
///
/// White at the top fading through `lightGreenTint` into `gradientEnd`,
/// concentrating the green glow toward the bottom (behind the floating nav).
/// Replaces the old flat `ColoredBox(color: warmSurface)` wrappers.
class WarmGradientBackground extends StatelessWidget {
  const WarmGradientBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.55, 1.0],
          colors: [gradientStart, lightGreenTint, gradientEnd],
        ),
      ),
      child: child,
    );
  }
}
