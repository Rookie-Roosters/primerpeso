import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_scope.dart';
import '../../../core/theme/green_tokens.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/gradient_background.dart';
import '../../../core/ui/hero_card.dart';
import '../../../core/ui/pill_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WarmGradientBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Center(
                child: HeroCard(
                  padding: const EdgeInsets.all(36),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: lightGreenTint,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(28),
                      child: Icon(FIcons.bot, size: 56, color: primaryGreen),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text('PrimerPeso', style: PTypography.label),
              const SizedBox(height: 12),
              Text(
                'Haz crecer tu dinero\ncon IA inteligente.',
                style: PTypography.display.copyWith(fontSize: 38),
              ),
              const SizedBox(height: 14),
              Text(
                'Habla con Peso, sube tickets y registra gastos en segundos desde tu dispositivo.',
                style: PTypography.body.copyWith(color: inkMuted),
              ),
              const SizedBox(height: 28),
              PillButton.primary(
                label: 'Comenzar',
                trailing: FIcons.arrowRight,
                onPressed: () async {
                  await AppScope.sessionOf(context).completeOnboarding();
                  if (!context.mounted) return;
                  context.go('/chat');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
