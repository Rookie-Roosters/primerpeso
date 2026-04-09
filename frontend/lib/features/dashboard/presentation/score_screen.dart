import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../core/app_scope.dart';
import '../../../core/theme/green_tokens.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/bar_chart.dart';
import '../../../core/ui/hero_card.dart';
import '../../../core/ui/pill_stat.dart';
import '../../../core/ui/screen_header.dart';
import '../../../gen/primerpeso/finance/v1/finance.pb.dart' as financev1;

/// Criterio score screen — arc gauge + factor breakdown cards.
class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ScreenHeader(
            title: 'Tu score',
            subtitle: 'Criterio de salud financiera',
          ),
          SizedBox(height: 20),
          Expanded(child: _ScoreSummaryBody()),
        ],
      ),
    );
  }
}

class _ScoreSummaryBody extends StatefulWidget {
  const _ScoreSummaryBody();

  @override
  State<_ScoreSummaryBody> createState() => _ScoreSummaryBodyState();
}

class _ScoreSummaryBodyState extends State<_ScoreSummaryBody> {
  Future<financev1.GetScoreSummaryResponse>? _summaryFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _summaryFuture ??= AppScope.of(context).financeRepository.getScoreSummary();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<financev1.GetScoreSummaryResponse>(
      future: _summaryFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: FAlert(
              variant: FAlertVariant.destructive,
              title: const Text('No pude cargar tu score'),
              subtitle: Text(snapshot.error.toString()),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(color: primaryGreen),
          );
        }

        final summary = snapshot.data!.summary;
        final normalizedScore = (((summary.score - 300) / 6).clamp(
          0,
          100,
        )).round();
        final scoreRatio = normalizedScore / 100;
        final history = _historyFromFactors(summary.factors, normalizedScore);

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeroCard(
                child: Column(
                  children: [
                    Text(
                      'Salud financiera',
                      style: PTypography.label.copyWith(color: inkMuted),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 220,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _ScoreGaugePainter(score: scoreRatio),
                            ),
                          ),
                          // Number + label live INSIDE the arc curve. The
                          // painter draws the arc with its baseline near 88%
                          // of the height; sitting the text at bottom: 30
                          // tucks it just above that baseline so it never
                          // overlaps the stroke.
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 30,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '$normalizedScore',
                                  textAlign: TextAlign.center,
                                  style: PTypography.display.copyWith(
                                    fontSize: 56,
                                    letterSpacing: -2,
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${summary.score} pts',
                                  textAlign: TextAlign.center,
                                  style: PTypography.label.copyWith(
                                    color: inkMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        if (normalizedScore >= 70)
                          const PillStat.success('Salud sólida')
                        else if (normalizedScore >= 40)
                          const PillStat.neutral('En equilibrio')
                        else
                          const PillStat.danger('Atención'),
                        PillStat.neutral('${summary.factors.length} factores'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              HeroCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Histórico mensual', style: PTypography.subtitle),
                    const SizedBox(height: 4),
                    Text(
                      'Vista preliminar — el backend aún no expone histórico.',
                      style: PTypography.label.copyWith(color: inkMuted),
                    ),
                    const SizedBox(height: 18),
                    MonthBarChart(bars: history),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text('Factores', style: PTypography.subtitle),
              const SizedBox(height: 12),
              if (summary.factors.isEmpty)
                const _FactorCard(
                  label: 'Sin factores todavía',
                  value:
                      'Confirma tus primeros gastos para ver el detalle del score.',
                )
              else
                ...summary.factors.map(
                  (factor) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _FactorCard(
                      factorKey: factor.key,
                      label: factor.title,
                      value: factor.explanation,
                      delta: factor.delta,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Builds a stub history chart from the factor deltas so the layout has
/// something to render until the backend exposes a real score history series.
List<MonthBar> _historyFromFactors(
  Iterable<financev1.ScoreFactor> factors,
  int currentScore,
) {
  const monthLabels = ['Nov', 'Dic', 'Ene', 'Feb', 'Mar', 'Abr'];
  if (factors.isEmpty) {
    return [
      for (var i = 0; i < monthLabels.length; i++)
        MonthBar(label: monthLabels[i], percent: currentScore),
    ];
  }
  // Walk back from the current score by accumulating reversed deltas — gives
  // a plausible 6-bar trend without inventing extra signal.
  final deltas = factors.map((f) => f.delta).toList();
  var running = currentScore;
  final values = <int>[currentScore];
  for (var i = 0; i < monthLabels.length - 1; i++) {
    final delta = deltas[i % deltas.length];
    running = (running - delta).clamp(0, 100);
    values.insert(0, running);
  }
  return [
    for (var i = 0; i < monthLabels.length; i++)
      MonthBar(label: monthLabels[i], percent: values[i]),
  ];
}

/// Semicircular arc gauge — sweeps from left (π) to right (0) clockwise,
/// using a gradient fill up to [score] × 180°.
class _ScoreGaugePainter extends CustomPainter {
  const _ScoreGaugePainter({required this.score});

  final double score;

  static const double _strokeWidth = 16.0;
  static const double _startAngle = math.pi;
  static const double _sweepTotal = math.pi;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.88);
    final radius = size.width * 0.36;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background track
    canvas.drawArc(
      rect,
      _startAngle,
      _sweepTotal,
      false,
      Paint()
        ..color = borderSubtle
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..strokeCap = StrokeCap.round,
    );

    if (score <= 0) return;

    // Filled arc with gradient
    final gradient = SweepGradient(
      startAngle: _startAngle,
      endAngle: _startAngle + _sweepTotal,
      colors: const [midGreen, primaryGreen],
    );

    canvas.drawArc(
      rect,
      _startAngle,
      _sweepTotal * score,
      false,
      Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..strokeCap = StrokeCap.round,
    );

    // Indicator dot at the arc tip
    final endAngle = _startAngle + _sweepTotal * score;
    final dotCenter = Offset(
      center.dx + radius * math.cos(endAngle),
      center.dy + radius * math.sin(endAngle),
    );

    canvas.drawCircle(
      dotCenter,
      _strokeWidth / 2 + 3,
      Paint()..color = primaryGreen,
    );
    canvas.drawCircle(
      dotCenter,
      _strokeWidth / 2 - 2,
      Paint()..color = surface,
    );
  }

  @override
  bool shouldRepaint(_ScoreGaugePainter old) => old.score != score;
}

IconData _factorIconData(String? key) {
  if (key == null || key.isEmpty) return FIcons.info;
  return switch (key) {
    'baseline' => FIcons.layers,
    'receipt_activity' => FIcons.receipt,
    'category_coverage' => FIcons.layoutGrid,
    'spending_concentration' => FIcons.chartPie,
    _ => FIcons.circleDot,
  };
}

class _FactorCard extends StatelessWidget {
  const _FactorCard({
    required this.label,
    required this.value,
    this.factorKey,
    this.delta,
  });

  final String? factorKey;
  final String label;
  final String value;
  final int? delta;

  @override
  Widget build(BuildContext context) {
    final badge = _badgeFor(delta);
    final iconData = _factorIconData(factorKey);
    return HeroCard.compact(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: lightGreenTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: Icon(iconData, size: 22, color: primaryGreen),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: PTypography.bodyStrong),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: PTypography.body.copyWith(
                    color: inkMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ?badge,
        ],
      ),
    );
  }

  PillStat? _badgeFor(int? delta) {
    if (delta == null) return null;
    if (delta > 0) return PillStat.success('+$delta');
    if (delta < 0) return PillStat.danger('$delta');
    return const PillStat.neutral('—');
  }
}
