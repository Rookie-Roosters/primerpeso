import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/green_tokens.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/gradient_background.dart';
import '../../../core/ui/hero_card.dart';
import '../../../core/ui/screen_header.dart';
import 'simulator_back_button.dart';

class CreditScreen extends StatelessWidget {
  const CreditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WarmGradientBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(
              title: 'Simulador · Crédito',
              subtitle:
                  'Te ayudaremos a entender el costo real de un crédito antes de firmar.',
              leading: SimulatorBackButton(onTap: () => context.pop()),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
                child: HeroCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Próximamente', style: PTypography.title),
                      const SizedBox(height: 8),
                      Text(
                        'Captura monto, plazo y tasa para ver pagos mensuales, intereses totales y banderas rojas antes de firmar.',
                        style: PTypography.body.copyWith(color: inkMuted),
                      ),
                    ],
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
