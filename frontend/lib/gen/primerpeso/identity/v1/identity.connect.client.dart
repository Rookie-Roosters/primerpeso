//
//  Generated code. Do not modify.
//  source: primerpeso/identity/v1/identity.proto
//

import "package:connectrpc/connect.dart" as connect;
import "identity.pb.dart" as primerpesoidentityv1identity;
import "identity.connect.spec.dart" as specs;

extension type IdentityServiceClient (connect.Transport _transport) {
  Future<primerpesoidentityv1identity.AuthSessionResponse> register(
    primerpesoidentityv1identity.RegisterRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.IdentityService.register,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesoidentityv1identity.AuthSessionResponse> login(
    primerpesoidentityv1identity.LoginRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.IdentityService.login,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesoidentityv1identity.AuthSessionResponse> refresh(
    primerpesoidentityv1identity.RefreshRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.IdentityService.refresh,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesoidentityv1identity.LogoutResponse> logout(
    primerpesoidentityv1identity.LogoutRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.IdentityService.logout,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesoidentityv1identity.GetMeResponse> getMe(
    primerpesoidentityv1identity.GetMeRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.IdentityService.getMe,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesoidentityv1identity.BeginGoogleAuthResponse> beginGoogleAuth(
    primerpesoidentityv1identity.BeginGoogleAuthRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.IdentityService.beginGoogleAuth,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesoidentityv1identity.AuthSessionResponse> exchangeGoogleAuthCode(
    primerpesoidentityv1identity.ExchangeGoogleAuthCodeRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.IdentityService.exchangeGoogleAuthCode,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesoidentityv1identity.GetMeResponse> verifyEmail(
    primerpesoidentityv1identity.VerifyEmailRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.IdentityService.verifyEmail,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesoidentityv1identity.ResendVerificationEmailResponse> resendVerificationEmail(
    primerpesoidentityv1identity.ResendVerificationEmailRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.IdentityService.resendVerificationEmail,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesoidentityv1identity.RequestPasswordResetResponse> requestPasswordReset(
    primerpesoidentityv1identity.RequestPasswordResetRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.IdentityService.requestPasswordReset,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesoidentityv1identity.ResetPasswordResponse> resetPassword(
    primerpesoidentityv1identity.ResetPasswordRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.IdentityService.resetPassword,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
