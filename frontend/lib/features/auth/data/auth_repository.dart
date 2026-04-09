import 'package:connectrpc/connect.dart' as connect;

import '../../../gen/primerpeso/identity/v1/identity.connect.client.dart';
import '../../../gen/primerpeso/identity/v1/identity.pb.dart' as identityv1;

class AuthRepository {
  AuthRepository({required this.client});

  final IdentityServiceClient client;

  Future<identityv1.AuthSessionResponse> login({
    required String email,
    required String password,
  }) {
    return client.login(
      identityv1.LoginRequest(email: email, password: password),
    );
  }

  Future<identityv1.AuthSessionResponse> register({
    required String displayName,
    required String email,
    required String password,
  }) {
    return client.register(
      identityv1.RegisterRequest(
        displayName: displayName,
        email: email,
        password: password,
      ),
    );
  }

  Future<identityv1.AuthSessionResponse> refresh(String refreshToken) {
    return client.refresh(
      identityv1.RefreshRequest(refreshToken: refreshToken),
    );
  }

  Future<identityv1.GetMeResponse> getMe(String accessToken) {
    return client.getMe(
      identityv1.GetMeRequest(),
      headers: authHeaders(accessToken),
    );
  }

  Future<void> logout(String refreshToken) async {
    await client.logout(identityv1.LogoutRequest(refreshToken: refreshToken));
  }

  Future<identityv1.BeginGoogleAuthResponse> beginGoogleAuth() {
    return client.beginGoogleAuth(
      identityv1.BeginGoogleAuthRequest(platform: 'android'),
    );
  }

  Future<identityv1.AuthSessionResponse> exchangeGoogleAuthCode(
    String exchangeCode,
  ) {
    return client.exchangeGoogleAuthCode(
      identityv1.ExchangeGoogleAuthCodeRequest(exchangeCode: exchangeCode),
    );
  }

  Future<void> resendVerificationEmail(String email) async {
    await client.resendVerificationEmail(
      identityv1.ResendVerificationEmailRequest(email: email),
    );
  }

  Future<void> requestPasswordReset(String email) async {
    await client.requestPasswordReset(
      identityv1.RequestPasswordResetRequest(email: email),
    );
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await client.resetPassword(
      identityv1.ResetPasswordRequest(
        resetToken: token,
        newPassword: newPassword,
      ),
    );
  }

  Future<identityv1.GetMeResponse> verifyEmail(String token) {
    return client.verifyEmail(
      identityv1.VerifyEmailRequest(verificationToken: token),
    );
  }
}

connect.Headers authHeaders(String? accessToken) {
  final headers = connect.Headers();
  if (accessToken != null && accessToken.isNotEmpty) {
    headers['Authorization'] = 'Bearer $accessToken';
  }
  return headers;
}
