import 'package:flutter/widgets.dart';

import '../theme/green_tokens.dart';

/// Large rounded white surface used as the visual primitive for every
/// information block in the revamped UI: tracker balance card, score gauge
/// container, history rows, settings groups, welcome hero block.
///
/// Two visual variants:
///   * default — 36px radius, soft drop shadow, generous padding (designed
///     for the prominent hero blocks).
///   * compact — 24px radius, lighter shadow, smaller padding (designed for
///     row-style content like history items or factor cards).
class HeroCard extends StatelessWidget {
  const HeroCard({
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.compact = false,
    this.onTap,
    super.key,
  });

  /// Convenience for thin row cards (history list, factor cards).
  const HeroCard.compact({
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    this.onTap,
    super.key,
  }) : compact = true;

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool compact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(compact ? 24 : 36);
    final shadow = compact
        ? const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ]
        : cardShadowSoft;

    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: radius,
        boxShadow: shadow,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Padding(padding: padding, child: child),
      ),
    );

    if (onTap == null) return card;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: card,
    );
  }
}
