//
//  Generated code. Do not modify.
//  source: primerpeso/identity/v1/identity.proto
//

import "package:connectrpc/connect.dart" as connect;
import "identity.pb.dart" as primerpesoidentityv1identity;

abstract final class IdentityService {
  /// Fully-qualified name of the IdentityService service.
  static const name = 'primerpeso.identity.v1.IdentityService';

  static const register = connect.Spec(
    '/$name/Register',
    connect.StreamType.unary,
    primerpesoidentityv1identity.RegisterRequest.new,
    primerpesoidentityv1identity.AuthSessionResponse.new,
  );

  static const login = connect.Spec(
    '/$name/Login',
    connect.StreamType.unary,
    primerpesoidentityv1identity.LoginRequest.new,
    primerpesoidentityv1identity.AuthSessionResponse.new,
  );

  static const refresh = connect.Spec(
    '/$name/Refresh',
    connect.StreamType.unary,
    primerpesoidentityv1identity.RefreshRequest.new,
    primerpesoidentityv1identity.AuthSessionResponse.new,
  );

  static const logout = connect.Spec(
    '/$name/Logout',
    connect.StreamType.unary,
    primerpesoidentityv1identity.LogoutRequest.new,
    primerpesoidentityv1identity.LogoutResponse.new,
  );

  static const getMe = connect.Spec(
    '/$name/GetMe',
    connect.StreamType.unary,
    primerpesoidentityv1identity.GetMeRequest.new,
    primerpesoidentityv1identity.GetMeResponse.new,
  );

  static const beginGoogleAuth = connect.Spec(
    '/$name/BeginGoogleAuth',
    connect.StreamType.unary,
    primerpesoidentityv1identity.BeginGoogleAuthRequest.new,
    primerpesoidentityv1identity.BeginGoogleAuthResponse.new,
  );

  static const exchangeGoogleAuthCode = connect.Spec(
    '/$name/ExchangeGoogleAuthCode',
    connect.StreamType.unary,
    primerpesoidentityv1identity.ExchangeGoogleAuthCodeRequest.new,
    primerpesoidentityv1identity.AuthSessionResponse.new,
  );

  static const verifyEmail = connect.Spec(
    '/$name/VerifyEmail',
    connect.StreamType.unary,
    primerpesoidentityv1identity.VerifyEmailRequest.new,
    primerpesoidentityv1identity.GetMeResponse.new,
  );

  static const resendVerificationEmail = connect.Spec(
    '/$name/ResendVerificationEmail',
    connect.StreamType.unary,
    primerpesoidentityv1identity.ResendVerificationEmailRequest.new,
    primerpesoidentityv1identity.ResendVerificationEmailResponse.new,
  );

  static const requestPasswordReset = connect.Spec(
    '/$name/RequestPasswordReset',
    connect.StreamType.unary,
    primerpesoidentityv1identity.RequestPasswordResetRequest.new,
    primerpesoidentityv1identity.RequestPasswordResetResponse.new,
  );

  static const resetPassword = connect.Spec(
    '/$name/ResetPassword',
    connect.StreamType.unary,
    primerpesoidentityv1identity.ResetPasswordRequest.new,
    primerpesoidentityv1identity.ResetPasswordResponse.new,
  );
}
