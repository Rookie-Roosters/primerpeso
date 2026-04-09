// This is a generated file - do not edit.
//
// Generated from primerpeso/identity/v1/identity.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'package:protobuf/well_known_types/google/protobuf/timestamp.pbjson.dart'
    as $0;

@$core.Deprecated('Use userProfileDescriptor instead')
const UserProfile$json = {
  '1': 'UserProfile',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'email_verified', '3': 4, '4': 1, '5': 8, '10': 'emailVerified'},
    {
      '1': 'created_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `UserProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userProfileDescriptor = $convert.base64Decode(
    'CgtVc2VyUHJvZmlsZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFZW1haWwYAiABKAlSBW'
    'VtYWlsEiEKDGRpc3BsYXlfbmFtZRgDIAEoCVILZGlzcGxheU5hbWUSJQoOZW1haWxfdmVyaWZp'
    'ZWQYBCABKAhSDWVtYWlsVmVyaWZpZWQSOQoKY3JlYXRlZF9hdBgFIAEoCzIaLmdvb2dsZS5wcm'
    '90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use authTokensDescriptor instead')
const AuthTokens$json = {
  '1': 'AuthTokens',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
    {
      '1': 'expires_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'expiresAt'
    },
  ],
};

/// Descriptor for `AuthTokens`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authTokensDescriptor = $convert.base64Decode(
    'CgpBdXRoVG9rZW5zEiEKDGFjY2Vzc190b2tlbhgBIAEoCVILYWNjZXNzVG9rZW4SIwoNcmVmcm'
    'VzaF90b2tlbhgCIAEoCVIMcmVmcmVzaFRva2VuEjkKCmV4cGlyZXNfYXQYAyABKAsyGi5nb29n'
    'bGUucHJvdG9idWYuVGltZXN0YW1wUglleHBpcmVzQXQ=');

@$core.Deprecated('Use authSessionResponseDescriptor instead')
const AuthSessionResponse$json = {
  '1': 'AuthSessionResponse',
  '2': [
    {
      '1': 'profile',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.identity.v1.UserProfile',
      '10': 'profile'
    },
    {
      '1': 'tokens',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.identity.v1.AuthTokens',
      '10': 'tokens'
    },
  ],
};

/// Descriptor for `AuthSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authSessionResponseDescriptor = $convert.base64Decode(
    'ChNBdXRoU2Vzc2lvblJlc3BvbnNlEj0KB3Byb2ZpbGUYASABKAsyIy5wcmltZXJwZXNvLmlkZW'
    '50aXR5LnYxLlVzZXJQcm9maWxlUgdwcm9maWxlEjoKBnRva2VucxgCIAEoCzIiLnByaW1lcnBl'
    'c28uaWRlbnRpdHkudjEuQXV0aFRva2Vuc1IGdG9rZW5z');

@$core.Deprecated('Use registerRequestDescriptor instead')
const RegisterRequest$json = {
  '1': 'RegisterRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
  ],
};

/// Descriptor for `RegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerRequestDescriptor = $convert.base64Decode(
    'Cg9SZWdpc3RlclJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhoKCHBhc3N3b3JkGAIgAS'
    'gJUghwYXNzd29yZBIhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1l');

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWlsEhoKCHBhc3N3b3JkGAIgASgJUg'
    'hwYXNzd29yZA==');

