import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/green_tokens.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/gradient_background.dart';
import '../../../core/ui/hero_card.dart';
import '../../../core/ui/screen_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WarmGradientBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(
              title: 'Ajustes',
              subtitle: 'Cuenta, notificaciones y conexión con WhatsApp',
              leading: _BackButton(onTap: () => context.pop()),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeroCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          _SettingsRow(
                            icon: FIcons.user,
                            title: 'Cuenta',
                            subtitle: 'Datos personales y método de acceso',
                          ),
                          _RowDivider(),
                          _SettingsRow(
                            icon: FIcons.bell,
                            title: 'Notificaciones',
                            subtitle: 'Elige cuándo te avisa Peso',
                          ),
                          _RowDivider(),
                          _SettingsRow(
                            icon: FIcons.messageCircle,
                            title: 'WhatsApp',
                            subtitle:
                                'Conecta tu número para chatear desde ahí',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    HeroCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          _SettingsRow(
                            icon: FIcons.shield,
                            title: 'Privacidad',
                            subtitle: 'Cómo cuidamos tus datos',
                          ),
                          _RowDivider(),
                          _SettingsRow(
                            icon: FIcons.info,
                            title: 'Ayuda',
                            subtitle: 'Contáctanos si algo no te late',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

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

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: lightGreenTint,
              borderRadius: BorderRadius.circular(14),
            ),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Center(child: Icon(icon, size: 20, color: primaryGreen)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PTypography.bodyStrong),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: PTypography.label.copyWith(color: inkMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(FIcons.chevronRight, size: 18, color: inkMuted),
        ],
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ColoredBox(
        color: borderSubtle,
        child: SizedBox(height: 1, width: double.infinity),
      ),
    );
  }
}
