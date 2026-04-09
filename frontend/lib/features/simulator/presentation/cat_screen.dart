import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/green_tokens.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/gradient_background.dart';
import '../../../core/ui/hero_card.dart';
import '../../../core/ui/screen_header.dart';
import 'simulator_back_button.dart';

class CatScreen extends StatelessWidget {
  const CatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WarmGradientBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(
              title: 'Simulador · CAT',
              subtitle:
                  'Compararemos el Costo Anual Total de varias opciones para ver cuál te conviene.',
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
                        'Carga las ofertas de crédito que tienes encima y el simulador alineará el CAT real para que veas dónde está el ahorro.',
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
