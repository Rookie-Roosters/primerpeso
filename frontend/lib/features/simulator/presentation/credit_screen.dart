import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/green_tokens.dart';

class CreditScreen extends StatelessWidget {
  const CreditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FButton.icon(
                onPress: () => context.pop(),
                child: const Icon(FIcons.arrowLeft),
              ),
              const SizedBox(height: 24),
              const Text(
                'Simulador · Crédito',
                style: TextStyle(
                  color: ink,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Te ayudaremos a entender el costo real de un crédito antes de firmar.',
                style: TextStyle(color: inkMuted, fontSize: 15, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
