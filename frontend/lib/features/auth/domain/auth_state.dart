import '../../../gen/primerpeso/identity/v1/identity.pb.dart' as identityv1;

enum AuthStatus { bootstrapping, unauthenticated, authenticated, submitting }

class AuthState {
  const AuthState({
    required this.status,
    required this.profile,
    required this.accessToken,
    required this.refreshToken,
    required this.errorMessage,
    required this.infoMessage,
    required this.pendingResetToken,
  });

  const AuthState.initial()
    : status = AuthStatus.bootstrapping,
      profile = null,
      accessToken = null,
      refreshToken = null,
      errorMessage = null,
      infoMessage = null,
      pendingResetToken = null;

  final AuthStatus status;
  final identityv1.UserProfile? profile;
  final String? accessToken;
  final String? refreshToken;
  final String? errorMessage;
  final String? infoMessage;
  final String? pendingResetToken;

  bool get isAuthenticated =>
      status == AuthStatus.authenticated &&
      accessToken != null &&
      refreshToken != null;

  bool get isBusy =>
      status == AuthStatus.bootstrapping || status == AuthStatus.submitting;

  AuthState copyWith({
    AuthStatus? status,
    identityv1.UserProfile? profile,
    String? accessToken,
    String? refreshToken,
    String? errorMessage,
    bool clearError = false,
    String? infoMessage,
    bool clearInfo = false,
    String? pendingResetToken,
    bool clearPendingReset = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      infoMessage: clearInfo ? null : (infoMessage ?? this.infoMessage),
      pendingResetToken: clearPendingReset
          ? null
          : (pendingResetToken ?? this.pendingResetToken),
    );
  }
}
