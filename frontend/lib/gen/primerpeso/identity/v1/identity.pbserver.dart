// This is a generated file - do not edit.
//
// Generated from primerpeso/identity/v1/identity.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'identity.pb.dart' as $1;
import 'identity.pbjson.dart';

export 'identity.pb.dart';

abstract class IdentityServiceBase extends $pb.GeneratedService {
  $async.Future<$1.AuthSessionResponse> register(
      $pb.ServerContext ctx, $1.RegisterRequest request);
  $async.Future<$1.AuthSessionResponse> login(
      $pb.ServerContext ctx, $1.LoginRequest request);
  $async.Future<$1.AuthSessionResponse> refresh(
      $pb.ServerContext ctx, $1.RefreshRequest request);
  $async.Future<$1.LogoutResponse> logout(
      $pb.ServerContext ctx, $1.LogoutRequest request);
  $async.Future<$1.GetMeResponse> getMe(
      $pb.ServerContext ctx, $1.GetMeRequest request);
  $async.Future<$1.BeginGoogleAuthResponse> beginGoogleAuth(
      $pb.ServerContext ctx, $1.BeginGoogleAuthRequest request);
  $async.Future<$1.AuthSessionResponse> exchangeGoogleAuthCode(
      $pb.ServerContext ctx, $1.ExchangeGoogleAuthCodeRequest request);
  $async.Future<$1.GetMeResponse> verifyEmail(
      $pb.ServerContext ctx, $1.VerifyEmailRequest request);
  $async.Future<$1.ResendVerificationEmailResponse> resendVerificationEmail(
      $pb.ServerContext ctx, $1.ResendVerificationEmailRequest request);
  $async.Future<$1.RequestPasswordResetResponse> requestPasswordReset(
      $pb.ServerContext ctx, $1.RequestPasswordResetRequest request);
  $async.Future<$1.ResetPasswordResponse> resetPassword(
      $pb.ServerContext ctx, $1.ResetPasswordRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Register':
        return $1.RegisterRequest();
      case 'Login':
        return $1.LoginRequest();
      case 'Refresh':
        return $1.RefreshRequest();
      case 'Logout':
        return $1.LogoutRequest();
      case 'GetMe':
        return $1.GetMeRequest();
      case 'BeginGoogleAuth':
        return $1.BeginGoogleAuthRequest();
      case 'ExchangeGoogleAuthCode':
        return $1.ExchangeGoogleAuthCodeRequest();
      case 'VerifyEmail':
        return $1.VerifyEmailRequest();
      case 'ResendVerificationEmail':
        return $1.ResendVerificationEmailRequest();
      case 'RequestPasswordReset':
        return $1.RequestPasswordResetRequest();
      case 'ResetPassword':
        return $1.ResetPasswordRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Register':
        return register(ctx, request as $1.RegisterRequest);
      case 'Login':
        return login(ctx, request as $1.LoginRequest);
      case 'Refresh':
        return refresh(ctx, request as $1.RefreshRequest);
      case 'Logout':
        return logout(ctx, request as $1.LogoutRequest);
      case 'GetMe':
        return getMe(ctx, request as $1.GetMeRequest);
      case 'BeginGoogleAuth':
        return beginGoogleAuth(ctx, request as $1.BeginGoogleAuthRequest);
      case 'ExchangeGoogleAuthCode':
        return exchangeGoogleAuthCode(
            ctx, request as $1.ExchangeGoogleAuthCodeRequest);
      case 'VerifyEmail':
        return verifyEmail(ctx, request as $1.VerifyEmailRequest);
      case 'ResendVerificationEmail':
        return resendVerificationEmail(
            ctx, request as $1.ResendVerificationEmailRequest);
      case 'RequestPasswordReset':
        return requestPasswordReset(
            ctx, request as $1.RequestPasswordResetRequest);
      case 'ResetPassword':
        return resetPassword(ctx, request as $1.ResetPasswordRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => IdentityServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => IdentityServiceBase$messageJson;
}
