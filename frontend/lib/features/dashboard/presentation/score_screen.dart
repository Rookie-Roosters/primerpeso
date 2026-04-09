import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../../core/theme/green_tokens.dart';

/// Criterio score screen — arc gauge + factor breakdown cards.
class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  static const double _mockScore = 0.68;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: warmSurface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 22, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tu score',
                    style: TextStyle(
                      color: ink,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Criterio de salud financiera',
                    style: TextStyle(
                      color: inkMuted,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Arc gauge ────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 190,
              child: CustomPaint(
                painter: _ScoreGaugePainter(score: _mockScore),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      '68',
                      style: TextStyle(
                        color: ink,
                        fontSize: 60,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -3,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'de 100',
                      style: TextStyle(
                        color: inkMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ── Factor cards ─────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Factores',
                style: TextStyle(
                  color: ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  children: const [
                    _FactorCard(
                      label: 'Decisiones registradas',
                      value: 'Sin datos aún',
                    ),
                    SizedBox(height: 8),
                    _FactorCard(
                      label: 'Gastos vs ingresos',
                      value: 'Sin datos aún',
                    ),
                    SizedBox(height: 8),
                    _FactorCard(
                      label: 'Historial de crédito',
                      value: 'Sin datos aún',
                    ),
                    SizedBox(height: 8),
                    _FactorCard(
                      label: 'Uso de simuladores',
                      value: 'Sin datos aún',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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

class _FactorCard extends StatelessWidget {
  const _FactorCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: lightGreenTint,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const SizedBox(width: 32, height: 32),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      color: inkMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  '—',
                  style: TextStyle(
                    color: inkMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
