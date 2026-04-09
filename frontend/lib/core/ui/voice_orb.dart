import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../theme/green_tokens.dart';

/// Animated orb shown on the chat empty state.
///
/// A radial gradient sphere (primary green core fading into the warm
/// background) layered with a faint dotted ring overlay and a subtle
/// breathing pulse. Pure visual — no audio, no haptics.
class VoiceOrb extends StatefulWidget {
  const VoiceOrb({this.size = 220, this.listening = false, super.key});

  final double size;
  final bool listening;

  @override
  State<VoiceOrb> createState() => _VoiceOrbState();
}

class _VoiceOrbState extends State<VoiceOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.listening ? 1500 : 4000),
    )..repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant VoiceOrb oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listening != widget.listening) {
      _controller.duration = Duration(
        milliseconds: widget.listening ? 1500 : 4000,
      );
      _controller
        ..stop()
        ..repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        final scale = 0.94 + 0.06 * t;
        return Transform.scale(
          scale: scale,
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(painter: _OrbPainter(progress: t)),
          ),
        );
      },
    );
  }
}

class _OrbPainter extends CustomPainter {
  const _OrbPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // Outer atmosphere — very soft halo.
    final halo = Paint()
      ..shader = RadialGradient(
        colors: [
          lightGreenTint.withValues(alpha: 0.6),
          gradientEnd.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius));
    canvas.drawCircle(center, maxRadius, halo);

    // Core sphere — primary green at the center fading out.
    final coreRadius = maxRadius * 0.72;
    final core = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.15, -0.25),
        colors: [
          primaryGreen,
          primaryGreen.withValues(alpha: 0.85),
          midGreen.withValues(alpha: 0.35),
          lightGreenTint.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.35, 0.75, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: coreRadius));
    canvas.drawCircle(center, coreRadius, core);

    // Highlight — small soft glow on the upper-left of the core.
    final highlight = Paint()
      ..shader =
          RadialGradient(
            colors: [
              surface.withValues(alpha: 0.35),
              surface.withValues(alpha: 0.0),
            ],
          ).createShader(
            Rect.fromCircle(
              center: center.translate(-coreRadius * 0.25, -coreRadius * 0.3),
              radius: coreRadius * 0.55,
            ),
          );
    canvas.drawCircle(
      center.translate(-coreRadius * 0.25, -coreRadius * 0.3),
      coreRadius * 0.55,
      highlight,
    );

    // Dotted speckle ring — gives the "particle field" texture from the ref.
    final dotPaint = Paint()..color = surface.withValues(alpha: 0.55);
    final ringRadius = coreRadius * 0.92;
    const dotCount = 64;
    for (var i = 0; i < dotCount; i++) {
      final theta = (i / dotCount) * math.pi * 2 + progress * math.pi * 0.4;
      final jitter = ((i * 37) % 11) / 11.0;
      final r = ringRadius * (0.78 + 0.22 * jitter);
      final dotCenter = Offset(
        center.dx + r * math.cos(theta),
        center.dy + r * math.sin(theta),
      );
      canvas.drawCircle(dotCenter, 1.2 + jitter * 0.8, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_OrbPainter old) => old.progress != progress;
}
