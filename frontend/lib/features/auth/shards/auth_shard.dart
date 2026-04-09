import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/services.dart';
import 'package:shard/shard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../gen/primerpeso/identity/v1/identity.pb.dart' as identityv1;
import '../data/auth_repository.dart';
import '../data/secure_token_storage.dart';
import '../domain/auth_state.dart';

class AuthShard extends Shard<AuthState> {
  AuthShard({
    required this.repository,
    required this.storage,
    AppLinks? appLinks,
  }) : _appLinks = appLinks ?? AppLinks(),
       super(const AuthState.initial()) {
    _attachLinkListener();
  }

  final AuthRepository repository;
  final SecureTokenStorage storage;
  final AppLinks _appLinks;

  StreamSubscription<Uri>? _linkSubscription;

  @override
  bool stateEquals(AuthState a, AuthState b) => identical(a, b);

  Future<void> bootstrap() async {
    emit(state.copyWith(status: AuthStatus.bootstrapping, clearError: true));

    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        await _handleUri(initialLink);
      }
    } on MissingPluginException {
      // Widget tests can ignore deep-link bootstrap.
    }

    final storedTokens = await storage.read();
    if (storedTokens == null) {
      emit(
        state.copyWith(status: AuthStatus.unauthenticated, clearError: true),
      );
      return;
    }

    try {
      final session = await repository.refresh(storedTokens.refreshToken);
      await _applySession(session);
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      await storage.clear();
      emit(
        state.copyWith(status: AuthStatus.unauthenticated, clearError: true),
      );
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(
      state.copyWith(
        status: AuthStatus.submitting,
        clearError: true,
        clearInfo: true,
      ),
    );

    try {
      final session = await repository.login(email: email, password: password);
      await _applySession(session);
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> register({
    required String displayName,
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        status: AuthStatus.submitting,
        clearError: true,
        clearInfo: true,
      ),
    );

    try {
      final session = await repository.register(
        displayName: displayName,
        email: email,
        password: password,
      );
      await _applySession(
        session,
        infoMessage:
            'Cuenta creada. Revisa tu correo si necesitas verificarlo.',
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> startGoogleAuth() async {
    emit(
      state.copyWith(
        status: AuthStatus.submitting,
        clearError: true,
        clearInfo: true,
      ),
    );

    try {
      final response = await repository.beginGoogleAuth();
      final launched = await launchUrl(
        Uri.parse(response.authorizationUrl),
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        throw Exception('No pude abrir el navegador para Google OAuth.');
      }
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> resendVerificationEmail(String email) async {
    emit(
      state.copyWith(
        status: AuthStatus.submitting,
        clearError: true,
        clearInfo: true,
      ),
    );

    try {
      await repository.resendVerificationEmail(email);
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          infoMessage: 'Te reenvié el correo de verificación.',
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> requestPasswordReset(String email) async {
    emit(
      state.copyWith(
        status: AuthStatus.submitting,
        clearError: true,
        clearInfo: true,
      ),
    );

    try {
      await repository.requestPasswordReset(email);
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          infoMessage:
              'Si el correo existe, te mandé un enlace para resetear la contraseña.',
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> submitPasswordReset(String newPassword) async {
    final token = state.pendingResetToken;
    if (token == null || token.isEmpty) return;

    emit(
      state.copyWith(
        status: AuthStatus.submitting,
        clearError: true,
        clearInfo: true,
      ),
    );

    try {
      await repository.resetPassword(token: token, newPassword: newPassword);
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          clearPendingReset: true,
          infoMessage: 'Contraseña actualizada. Ya puedes iniciar sesión.',
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> signOut() async {
    final refreshToken = state.refreshToken;
    if (refreshToken != null && refreshToken.isNotEmpty) {
      try {
        await repository.logout(refreshToken);
      } catch (_) {
        // Best-effort logout.
      }
    }

    await storage.clear();
    emit(
      const AuthState.initial().copyWith(status: AuthStatus.unauthenticated),
    );
  }

  Future<void> refreshProfile() async {
    final accessToken = state.accessToken;
    if (accessToken == null || accessToken.isEmpty) return;

    try {
      final response = await repository.getMe(accessToken);
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          profile: response.profile,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }

  void clearMessages() {
    emit(state.copyWith(clearError: true, clearInfo: true));
  }

  void clearPendingReset() {
    emit(state.copyWith(clearPendingReset: true, clearError: true));
  }

  void _attachLinkListener() {
    try {
      _linkSubscription = _appLinks.uriLinkStream.listen(
        (uri) => unawaited(_handleUri(uri)),
        onError: (error, stackTrace) => addError(error, stackTrace),
      );
    } on MissingPluginException {
      // Safe for widget tests.
    }
  }

  Future<void> _handleUri(Uri uri) async {
    if (uri.scheme != 'primerpeso' || uri.host != 'auth') return;

    final error = uri.queryParameters['error'];
    if (error != null && error.isNotEmpty) {
      emit(
        state.copyWith(status: AuthStatus.unauthenticated, errorMessage: error),
      );
      return;
    }

    final exchangeCode = uri.queryParameters['exchange_code'];
    if (exchangeCode != null && exchangeCode.isNotEmpty) {
      emit(
        state.copyWith(
          status: AuthStatus.submitting,
          clearError: true,
          clearInfo: true,
        ),
      );

      try {
        final session = await repository.exchangeGoogleAuthCode(exchangeCode);
        await _applySession(session);
      } catch (error, stackTrace) {
        addError(error, stackTrace);
        emit(
          state.copyWith(
            status: AuthStatus.unauthenticated,
            errorMessage: error.toString(),
          ),
        );
      }
      return;
    }

    final mode = uri.queryParameters['mode'];
    if (mode == 'verify-email') {
      final verificationToken = uri.queryParameters['token'];
      if (verificationToken != null && verificationToken.isNotEmpty) {
        try {
          final response = await repository.verifyEmail(verificationToken);
          emit(
            state.copyWith(
              status: AuthStatus.authenticated,
              profile: response.profile,
              infoMessage: 'Correo verificado correctamente.',
            ),
          );
        } catch (error, stackTrace) {
          addError(error, stackTrace);
          emit(
            state.copyWith(
              status: AuthStatus.unauthenticated,
              errorMessage: error.toString(),
            ),
          );
        }
      } else {
        emit(state.copyWith(infoMessage: 'Correo verificado correctamente.'));
      }
      return;
    }

    if (mode == 'reset-password') {
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          pendingResetToken: uri.queryParameters['token'],
          infoMessage: 'Elige tu nueva contraseña.',
        ),
      );
    }
  }

  Future<void> _applySession(
    identityv1.AuthSessionResponse session, {
    String? infoMessage,
  }) async {
    await storage.write(
      accessToken: session.tokens.accessToken,
      refreshToken: session.tokens.refreshToken,
    );

    emit(
      state.copyWith(
        status: AuthStatus.authenticated,
        profile: session.profile,
        accessToken: session.tokens.accessToken,
        refreshToken: session.tokens.refreshToken,
        clearError: true,
        infoMessage: infoMessage,
        clearPendingReset: true,
      ),
    );
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }
}
