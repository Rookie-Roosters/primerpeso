import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../../core/theme/green_tokens.dart';

/// Round 44×44 back button used as the `leading` slot of every simulator
/// screen header. Kept in its own file because the three simulator screens
/// share it verbatim and it would otherwise be duplicated.
class SimulatorBackButton extends StatelessWidget {
  const SimulatorBackButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: surface,
          shape: BoxShape.circle,
          border: Border.all(color: borderSubtle, width: 1.2),
        ),
        child: const SizedBox(
          width: 44,
          height: 44,
          child: Center(child: Icon(FIcons.arrowLeft, size: 18, color: ink)),
        ),
      ),
    );
  }
}
