import 'package:flutter/widgets.dart';

import '../theme/green_tokens.dart';
import '../theme/typography.dart';

/// Single column in the [MonthBarChart].
class MonthBar {
  const MonthBar({required this.label, required this.percent});

  /// Bottom label (e.g. "Apr").
  final String label;

  /// 0–100 fill height.
  final int percent;
}

/// Vertical bar chart matching the reference's monthly visual.
///
/// Each bar is a tall warm-surface "track" with a primary-green filled
/// segment at the bottom and a percentage label floating above. Pure
/// CustomPaint — no chart dependencies.
class MonthBarChart extends StatelessWidget {
  const MonthBarChart({
    required this.bars,
    this.height = 180,
    this.accent = primaryGreen,
    this.trackColor = warmSurface,
    super.key,
  });

  final List<MonthBar> bars;
  final double height;
  final Color accent;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    if (bars.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'Sin datos',
            style: PTypography.label.copyWith(color: inkMuted),
          ),
        ),
      );
    }
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final bar in bars)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _Column(bar: bar, accent: accent, track: trackColor),
              ),
            ),
        ],
      ),
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({required this.bar, required this.accent, required this.track});

  final MonthBar bar;
  final Color accent;
  final Color track;

  @override
  Widget build(BuildContext context) {
    final ratio = (bar.percent.clamp(0, 100)) / 100.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${bar.percent}%',
          style: PTypography.label.copyWith(
            color: ink,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: DecoratedBox(
              decoration: BoxDecoration(color: track),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: ratio == 0 ? 0.02 : ratio,
                  widthFactor: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(bar.label, style: PTypography.label.copyWith(color: inkMuted)),
      ],
    );
  }
}
