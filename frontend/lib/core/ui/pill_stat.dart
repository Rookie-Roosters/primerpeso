import 'package:flutter/widgets.dart';

import '../theme/green_tokens.dart';
import '../theme/typography.dart';

enum _PillTone { success, danger, neutral }

/// Stadium-shaped status pill — used for inline indicators like
/// "Bien este mes", "67% gastado", deltas, etc.
///
/// Three semantic tones, all derived from the existing palette:
///   * success — `lightGreenTint` background, `primaryGreen` text
///   * danger  — runtime 12% tint of `dangerRed`, `dangerRed` text
///   * neutral — `warmSurface` background, `inkMuted` text
class PillStat extends StatelessWidget {
  const PillStat.success(this.label, {this.icon, super.key})
    : _tone = _PillTone.success;
  const PillStat.danger(this.label, {this.icon, super.key})
    : _tone = _PillTone.danger;
  const PillStat.neutral(this.label, {this.icon, super.key})
    : _tone = _PillTone.neutral;

  final String label;
  final IconData? icon;
  final _PillTone _tone;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (_tone) {
      _PillTone.success => (lightGreenTint, primaryGreen),
      _PillTone.danger => (dangerRed.withValues(alpha: 0.12), dangerRed),
      _PillTone.neutral => (warmSurface, inkMuted),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 13, color: foreground),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: PTypography.label.copyWith(
                color: foreground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
