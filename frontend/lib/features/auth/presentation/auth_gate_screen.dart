import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shard/shard.dart';

import '../../../core/theme/green_tokens.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/gradient_background.dart';
import '../../../core/ui/hero_card.dart';
import '../../../core/ui/pill_button.dart';
import '../../../core/ui/screen_header.dart';
import '../domain/auth_state.dart';
import '../shards/auth_shard.dart';

enum _AuthMode { login, register, forgotPassword }

class AuthGateScreen extends StatefulWidget {
  const AuthGateScreen({super.key});

  @override
  State<AuthGateScreen> createState() => _AuthGateScreenState();
}

class _AuthGateScreenState extends State<AuthGateScreen> {
  _AuthMode _mode = _AuthMode.login;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _resetPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _resetPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShardBuilder<AuthShard, AuthState>(
      builder: (context, state) {
        final shard = ShardProvider.of<AuthShard>(context, listen: false);
        return WarmGradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ScreenHeader(
                    title: 'Entra para hablar\ncon Peso.',
                    subtitle:
                        'Activa chat, tickets y score en tiempo real con tu cuenta.',
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (state.errorMessage != null) ...[
                          FAlert(
                            variant: FAlertVariant.destructive,
                            title: const Text('No pude completar la acción'),
                            subtitle: Text(state.errorMessage!),
                          ),
                          const SizedBox(height: 12),
                        ],
                        if (state.infoMessage != null) ...[
                          FAlert(
                            title: const Text('Listo'),
                            subtitle: Text(state.infoMessage!),
                          ),
                          const SizedBox(height: 12),
                        ],
                        if (state.pendingResetToken != null)
                          _ResetPasswordCard(
                            controller: _resetPasswordController,
                            isBusy: state.isBusy,
                            onSubmit: () => shard.submitPasswordReset(
                              _resetPasswordController.text,
                            ),
                            onCancel: shard.clearPendingReset,
                          )
                        else
                          _AuthCard(
                            mode: _mode,
                            isBusy: state.isBusy,
                            nameController: _nameController,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            onModeChanged: (mode) =>
                                setState(() => _mode = mode),
                            onSubmit: () {
                              switch (_mode) {
                                case _AuthMode.login:
                                  shard.signIn(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                  );
                                case _AuthMode.register:
                                  shard.register(
                                    displayName: _nameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                  );
                                case _AuthMode.forgotPassword:
                                  shard.requestPasswordReset(
                                    _emailController.text.trim(),
                                  );
                              }
                            },
                            onGoogle: shard.startGoogleAuth,
                            onResendVerification: () =>
                                shard.resendVerificationEmail(
                                  _emailController.text.trim(),
                                ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AuthCard extends StatelessWidget {
  const _AuthCard({
    required this.mode,
    required this.isBusy,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.onModeChanged,
    required this.onSubmit,
    required this.onGoogle,
    required this.onResendVerification,
  });

  final _AuthMode mode;
  final bool isBusy;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ValueChanged<_AuthMode> onModeChanged;
  final VoidCallback onSubmit;
  final VoidCallback onGoogle;
  final VoidCallback onResendVerification;

  @override
  Widget build(BuildContext context) {
    final submitLabel = switch (mode) {
      _AuthMode.login => 'Entrar',
      _AuthMode.register => 'Crear cuenta',
      _AuthMode.forgotPassword => 'Mandar enlace',
    };

    return HeroCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ModeChip(
                label: 'Entrar',
                selected: mode == _AuthMode.login,
                onTap: () => onModeChanged(_AuthMode.login),
              ),
              _ModeChip(
                label: 'Registro',
                selected: mode == _AuthMode.register,
                onTap: () => onModeChanged(_AuthMode.register),
              ),
              _ModeChip(
                label: 'Olvidé mi password',
                selected: mode == _AuthMode.forgotPassword,
                onTap: () => onModeChanged(_AuthMode.forgotPassword),
              ),
            ],
          ),
          const SizedBox(height: 22),
          if (mode == _AuthMode.register) ...[
            _Field(label: 'Nombre', controller: nameController),
            const SizedBox(height: 12),
          ],
          _Field(
            label: 'Correo',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          if (mode != _AuthMode.forgotPassword) ...[
            const SizedBox(height: 12),
            _Field(
              label: 'Contraseña',
              controller: passwordController,
              obscureText: true,
            ),
          ],
          const SizedBox(height: 20),
          PillButton.primary(
            label: submitLabel,
            onPressed: isBusy ? null : onSubmit,
            busy: isBusy,
          ),
          if (mode != _AuthMode.forgotPassword) ...[
            const SizedBox(height: 12),
            PillButton.surface(
              label: 'Continuar con Google',
              onPressed: isBusy ? null : onGoogle,
              expand: true,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: isBusy ? null : onResendVerification,
                child: Text(
                  'Reenviar correo de verificación',
                  style: PTypography.label.copyWith(
                    color: primaryGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ResetPasswordCard extends StatelessWidget {
  const _ResetPasswordCard({
    required this.controller,
    required this.isBusy,
    required this.onSubmit,
    required this.onCancel,
  });

  final TextEditingController controller;
  final bool isBusy;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return HeroCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Elige tu nueva contraseña', style: PTypography.title),
          const SizedBox(height: 14),
          _Field(
            label: 'Nueva contraseña',
            controller: controller,
            obscureText: true,
          ),
          const SizedBox(height: 18),
          PillButton.primary(
            label: 'Guardar contraseña',
            onPressed: isBusy ? null : onSubmit,
            busy: isBusy,
          ),
          const SizedBox(height: 10),
          PillButton.surface(
            label: 'Cancelar',
            onPressed: isBusy ? null : onCancel,
            expand: true,
          ),
        ],
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: selected ? lightGreenTint : warmSurface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? primaryGreen : borderSubtle),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            label,
            style: PTypography.label.copyWith(
              color: selected ? primaryGreen : inkMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: PTypography.body,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: PTypography.label.copyWith(color: inkMuted),
        filled: true,
        fillColor: warmSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: primaryGreen, width: 1.4),
        ),
      ),
    );
  }
}
