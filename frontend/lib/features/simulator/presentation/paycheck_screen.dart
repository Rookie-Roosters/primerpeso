import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/green_tokens.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/gradient_background.dart';
import '../../../core/ui/hero_card.dart';
import '../../../core/ui/screen_header.dart';
import 'simulator_back_button.dart';

class PaycheckScreen extends StatelessWidget {
  const PaycheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WarmGradientBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(
              title: 'Simulador · Sueldo',
              subtitle:
                  'Calcularemos tu sueldo neto y cuánto te queda libre cada quincena.',
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
                        'Pronto podrás meter tu sueldo bruto, deducciones y el simulador te dirá cuánto entra a tu cuenta y cuánto puedes asignar a tus metas.',
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