@$core.Deprecated('Use refreshRequestDescriptor instead')
const RefreshRequest$json = {
  '1': 'RefreshRequest',
  '2': [
    {'1': 'refresh_token', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `RefreshRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshRequestDescriptor = $convert.base64Decode(
    'Cg5SZWZyZXNoUmVxdWVzdBIjCg1yZWZyZXNoX3Rva2VuGAEgASgJUgxyZWZyZXNoVG9rZW4=');

@$core.Deprecated('Use logoutRequestDescriptor instead')
const LogoutRequest$json = {
  '1': 'LogoutRequest',
  '2': [
    {'1': 'refresh_token', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `LogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutRequestDescriptor = $convert.base64Decode(
    'Cg1Mb2dvdXRSZXF1ZXN0EiMKDXJlZnJlc2hfdG9rZW4YASABKAlSDHJlZnJlc2hUb2tlbg==');

@$core.Deprecated('Use logoutResponseDescriptor instead')
const LogoutResponse$json = {
  '1': 'LogoutResponse',
  '2': [
    {'1': 'ok', '3': 1, '4': 1, '5': 8, '10': 'ok'},
  ],
};

/// Descriptor for `LogoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutResponseDescriptor =
    $convert.base64Decode('Cg5Mb2dvdXRSZXNwb25zZRIOCgJvaxgBIAEoCFICb2s=');

@$core.Deprecated('Use getMeRequestDescriptor instead')
const GetMeRequest$json = {
  '1': 'GetMeRequest',
};

/// Descriptor for `GetMeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMeRequestDescriptor =
    $convert.base64Decode('CgxHZXRNZVJlcXVlc3Q=');

@$core.Deprecated('Use getMeResponseDescriptor instead')
const GetMeResponse$json = {
  '1': 'GetMeResponse',
  '2': [
    {
      '1': 'profile',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.identity.v1.UserProfile',
      '10': 'profile'
    },
  ],
};

/// Descriptor for `GetMeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMeResponseDescriptor = $convert.base64Decode(
    'Cg1HZXRNZVJlc3BvbnNlEj0KB3Byb2ZpbGUYASABKAsyIy5wcmltZXJwZXNvLmlkZW50aXR5Ln'
    'YxLlVzZXJQcm9maWxlUgdwcm9maWxl');

@$core.Deprecated('Use beginGoogleAuthRequestDescriptor instead')
const BeginGoogleAuthRequest$json = {
  '1': 'BeginGoogleAuthRequest',
  '2': [
    {'1': 'platform', '3': 1, '4': 1, '5': 9, '10': 'platform'},
  ],
};

/// Descriptor for `BeginGoogleAuthRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List beginGoogleAuthRequestDescriptor =
    $convert.base64Decode(
        'ChZCZWdpbkdvb2dsZUF1dGhSZXF1ZXN0EhoKCHBsYXRmb3JtGAEgASgJUghwbGF0Zm9ybQ==');

@$core.Deprecated('Use beginGoogleAuthResponseDescriptor instead')
const BeginGoogleAuthResponse$json = {
  '1': 'BeginGoogleAuthResponse',
  '2': [
    {
      '1': 'authorization_url',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'authorizationUrl'
    },
    {'1': 'state', '3': 2, '4': 1, '5': 9, '10': 'state'},
  ],
};

/// Descriptor for `BeginGoogleAuthResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List beginGoogleAuthResponseDescriptor =
    $convert.base64Decode(
        'ChdCZWdpbkdvb2dsZUF1dGhSZXNwb25zZRIrChFhdXRob3JpemF0aW9uX3VybBgBIAEoCVIQYX'
        'V0aG9yaXphdGlvblVybBIUCgVzdGF0ZRgCIAEoCVIFc3RhdGU=');

@$core.Deprecated('Use exchangeGoogleAuthCodeRequestDescriptor instead')
const ExchangeGoogleAuthCodeRequest$json = {
  '1': 'ExchangeGoogleAuthCodeRequest',
  '2': [
    {'1': 'exchange_code', '3': 1, '4': 1, '5': 9, '10': 'exchangeCode'},
  ],
};

/// Descriptor for `ExchangeGoogleAuthCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeGoogleAuthCodeRequestDescriptor =
    $convert.base64Decode(
        'Ch1FeGNoYW5nZUdvb2dsZUF1dGhDb2RlUmVxdWVzdBIjCg1leGNoYW5nZV9jb2RlGAEgASgJUg'
        'xleGNoYW5nZUNvZGU=');

@$core.Deprecated('Use verifyEmailRequestDescriptor instead')
const VerifyEmailRequest$json = {
  '1': 'VerifyEmailRequest',
  '2': [
    {
      '1': 'verification_token',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'verificationToken'
    },
  ],
};

/// Descriptor for `VerifyEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailRequestDescriptor = $convert.base64Decode(
    'ChJWZXJpZnlFbWFpbFJlcXVlc3QSLQoSdmVyaWZpY2F0aW9uX3Rva2VuGAEgASgJUhF2ZXJpZm'
    'ljYXRpb25Ub2tlbg==');

@$core.Deprecated('Use resendVerificationEmailRequestDescriptor instead')
const ResendVerificationEmailRequest$json = {
  '1': 'ResendVerificationEmailRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `ResendVerificationEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendVerificationEmailRequestDescriptor =
    $convert.base64Decode(
        'Ch5SZXNlbmRWZXJpZmljYXRpb25FbWFpbFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWls');

@$core.Deprecated('Use resendVerificationEmailResponseDescriptor instead')
const ResendVerificationEmailResponse$json = {
  '1': 'ResendVerificationEmailResponse',
  '2': [
    {'1': 'ok', '3': 1, '4': 1, '5': 8, '10': 'ok'},
  ],
};

/// Descriptor for `ResendVerificationEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendVerificationEmailResponseDescriptor =
    $convert.base64Decode(
        'Ch9SZXNlbmRWZXJpZmljYXRpb25FbWFpbFJlc3BvbnNlEg4KAm9rGAEgASgIUgJvaw==');

@$core.Deprecated('Use requestPasswordResetRequestDescriptor instead')
const RequestPasswordResetRequest$json = {
  '1': 'RequestPasswordResetRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `RequestPasswordResetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPasswordResetRequestDescriptor =
    $convert.base64Decode(
        'ChtSZXF1ZXN0UGFzc3dvcmRSZXNldFJlcXVlc3QSFAoFZW1haWwYASABKAlSBWVtYWls');

@$core.Deprecated('Use requestPasswordResetResponseDescriptor instead')
const RequestPasswordResetResponse$json = {
  '1': 'RequestPasswordResetResponse',
  '2': [
    {'1': 'ok', '3': 1, '4': 1, '5': 8, '10': 'ok'},
  ],
};

/// Descriptor for `RequestPasswordResetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestPasswordResetResponseDescriptor =
    $convert.base64Decode(
        'ChxSZXF1ZXN0UGFzc3dvcmRSZXNldFJlc3BvbnNlEg4KAm9rGAEgASgIUgJvaw==');

@$core.Deprecated('Use resetPasswordRequestDescriptor instead')
const ResetPasswordRequest$json = {
  '1': 'ResetPasswordRequest',
  '2': [
    {'1': 'reset_token', '3': 1, '4': 1, '5': 9, '10': 'resetToken'},
    {'1': 'new_password', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
  ],
};

/// Descriptor for `ResetPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordRequestDescriptor = $convert.base64Decode(
    'ChRSZXNldFBhc3N3b3JkUmVxdWVzdBIfCgtyZXNldF90b2tlbhgBIAEoCVIKcmVzZXRUb2tlbh'
    'IhCgxuZXdfcGFzc3dvcmQYAiABKAlSC25ld1Bhc3N3b3Jk');

@$core.Deprecated('Use resetPasswordResponseDescriptor instead')
const ResetPasswordResponse$json = {
  '1': 'ResetPasswordResponse',
  '2': [
    {'1': 'ok', '3': 1, '4': 1, '5': 8, '10': 'ok'},
  ],
};

/// Descriptor for `ResetPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetPasswordResponseDescriptor = $convert
    .base64Decode('ChVSZXNldFBhc3N3b3JkUmVzcG9uc2USDgoCb2sYASABKAhSAm9r');

const $core.Map<$core.String, $core.dynamic> IdentityServiceBase$json = {
  '1': 'IdentityService',
  '2': [
    {
      '1': 'Register',
      '2': '.primerpeso.identity.v1.RegisterRequest',
      '3': '.primerpeso.identity.v1.AuthSessionResponse'
    },
    {
      '1': 'Login',
      '2': '.primerpeso.identity.v1.LoginRequest',
      '3': '.primerpeso.identity.v1.AuthSessionResponse'
    },
    {
      '1': 'Refresh',
      '2': '.primerpeso.identity.v1.RefreshRequest',
      '3': '.primerpeso.identity.v1.AuthSessionResponse'
    },
    {
      '1': 'Logout',
      '2': '.primerpeso.identity.v1.LogoutRequest',
      '3': '.primerpeso.identity.v1.LogoutResponse'
    },
    {
      '1': 'GetMe',
      '2': '.primerpeso.identity.v1.GetMeRequest',
      '3': '.primerpeso.identity.v1.GetMeResponse'
    },
    {
      '1': 'BeginGoogleAuth',
      '2': '.primerpeso.identity.v1.BeginGoogleAuthRequest',
      '3': '.primerpeso.identity.v1.BeginGoogleAuthResponse'
    },
    {
      '1': 'ExchangeGoogleAuthCode',
      '2': '.primerpeso.identity.v1.ExchangeGoogleAuthCodeRequest',
      '3': '.primerpeso.identity.v1.AuthSessionResponse'
    },
    {
      '1': 'VerifyEmail',
      '2': '.primerpeso.identity.v1.VerifyEmailRequest',
      '3': '.primerpeso.identity.v1.GetMeResponse'
    },
    {
      '1': 'ResendVerificationEmail',
      '2': '.primerpeso.identity.v1.ResendVerificationEmailRequest',
      '3': '.primerpeso.identity.v1.ResendVerificationEmailResponse'
    },
    {
      '1': 'RequestPasswordReset',
      '2': '.primerpeso.identity.v1.RequestPasswordResetRequest',
      '3': '.primerpeso.identity.v1.RequestPasswordResetResponse'
    },
    {
      '1': 'ResetPassword',
      '2': '.primerpeso.identity.v1.ResetPasswordRequest',
      '3': '.primerpeso.identity.v1.ResetPasswordResponse'
    },
  ],
};

@$core.Deprecated('Use identityServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    IdentityServiceBase$messageJson = {
  '.primerpeso.identity.v1.RegisterRequest': RegisterRequest$json,
  '.primerpeso.identity.v1.AuthSessionResponse': AuthSessionResponse$json,
  '.primerpeso.identity.v1.UserProfile': UserProfile$json,
  '.google.protobuf.Timestamp': $0.Timestamp$json,
  '.primerpeso.identity.v1.AuthTokens': AuthTokens$json,
  '.primerpeso.identity.v1.LoginRequest': LoginRequest$json,
  '.primerpeso.identity.v1.RefreshRequest': RefreshRequest$json,
  '.primerpeso.identity.v1.LogoutRequest': LogoutRequest$json,
  '.primerpeso.identity.v1.LogoutResponse': LogoutResponse$json,
  '.primerpeso.identity.v1.GetMeRequest': GetMeRequest$json,
  '.primerpeso.identity.v1.GetMeResponse': GetMeResponse$json,
  '.primerpeso.identity.v1.BeginGoogleAuthRequest': BeginGoogleAuthRequest$json,
  '.primerpeso.identity.v1.BeginGoogleAuthResponse':
      BeginGoogleAuthResponse$json,
  '.primerpeso.identity.v1.ExchangeGoogleAuthCodeRequest':
      ExchangeGoogleAuthCodeRequest$json,
  '.primerpeso.identity.v1.VerifyEmailRequest': VerifyEmailRequest$json,
  '.primerpeso.identity.v1.ResendVerificationEmailRequest':
      ResendVerificationEmailRequest$json,
  '.primerpeso.identity.v1.ResendVerificationEmailResponse':
      ResendVerificationEmailResponse$json,
  '.primerpeso.identity.v1.RequestPasswordResetRequest':
      RequestPasswordResetRequest$json,
  '.primerpeso.identity.v1.RequestPasswordResetResponse':
      RequestPasswordResetResponse$json,
  '.primerpeso.identity.v1.ResetPasswordRequest': ResetPasswordRequest$json,
  '.primerpeso.identity.v1.ResetPasswordResponse': ResetPasswordResponse$json,
};

/// Descriptor for `IdentityService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List identityServiceDescriptor = $convert.base64Decode(
    'Cg9JZGVudGl0eVNlcnZpY2USYAoIUmVnaXN0ZXISJy5wcmltZXJwZXNvLmlkZW50aXR5LnYxLl'
    'JlZ2lzdGVyUmVxdWVzdBorLnByaW1lcnBlc28uaWRlbnRpdHkudjEuQXV0aFNlc3Npb25SZXNw'
    'b25zZRJaCgVMb2dpbhIkLnByaW1lcnBlc28uaWRlbnRpdHkudjEuTG9naW5SZXF1ZXN0GisucH'
    'JpbWVycGVzby5pZGVudGl0eS52MS5BdXRoU2Vzc2lvblJlc3BvbnNlEl4KB1JlZnJlc2gSJi5w'
    'cmltZXJwZXNvLmlkZW50aXR5LnYxLlJlZnJlc2hSZXF1ZXN0GisucHJpbWVycGVzby5pZGVudG'
    'l0eS52MS5BdXRoU2Vzc2lvblJlc3BvbnNlElcKBkxvZ291dBIlLnByaW1lcnBlc28uaWRlbnRp'
    'dHkudjEuTG9nb3V0UmVxdWVzdBomLnByaW1lcnBlc28uaWRlbnRpdHkudjEuTG9nb3V0UmVzcG'
    '9uc2USVAoFR2V0TWUSJC5wcmltZXJwZXNvLmlkZW50aXR5LnYxLkdldE1lUmVxdWVzdBolLnBy'
    'aW1lcnBlc28uaWRlbnRpdHkudjEuR2V0TWVSZXNwb25zZRJyCg9CZWdpbkdvb2dsZUF1dGgSLi'
    '5wcmltZXJwZXNvLmlkZW50aXR5LnYxLkJlZ2luR29vZ2xlQXV0aFJlcXVlc3QaLy5wcmltZXJw'
    'ZXNvLmlkZW50aXR5LnYxLkJlZ2luR29vZ2xlQXV0aFJlc3BvbnNlEnwKFkV4Y2hhbmdlR29vZ2'
    'xlQXV0aENvZGUSNS5wcmltZXJwZXNvLmlkZW50aXR5LnYxLkV4Y2hhbmdlR29vZ2xlQXV0aENv'
    'ZGVSZXF1ZXN0GisucHJpbWVycGVzby5pZGVudGl0eS52MS5BdXRoU2Vzc2lvblJlc3BvbnNlEm'
    'AKC1ZlcmlmeUVtYWlsEioucHJpbWVycGVzby5pZGVudGl0eS52MS5WZXJpZnlFbWFpbFJlcXVl'
    'c3QaJS5wcmltZXJwZXNvLmlkZW50aXR5LnYxLkdldE1lUmVzcG9uc2USigEKF1Jlc2VuZFZlcm'
    'lmaWNhdGlvbkVtYWlsEjYucHJpbWVycGVzby5pZGVudGl0eS52MS5SZXNlbmRWZXJpZmljYXRp'
    'b25FbWFpbFJlcXVlc3QaNy5wcmltZXJwZXNvLmlkZW50aXR5LnYxLlJlc2VuZFZlcmlmaWNhdG'
    'lvbkVtYWlsUmVzcG9uc2USgQEKFFJlcXVlc3RQYXNzd29yZFJlc2V0EjMucHJpbWVycGVzby5p'
    'ZGVudGl0eS52MS5SZXF1ZXN0UGFzc3dvcmRSZXNldFJlcXVlc3QaNC5wcmltZXJwZXNvLmlkZW'
    '50aXR5LnYxLlJlcXVlc3RQYXNzd29yZFJlc2V0UmVzcG9uc2USbAoNUmVzZXRQYXNzd29yZBIs'
    'LnByaW1lcnBlc28uaWRlbnRpdHkudjEuUmVzZXRQYXNzd29yZFJlcXVlc3QaLS5wcmltZXJwZX'
    'NvLmlkZW50aXR5LnYxLlJlc2V0UGFzc3dvcmRSZXNwb25zZQ==');
