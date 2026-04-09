import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_scope.dart';
import '../../../core/theme/green_tokens.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: warmSurface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: lightGreenTint,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(18),
                  child: Icon(FIcons.bot, size: 34, color: primaryGreen),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Bienvenido a PrimerPeso',
                style: TextStyle(
                  color: ink,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Habla con Peso, sube tickets o documentos y registra gastos al instante desde tu dispositivo.',
                style: TextStyle(color: inkMuted, fontSize: 15, height: 1.45),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FButton(
                  onPress: () async {
                    await AppScope.sessionOf(context).completeOnboarding();
                    if (!context.mounted) return;
                    context.go('/chat');
                  },
                  child: const Text('Comenzar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
