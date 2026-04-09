import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shard/shard.dart';

import '../../../core/theme/green_tokens.dart';
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
        return ColoredBox(
          color: warmSurface,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Entra para hablar con Peso',
                    style: TextStyle(
                      color: ink,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Activa chat, tickets y score en tiempo real con tu cuenta de PrimerPeso.',
                    style: TextStyle(
                      color: inkMuted,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
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
                      onModeChanged: (mode) => setState(() => _mode = mode),
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
                      onResendVerification: () => shard.resendVerificationEmail(
                        _emailController.text.trim(),
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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 18),
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
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FButton(
                onPress: isBusy ? null : onSubmit,
                child: Text(submitLabel),
              ),
            ),
            const SizedBox(height: 12),
            if (mode != _AuthMode.forgotPassword) ...[
              SizedBox(
                width: double.infinity,
                child: FButton(
                  variant: FButtonVariant.outline,
                  onPress: isBusy ? null : onGoogle,
                  child: const Text('Continuar con Google'),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: isBusy ? null : onResendVerification,
                  child: const Text(
                    'Reenviar correo de verificación',
                    style: TextStyle(
                      color: primaryGreen,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Elige tu nueva contraseña',
              style: TextStyle(
                color: ink,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            _Field(
              label: 'Nueva contraseña',
              controller: controller,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FButton(
                onPress: isBusy ? null : onSubmit,
                child: const Text('Guardar contraseña'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FButton(
                variant: FButtonVariant.outline,
                onPress: isBusy ? null : onCancel,
                child: const Text('Cancelar'),
              ),
            ),
          ],
        ),
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
            style: TextStyle(
              color: selected ? primaryGreen : inkMuted,
              fontSize: 13,
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
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: warmSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderSubtle),
        ),
      ),
    );
  }
}
