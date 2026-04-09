import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/green_tokens.dart';

class PaycheckScreen extends StatelessWidget {
  const PaycheckScreen({super.key});

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
                'Simulador · Sueldo',
                style: TextStyle(
                  color: ink,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Calcularemos tu sueldo neto y cuánto te queda libre cada quincena.',
                style: TextStyle(color: inkMuted, fontSize: 15, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
