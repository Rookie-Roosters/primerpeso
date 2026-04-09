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
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UserProfile extends $pb.GeneratedMessage {
  factory UserProfile({
    $core.String? userId,
    $core.String? email,
    $core.String? displayName,
    $core.bool? emailVerified,
    $0.Timestamp? createdAt,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (email != null) result.email = email;
    if (displayName != null) result.displayName = displayName;
    if (emailVerified != null) result.emailVerified = emailVerified;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  UserProfile._();

  factory UserProfile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserProfile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserProfile',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOB(4, _omitFieldNames ? '' : 'emailVerified')
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfile copyWith(void Function(UserProfile) updates) =>
      super.copyWith((message) => updates(message as UserProfile))
          as UserProfile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserProfile create() => UserProfile._();
  @$core.override
  UserProfile createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserProfile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserProfile>(create);
  static UserProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get emailVerified => $_getBF(3);
  @$pb.TagNumber(4)
  set emailVerified($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmailVerified() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmailVerified() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($0.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureCreatedAt() => $_ensure(4);
}

class AuthTokens extends $pb.GeneratedMessage {
  factory AuthTokens({
    $core.String? accessToken,
    $core.String? refreshToken,
    $0.Timestamp? expiresAt,
  }) {
    final result = create();
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  AuthTokens._();

  factory AuthTokens.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthTokens.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthTokens',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accessToken')
    ..aOS(2, _omitFieldNames ? '' : 'refreshToken')
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthTokens clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthTokens copyWith(void Function(AuthTokens) updates) =>
      super.copyWith((message) => updates(message as AuthTokens)) as AuthTokens;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthTokens create() => AuthTokens._();
  @$core.override
  AuthTokens createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthTokens getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthTokens>(create);
  static AuthTokens? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get expiresAt => $_getN(2);
  @$pb.TagNumber(3)
  set expiresAt($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureExpiresAt() => $_ensure(2);
}

class AuthSessionResponse extends $pb.GeneratedMessage {
  factory AuthSessionResponse({
    UserProfile? profile,
    AuthTokens? tokens,
  }) {
    final result = create();
    if (profile != null) result.profile = profile;
    if (tokens != null) result.tokens = tokens;
    return result;
  }

  AuthSessionResponse._();

  factory AuthSessionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthSessionResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOM<UserProfile>(1, _omitFieldNames ? '' : 'profile',
        subBuilder: UserProfile.create)
    ..aOM<AuthTokens>(2, _omitFieldNames ? '' : 'tokens',
        subBuilder: AuthTokens.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthSessionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthSessionResponse copyWith(void Function(AuthSessionResponse) updates) =>
      super.copyWith((message) => updates(message as AuthSessionResponse))
          as AuthSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthSessionResponse create() => AuthSessionResponse._();
  @$core.override
  AuthSessionResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthSessionResponse>(create);
  static AuthSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserProfile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(UserProfile value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => $_clearField(1);
  @$pb.TagNumber(1)
  UserProfile ensureProfile() => $_ensure(0);

  @$pb.TagNumber(2)
  AuthTokens get tokens => $_getN(1);
  @$pb.TagNumber(2)
  set tokens(AuthTokens value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTokens() => $_has(1);
  @$pb.TagNumber(2)
  void clearTokens() => $_clearField(2);
  @$pb.TagNumber(2)
  AuthTokens ensureTokens() => $_ensure(1);
}

class RegisterRequest extends $pb.GeneratedMessage {
  factory RegisterRequest({
    $core.String? email,
    $core.String? password,
    $core.String? displayName,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (password != null) result.password = password;
    if (displayName != null) result.displayName = displayName;
    return result;
  }

  RegisterRequest._();

  factory RegisterRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegisterRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterRequest copyWith(void Function(RegisterRequest) updates) =>
      super.copyWith((message) => updates(message as RegisterRequest))
          as RegisterRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterRequest create() => RegisterRequest._();
  @$core.override
  RegisterRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RegisterRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterRequest>(create);
  static RegisterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);
}

class LoginRequest extends $pb.GeneratedMessage {
  factory LoginRequest({
    $core.String? email,
    $core.String? password,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (password != null) result.password = password;
    return result;
  }

  LoginRequest._();

  factory LoginRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequest copyWith(void Function(LoginRequest) updates) =>
      super.copyWith((message) => updates(message as LoginRequest))
          as LoginRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginRequest create() => LoginRequest._();
  @$core.override
  LoginRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LoginRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginRequest>(create);
  static LoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);
}

class RefreshRequest extends $pb.GeneratedMessage {
  factory RefreshRequest({
    $core.String? refreshToken,
  }) {
    final result = create();
    if (refreshToken != null) result.refreshToken = refreshToken;
    return result;
  }

  RefreshRequest._();

  factory RefreshRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refreshToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshRequest copyWith(void Function(RefreshRequest) updates) =>
      super.copyWith((message) => updates(message as RefreshRequest))
          as RefreshRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshRequest create() => RefreshRequest._();
  @$core.override
  RefreshRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RefreshRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshRequest>(create);
  static RefreshRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refreshToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set refreshToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefreshToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefreshToken() => $_clearField(1);
}

class LogoutRequest extends $pb.GeneratedMessage {
  factory LogoutRequest({
    $core.String? refreshToken,
  }) {
    final result = create();
    if (refreshToken != null) result.refreshToken = refreshToken;
    return result;
  }

  LogoutRequest._();

  factory LogoutRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogoutRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogoutRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refreshToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutRequest copyWith(void Function(LogoutRequest) updates) =>
      super.copyWith((message) => updates(message as LogoutRequest))
          as LogoutRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogoutRequest create() => LogoutRequest._();
  @$core.override
  LogoutRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogoutRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogoutRequest>(create);
  static LogoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refreshToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set refreshToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefreshToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefreshToken() => $_clearField(1);
}

class LogoutResponse extends $pb.GeneratedMessage {
  factory LogoutResponse({
    $core.bool? ok,
  }) {
    final result = create();
    if (ok != null) result.ok = ok;
    return result;
  }

  LogoutResponse._();

  factory LogoutResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogoutResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogoutResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'ok')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutResponse copyWith(void Function(LogoutResponse) updates) =>
      super.copyWith((message) => updates(message as LogoutResponse))
          as LogoutResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogoutResponse create() => LogoutResponse._();
  @$core.override
  LogoutResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogoutResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogoutResponse>(create);
  static LogoutResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get ok => $_getBF(0);
  @$pb.TagNumber(1)
  set ok($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOk() => $_has(0);
  @$pb.TagNumber(1)
  void clearOk() => $_clearField(1);
}

class GetMeRequest extends $pb.GeneratedMessage {
  factory GetMeRequest() => create();

  GetMeRequest._();

  factory GetMeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMeRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeRequest copyWith(void Function(GetMeRequest) updates) =>
      super.copyWith((message) => updates(message as GetMeRequest))
          as GetMeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMeRequest create() => GetMeRequest._();
  @$core.override
  GetMeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetMeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMeRequest>(create);
  static GetMeRequest? _defaultInstance;
}

class GetMeResponse extends $pb.GeneratedMessage {
  factory GetMeResponse({
    UserProfile? profile,
  }) {
    final result = create();
    if (profile != null) result.profile = profile;
    return result;
  }

  GetMeResponse._();

  factory GetMeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMeResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOM<UserProfile>(1, _omitFieldNames ? '' : 'profile',
        subBuilder: UserProfile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeResponse copyWith(void Function(GetMeResponse) updates) =>
      super.copyWith((message) => updates(message as GetMeResponse))
          as GetMeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMeResponse create() => GetMeResponse._();
  @$core.override
  GetMeResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetMeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMeResponse>(create);
  static GetMeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserProfile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(UserProfile value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => $_clearField(1);
  @$pb.TagNumber(1)
  UserProfile ensureProfile() => $_ensure(0);
}

class BeginGoogleAuthRequest extends $pb.GeneratedMessage {
  factory BeginGoogleAuthRequest({
    $core.String? platform,
  }) {
    final result = create();
    if (platform != null) result.platform = platform;
    return result;
  }

  BeginGoogleAuthRequest._();

  factory BeginGoogleAuthRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BeginGoogleAuthRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BeginGoogleAuthRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'platform')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BeginGoogleAuthRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BeginGoogleAuthRequest copyWith(
          void Function(BeginGoogleAuthRequest) updates) =>
      super.copyWith((message) => updates(message as BeginGoogleAuthRequest))
          as BeginGoogleAuthRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BeginGoogleAuthRequest create() => BeginGoogleAuthRequest._();
  @$core.override
  BeginGoogleAuthRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BeginGoogleAuthRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BeginGoogleAuthRequest>(create);
  static BeginGoogleAuthRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get platform => $_getSZ(0);
  @$pb.TagNumber(1)
  set platform($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPlatform() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlatform() => $_clearField(1);
}

class BeginGoogleAuthResponse extends $pb.GeneratedMessage {
  factory BeginGoogleAuthResponse({
    $core.String? authorizationUrl,
    $core.String? state,
  }) {
    final result = create();
    if (authorizationUrl != null) result.authorizationUrl = authorizationUrl;
    if (state != null) result.state = state;
    return result;
  }

  BeginGoogleAuthResponse._();

  factory BeginGoogleAuthResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BeginGoogleAuthResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BeginGoogleAuthResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'authorizationUrl')
    ..aOS(2, _omitFieldNames ? '' : 'state')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BeginGoogleAuthResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BeginGoogleAuthResponse copyWith(
          void Function(BeginGoogleAuthResponse) updates) =>
      super.copyWith((message) => updates(message as BeginGoogleAuthResponse))
          as BeginGoogleAuthResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BeginGoogleAuthResponse create() => BeginGoogleAuthResponse._();
  @$core.override
  BeginGoogleAuthResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BeginGoogleAuthResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BeginGoogleAuthResponse>(create);
  static BeginGoogleAuthResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get authorizationUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set authorizationUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAuthorizationUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearAuthorizationUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get state => $_getSZ(1);
  @$pb.TagNumber(2)
  set state($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => $_clearField(2);
}

class ExchangeGoogleAuthCodeRequest extends $pb.GeneratedMessage {
  factory ExchangeGoogleAuthCodeRequest({
    $core.String? exchangeCode,
  }) {
    final result = create();
    if (exchangeCode != null) result.exchangeCode = exchangeCode;
    return result;
  }

  ExchangeGoogleAuthCodeRequest._();

  factory ExchangeGoogleAuthCodeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExchangeGoogleAuthCodeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExchangeGoogleAuthCodeRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'exchangeCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeGoogleAuthCodeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeGoogleAuthCodeRequest copyWith(
          void Function(ExchangeGoogleAuthCodeRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ExchangeGoogleAuthCodeRequest))
          as ExchangeGoogleAuthCodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExchangeGoogleAuthCodeRequest create() =>
      ExchangeGoogleAuthCodeRequest._();
  @$core.override
  ExchangeGoogleAuthCodeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ExchangeGoogleAuthCodeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExchangeGoogleAuthCodeRequest>(create);
  static ExchangeGoogleAuthCodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get exchangeCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set exchangeCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExchangeCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearExchangeCode() => $_clearField(1);
}

class VerifyEmailRequest extends $pb.GeneratedMessage {
  factory VerifyEmailRequest({
    $core.String? verificationToken,
  }) {
    final result = create();
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  VerifyEmailRequest._();

  factory VerifyEmailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyEmailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyEmailRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailRequest copyWith(void Function(VerifyEmailRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyEmailRequest))
          as VerifyEmailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyEmailRequest create() => VerifyEmailRequest._();
  @$core.override
  VerifyEmailRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VerifyEmailRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyEmailRequest>(create);
  static VerifyEmailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get verificationToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set verificationToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVerificationToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerificationToken() => $_clearField(1);
}

class ResendVerificationEmailRequest extends $pb.GeneratedMessage {
  factory ResendVerificationEmailRequest({
    $core.String? email,
  }) {
    final result = create();
    if (email != null) result.email = email;
    return result;
  }

  ResendVerificationEmailRequest._();

  factory ResendVerificationEmailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResendVerificationEmailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResendVerificationEmailRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendVerificationEmailRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendVerificationEmailRequest copyWith(
          void Function(ResendVerificationEmailRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ResendVerificationEmailRequest))
          as ResendVerificationEmailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailRequest create() =>
      ResendVerificationEmailRequest._();
  @$core.override
  ResendVerificationEmailRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResendVerificationEmailRequest>(create);
  static ResendVerificationEmailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

class ResendVerificationEmailResponse extends $pb.GeneratedMessage {
  factory ResendVerificationEmailResponse({
    $core.bool? ok,
  }) {
    final result = create();
    if (ok != null) result.ok = ok;
    return result;
  }

  ResendVerificationEmailResponse._();

  factory ResendVerificationEmailResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResendVerificationEmailResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResendVerificationEmailResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'ok')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendVerificationEmailResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendVerificationEmailResponse copyWith(
          void Function(ResendVerificationEmailResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ResendVerificationEmailResponse))
          as ResendVerificationEmailResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailResponse create() =>
      ResendVerificationEmailResponse._();
  @$core.override
  ResendVerificationEmailResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResendVerificationEmailResponse>(
          create);
  static ResendVerificationEmailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get ok => $_getBF(0);
  @$pb.TagNumber(1)
  set ok($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOk() => $_has(0);
  @$pb.TagNumber(1)
  void clearOk() => $_clearField(1);
}

class RequestPasswordResetRequest extends $pb.GeneratedMessage {
  factory RequestPasswordResetRequest({
    $core.String? email,
  }) {
    final result = create();
    if (email != null) result.email = email;
    return result;
  }

  RequestPasswordResetRequest._();

  factory RequestPasswordResetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestPasswordResetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestPasswordResetRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPasswordResetRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPasswordResetRequest copyWith(
          void Function(RequestPasswordResetRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RequestPasswordResetRequest))
          as RequestPasswordResetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetRequest create() =>
      RequestPasswordResetRequest._();
  @$core.override
  RequestPasswordResetRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestPasswordResetRequest>(create);
  static RequestPasswordResetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

class RequestPasswordResetResponse extends $pb.GeneratedMessage {
  factory RequestPasswordResetResponse({
    $core.bool? ok,
  }) {
    final result = create();
    if (ok != null) result.ok = ok;
    return result;
  }

  RequestPasswordResetResponse._();

  factory RequestPasswordResetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestPasswordResetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestPasswordResetResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'ok')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPasswordResetResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPasswordResetResponse copyWith(
          void Function(RequestPasswordResetResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RequestPasswordResetResponse))
          as RequestPasswordResetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetResponse create() =>
      RequestPasswordResetResponse._();
  @$core.override
  RequestPasswordResetResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestPasswordResetResponse>(create);
  static RequestPasswordResetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get ok => $_getBF(0);
  @$pb.TagNumber(1)
  set ok($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOk() => $_has(0);
  @$pb.TagNumber(1)
  void clearOk() => $_clearField(1);
}

class ResetPasswordRequest extends $pb.GeneratedMessage {
  factory ResetPasswordRequest({
    $core.String? resetToken,
    $core.String? newPassword,
  }) {
    final result = create();
    if (resetToken != null) result.resetToken = resetToken;
    if (newPassword != null) result.newPassword = newPassword;
    return result;
  }

  ResetPasswordRequest._();

  factory ResetPasswordRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResetPasswordRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResetPasswordRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'resetToken')
    ..aOS(2, _omitFieldNames ? '' : 'newPassword')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResetPasswordRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResetPasswordRequest copyWith(void Function(ResetPasswordRequest) updates) =>
      super.copyWith((message) => updates(message as ResetPasswordRequest))
          as ResetPasswordRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetPasswordRequest create() => ResetPasswordRequest._();
  @$core.override
  ResetPasswordRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ResetPasswordRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResetPasswordRequest>(create);
  static ResetPasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get resetToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set resetToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasResetToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearResetToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get newPassword => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPassword($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPassword() => $_clearField(2);
}

class ResetPasswordResponse extends $pb.GeneratedMessage {
  factory ResetPasswordResponse({
    $core.bool? ok,
  }) {
    final result = create();
    if (ok != null) result.ok = ok;
    return result;
  }

  ResetPasswordResponse._();

  factory ResetPasswordResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResetPasswordResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResetPasswordResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.identity.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'ok')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResetPasswordResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResetPasswordResponse copyWith(
          void Function(ResetPasswordResponse) updates) =>
      super.copyWith((message) => updates(message as ResetPasswordResponse))
          as ResetPasswordResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetPasswordResponse create() => ResetPasswordResponse._();
  @$core.override
  ResetPasswordResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ResetPasswordResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResetPasswordResponse>(create);
  static ResetPasswordResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get ok => $_getBF(0);
  @$pb.TagNumber(1)
  set ok($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOk() => $_has(0);
  @$pb.TagNumber(1)
  void clearOk() => $_clearField(1);
}

class IdentityServiceApi {
  final $pb.RpcClient _client;

  IdentityServiceApi(this._client);

  $async.Future<AuthSessionResponse> register(
          $pb.ClientContext? ctx, RegisterRequest request) =>
      _client.invoke<AuthSessionResponse>(
          ctx, 'IdentityService', 'Register', request, AuthSessionResponse());
  $async.Future<AuthSessionResponse> login(
          $pb.ClientContext? ctx, LoginRequest request) =>
      _client.invoke<AuthSessionResponse>(
          ctx, 'IdentityService', 'Login', request, AuthSessionResponse());
  $async.Future<AuthSessionResponse> refresh(
          $pb.ClientContext? ctx, RefreshRequest request) =>
      _client.invoke<AuthSessionResponse>(
          ctx, 'IdentityService', 'Refresh', request, AuthSessionResponse());
  $async.Future<LogoutResponse> logout(
          $pb.ClientContext? ctx, LogoutRequest request) =>
      _client.invoke<LogoutResponse>(
          ctx, 'IdentityService', 'Logout', request, LogoutResponse());
  $async.Future<GetMeResponse> getMe(
          $pb.ClientContext? ctx, GetMeRequest request) =>
      _client.invoke<GetMeResponse>(
          ctx, 'IdentityService', 'GetMe', request, GetMeResponse());
  $async.Future<BeginGoogleAuthResponse> beginGoogleAuth(
          $pb.ClientContext? ctx, BeginGoogleAuthRequest request) =>
      _client.invoke<BeginGoogleAuthResponse>(ctx, 'IdentityService',
          'BeginGoogleAuth', request, BeginGoogleAuthResponse());
  $async.Future<AuthSessionResponse> exchangeGoogleAuthCode(
          $pb.ClientContext? ctx, ExchangeGoogleAuthCodeRequest request) =>
      _client.invoke<AuthSessionResponse>(ctx, 'IdentityService',
          'ExchangeGoogleAuthCode', request, AuthSessionResponse());
  $async.Future<GetMeResponse> verifyEmail(
          $pb.ClientContext? ctx, VerifyEmailRequest request) =>
      _client.invoke<GetMeResponse>(
          ctx, 'IdentityService', 'VerifyEmail', request, GetMeResponse());
  $async.Future<ResendVerificationEmailResponse> resendVerificationEmail(
          $pb.ClientContext? ctx, ResendVerificationEmailRequest request) =>
      _client.invoke<ResendVerificationEmailResponse>(
          ctx,
          'IdentityService',
          'ResendVerificationEmail',
          request,
          ResendVerificationEmailResponse());
  $async.Future<RequestPasswordResetResponse> requestPasswordReset(
          $pb.ClientContext? ctx, RequestPasswordResetRequest request) =>
      _client.invoke<RequestPasswordResetResponse>(ctx, 'IdentityService',
          'RequestPasswordReset', request, RequestPasswordResetResponse());
  $async.Future<ResetPasswordResponse> resetPassword(
          $pb.ClientContext? ctx, ResetPasswordRequest request) =>
      _client.invoke<ResetPasswordResponse>(ctx, 'IdentityService',
          'ResetPassword', request, ResetPasswordResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
