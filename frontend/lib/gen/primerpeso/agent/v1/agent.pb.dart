// This is a generated file - do not edit.
//
// Generated from primerpeso/agent/v1/agent.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart' as $0;

import '../../finance/v1/finance.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ChatMessage extends $pb.GeneratedMessage {
  factory ChatMessage({
    $core.String? id,
    $core.String? role,
    $core.String? content,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (role != null) result.role = role;
    if (content != null) result.content = content;
    return result;
  }

  ChatMessage._();

  factory ChatMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'role')
    ..aOS(3, _omitFieldNames ? '' : 'content')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMessage copyWith(void Function(ChatMessage) updates) =>
      super.copyWith((message) => updates(message as ChatMessage))
          as ChatMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessage create() => ChatMessage._();
  @$core.override
  ChatMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMessage>(create);
  static ChatMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get role => $_getSZ(1);
  @$pb.TagNumber(2)
  set role($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get content => $_getSZ(2);
  @$pb.TagNumber(3)
  set content($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearContent() => $_clearField(3);
}

class ToolDefinition extends $pb.GeneratedMessage {
  factory ToolDefinition({
    $core.String? name,
    $core.String? description,
    $0.Struct? parameters,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (parameters != null) result.parameters = parameters;
    return result;
  }

  ToolDefinition._();

  factory ToolDefinition.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToolDefinition.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToolDefinition',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOM<$0.Struct>(3, _omitFieldNames ? '' : 'parameters',
        subBuilder: $0.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToolDefinition clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToolDefinition copyWith(void Function(ToolDefinition) updates) =>
      super.copyWith((message) => updates(message as ToolDefinition))
          as ToolDefinition;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToolDefinition create() => ToolDefinition._();
  @$core.override
  ToolDefinition createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ToolDefinition getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToolDefinition>(create);
  static ToolDefinition? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.Struct get parameters => $_getN(2);
  @$pb.TagNumber(3)
  set parameters($0.Struct value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasParameters() => $_has(2);
  @$pb.TagNumber(3)
  void clearParameters() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Struct ensureParameters() => $_ensure(2);
}

class RunRequest extends $pb.GeneratedMessage {
  factory RunRequest({
    $core.String? threadId,
    $core.String? runId,
    $core.Iterable<ChatMessage>? messages,
    $0.Struct? state,
    $core.Iterable<ToolDefinition>? tools,
  }) {
    final result = create();
    if (threadId != null) result.threadId = threadId;
    if (runId != null) result.runId = runId;
    if (messages != null) result.messages.addAll(messages);
    if (state != null) result.state = state;
    if (tools != null) result.tools.addAll(tools);
    return result;
  }

  RunRequest._();

  factory RunRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RunRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RunRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'threadId')
    ..aOS(2, _omitFieldNames ? '' : 'runId')
    ..pPM<ChatMessage>(3, _omitFieldNames ? '' : 'messages',
        subBuilder: ChatMessage.create)
    ..aOM<$0.Struct>(4, _omitFieldNames ? '' : 'state',
        subBuilder: $0.Struct.create)
    ..pPM<ToolDefinition>(5, _omitFieldNames ? '' : 'tools',
        subBuilder: ToolDefinition.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunRequest copyWith(void Function(RunRequest) updates) =>
      super.copyWith((message) => updates(message as RunRequest)) as RunRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunRequest create() => RunRequest._();
  @$core.override
  RunRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RunRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RunRequest>(create);
  static RunRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get threadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set threadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get runId => $_getSZ(1);
  @$pb.TagNumber(2)
  set runId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<ChatMessage> get messages => $_getList(2);

  @$pb.TagNumber(4)
  $0.Struct get state => $_getN(3);
  @$pb.TagNumber(4)
  set state($0.Struct value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasState() => $_has(3);
  @$pb.TagNumber(4)
  void clearState() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Struct ensureState() => $_ensure(3);

  @$pb.TagNumber(5)
  $pb.PbList<ToolDefinition> get tools => $_getList(4);
}

class RunStarted extends $pb.GeneratedMessage {
  factory RunStarted({
    $core.String? threadId,
    $core.String? runId,
  }) {
    final result = create();
    if (threadId != null) result.threadId = threadId;
    if (runId != null) result.runId = runId;
    return result;
  }

  RunStarted._();

  factory RunStarted.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RunStarted.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RunStarted',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'threadId')
    ..aOS(2, _omitFieldNames ? '' : 'runId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunStarted clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunStarted copyWith(void Function(RunStarted) updates) =>
      super.copyWith((message) => updates(message as RunStarted)) as RunStarted;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunStarted create() => RunStarted._();
  @$core.override
  RunStarted createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RunStarted getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RunStarted>(create);
  static RunStarted? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get threadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set threadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get runId => $_getSZ(1);
  @$pb.TagNumber(2)
  set runId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunId() => $_clearField(2);
}

class RunFinished extends $pb.GeneratedMessage {
  factory RunFinished({
    $core.String? threadId,
    $core.String? runId,
  }) {
    final result = create();
    if (threadId != null) result.threadId = threadId;
    if (runId != null) result.runId = runId;
    return result;
  }

  RunFinished._();

  factory RunFinished.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RunFinished.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RunFinished',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'threadId')
    ..aOS(2, _omitFieldNames ? '' : 'runId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunFinished clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunFinished copyWith(void Function(RunFinished) updates) =>
      super.copyWith((message) => updates(message as RunFinished))
          as RunFinished;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunFinished create() => RunFinished._();
  @$core.override
  RunFinished createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RunFinished getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RunFinished>(create);
  static RunFinished? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get threadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set threadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get runId => $_getSZ(1);
  @$pb.TagNumber(2)
  set runId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunId() => $_clearField(2);
}

class RunError extends $pb.GeneratedMessage {
  factory RunError({
    $core.String? threadId,
    $core.String? runId,
    $core.String? message,
    $core.String? code,
  }) {
    final result = create();
    if (threadId != null) result.threadId = threadId;
    if (runId != null) result.runId = runId;
    if (message != null) result.message = message;
    if (code != null) result.code = code;
    return result;
  }

  RunError._();

  factory RunError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RunError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RunError',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'threadId')
    ..aOS(2, _omitFieldNames ? '' : 'runId')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOS(4, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunError clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunError copyWith(void Function(RunError) updates) =>
      super.copyWith((message) => updates(message as RunError)) as RunError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunError create() => RunError._();
  @$core.override
  RunError createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RunError getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RunError>(create);
  static RunError? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get threadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set threadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get runId => $_getSZ(1);
  @$pb.TagNumber(2)
  set runId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get code => $_getSZ(3);
  @$pb.TagNumber(4)
  set code($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCode() => $_clearField(4);
}

class TextMessageStart extends $pb.GeneratedMessage {
  factory TextMessageStart({
    $core.String? threadId,
    $core.String? runId,
    $core.String? messageId,
    $core.String? role,
  }) {
    final result = create();
    if (threadId != null) result.threadId = threadId;
    if (runId != null) result.runId = runId;
    if (messageId != null) result.messageId = messageId;
    if (role != null) result.role = role;
    return result;
  }

  TextMessageStart._();

  factory TextMessageStart.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TextMessageStart.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TextMessageStart',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'threadId')
    ..aOS(2, _omitFieldNames ? '' : 'runId')
    ..aOS(3, _omitFieldNames ? '' : 'messageId')
    ..aOS(4, _omitFieldNames ? '' : 'role')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextMessageStart clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextMessageStart copyWith(void Function(TextMessageStart) updates) =>
      super.copyWith((message) => updates(message as TextMessageStart))
          as TextMessageStart;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TextMessageStart create() => TextMessageStart._();
  @$core.override
  TextMessageStart createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TextMessageStart getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TextMessageStart>(create);
  static TextMessageStart? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get threadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set threadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get runId => $_getSZ(1);
  @$pb.TagNumber(2)
  set runId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get messageId => $_getSZ(2);
  @$pb.TagNumber(3)
  set messageId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessageId() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessageId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get role => $_getSZ(3);
  @$pb.TagNumber(4)
  set role($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRole() => $_has(3);
  @$pb.TagNumber(4)
  void clearRole() => $_clearField(4);
}

class TextMessageContent extends $pb.GeneratedMessage {
  factory TextMessageContent({
    $core.String? threadId,
    $core.String? runId,
    $core.String? messageId,
    $core.String? delta,
  }) {
    final result = create();
    if (threadId != null) result.threadId = threadId;
    if (runId != null) result.runId = runId;
    if (messageId != null) result.messageId = messageId;
    if (delta != null) result.delta = delta;
    return result;
  }

  TextMessageContent._();

  factory TextMessageContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TextMessageContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TextMessageContent',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'threadId')
    ..aOS(2, _omitFieldNames ? '' : 'runId')
    ..aOS(3, _omitFieldNames ? '' : 'messageId')
    ..aOS(4, _omitFieldNames ? '' : 'delta')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextMessageContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextMessageContent copyWith(void Function(TextMessageContent) updates) =>
      super.copyWith((message) => updates(message as TextMessageContent))
          as TextMessageContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TextMessageContent create() => TextMessageContent._();
  @$core.override
  TextMessageContent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TextMessageContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TextMessageContent>(create);
  static TextMessageContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get threadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set threadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get runId => $_getSZ(1);
  @$pb.TagNumber(2)
  set runId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get messageId => $_getSZ(2);
  @$pb.TagNumber(3)
  set messageId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessageId() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessageId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get delta => $_getSZ(3);
  @$pb.TagNumber(4)
  set delta($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDelta() => $_has(3);
  @$pb.TagNumber(4)
  void clearDelta() => $_clearField(4);
}

class TextMessageEnd extends $pb.GeneratedMessage {
  factory TextMessageEnd({
    $core.String? threadId,
    $core.String? runId,
    $core.String? messageId,
  }) {
    final result = create();
    if (threadId != null) result.threadId = threadId;
    if (runId != null) result.runId = runId;
    if (messageId != null) result.messageId = messageId;
    return result;
  }

  TextMessageEnd._();

  factory TextMessageEnd.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TextMessageEnd.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TextMessageEnd',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'threadId')
    ..aOS(2, _omitFieldNames ? '' : 'runId')
    ..aOS(3, _omitFieldNames ? '' : 'messageId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextMessageEnd clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextMessageEnd copyWith(void Function(TextMessageEnd) updates) =>
      super.copyWith((message) => updates(message as TextMessageEnd))
          as TextMessageEnd;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TextMessageEnd create() => TextMessageEnd._();
  @$core.override
  TextMessageEnd createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TextMessageEnd getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TextMessageEnd>(create);
  static TextMessageEnd? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get threadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set threadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get runId => $_getSZ(1);
  @$pb.TagNumber(2)
  set runId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get messageId => $_getSZ(2);
  @$pb.TagNumber(3)
  set messageId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessageId() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessageId() => $_clearField(3);
}

class ToolCallStart extends $pb.GeneratedMessage {
  factory ToolCallStart({
    $core.String? threadId,
    $core.String? runId,
    $core.String? toolCallId,
    $core.String? name,
  }) {
    final result = create();
    if (threadId != null) result.threadId = threadId;
    if (runId != null) result.runId = runId;
    if (toolCallId != null) result.toolCallId = toolCallId;
    if (name != null) result.name = name;
    return result;
  }

  ToolCallStart._();

  factory ToolCallStart.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToolCallStart.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToolCallStart',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'threadId')
    ..aOS(2, _omitFieldNames ? '' : 'runId')
    ..aOS(3, _omitFieldNames ? '' : 'toolCallId')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToolCallStart clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToolCallStart copyWith(void Function(ToolCallStart) updates) =>
      super.copyWith((message) => updates(message as ToolCallStart))
          as ToolCallStart;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToolCallStart create() => ToolCallStart._();
  @$core.override
  ToolCallStart createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ToolCallStart getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToolCallStart>(create);
  static ToolCallStart? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get threadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set threadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get runId => $_getSZ(1);
  @$pb.TagNumber(2)
  set runId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toolCallId => $_getSZ(2);
  @$pb.TagNumber(3)
  set toolCallId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToolCallId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToolCallId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);
}

class ToolCallArgs extends $pb.GeneratedMessage {
  factory ToolCallArgs({
    $core.String? threadId,
    $core.String? runId,
    $core.String? toolCallId,
    $core.String? delta,
  }) {
    final result = create();
    if (threadId != null) result.threadId = threadId;
    if (runId != null) result.runId = runId;
    if (toolCallId != null) result.toolCallId = toolCallId;
    if (delta != null) result.delta = delta;
    return result;
  }

  ToolCallArgs._();

  factory ToolCallArgs.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToolCallArgs.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToolCallArgs',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'threadId')
    ..aOS(2, _omitFieldNames ? '' : 'runId')
    ..aOS(3, _omitFieldNames ? '' : 'toolCallId')
    ..aOS(4, _omitFieldNames ? '' : 'delta')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToolCallArgs clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToolCallArgs copyWith(void Function(ToolCallArgs) updates) =>
      super.copyWith((message) => updates(message as ToolCallArgs))
          as ToolCallArgs;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToolCallArgs create() => ToolCallArgs._();
  @$core.override
  ToolCallArgs createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ToolCallArgs getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToolCallArgs>(create);
  static ToolCallArgs? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get threadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set threadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get runId => $_getSZ(1);
  @$pb.TagNumber(2)
  set runId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toolCallId => $_getSZ(2);
  @$pb.TagNumber(3)
  set toolCallId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToolCallId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToolCallId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get delta => $_getSZ(3);
  @$pb.TagNumber(4)
  set delta($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDelta() => $_has(3);
  @$pb.TagNumber(4)
  void clearDelta() => $_clearField(4);
}

class ToolCallEnd extends $pb.GeneratedMessage {
  factory ToolCallEnd({
    $core.String? threadId,
    $core.String? runId,
    $core.String? toolCallId,
  }) {
    final result = create();
    if (threadId != null) result.threadId = threadId;
    if (runId != null) result.runId = runId;
    if (toolCallId != null) result.toolCallId = toolCallId;
    return result;
  }

  ToolCallEnd._();

  factory ToolCallEnd.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToolCallEnd.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToolCallEnd',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'threadId')
    ..aOS(2, _omitFieldNames ? '' : 'runId')
    ..aOS(3, _omitFieldNames ? '' : 'toolCallId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToolCallEnd clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToolCallEnd copyWith(void Function(ToolCallEnd) updates) =>
      super.copyWith((message) => updates(message as ToolCallEnd))
          as ToolCallEnd;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToolCallEnd create() => ToolCallEnd._();
  @$core.override
  ToolCallEnd createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ToolCallEnd getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToolCallEnd>(create);
  static ToolCallEnd? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get threadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set threadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get runId => $_getSZ(1);
  @$pb.TagNumber(2)
  set runId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toolCallId => $_getSZ(2);
  @$pb.TagNumber(3)
  set toolCallId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToolCallId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToolCallId() => $_clearField(3);
}

class StateDelta extends $pb.GeneratedMessage {
  factory StateDelta({
    $core.String? threadId,
    $core.String? runId,
    $0.Struct? delta,
    $1.ScoreSummary? scoreSummary,
  }) {
    final result = create();
    if (threadId != null) result.threadId = threadId;
    if (runId != null) result.runId = runId;
    if (delta != null) result.delta = delta;
    if (scoreSummary != null) result.scoreSummary = scoreSummary;
    return result;
  }

  StateDelta._();

  factory StateDelta.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StateDelta.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StateDelta',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'threadId')
    ..aOS(2, _omitFieldNames ? '' : 'runId')
    ..aOM<$0.Struct>(3, _omitFieldNames ? '' : 'delta',
        subBuilder: $0.Struct.create)
    ..aOM<$1.ScoreSummary>(4, _omitFieldNames ? '' : 'scoreSummary',
        subBuilder: $1.ScoreSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StateDelta clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StateDelta copyWith(void Function(StateDelta) updates) =>
      super.copyWith((message) => updates(message as StateDelta)) as StateDelta;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StateDelta create() => StateDelta._();
  @$core.override
  StateDelta createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StateDelta getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StateDelta>(create);
  static StateDelta? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get threadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set threadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasThreadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get runId => $_getSZ(1);
  @$pb.TagNumber(2)
  set runId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunId() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.Struct get delta => $_getN(2);
  @$pb.TagNumber(3)
  set delta($0.Struct value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDelta() => $_has(2);
  @$pb.TagNumber(3)
  void clearDelta() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Struct ensureDelta() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.ScoreSummary get scoreSummary => $_getN(3);
  @$pb.TagNumber(4)
  set scoreSummary($1.ScoreSummary value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasScoreSummary() => $_has(3);
  @$pb.TagNumber(4)
  void clearScoreSummary() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.ScoreSummary ensureScoreSummary() => $_ensure(3);
}

enum RunEvent_Event {
  runStarted,
  runFinished,
  runError,
  textMessageStart,
  textMessageContent,
  textMessageEnd,
  toolCallStart,
  toolCallArgs,
  toolCallEnd,
  stateDelta,
  notSet
}

class RunEvent extends $pb.GeneratedMessage {
  factory RunEvent({
    RunStarted? runStarted,
    RunFinished? runFinished,
    RunError? runError,
    TextMessageStart? textMessageStart,
    TextMessageContent? textMessageContent,
    TextMessageEnd? textMessageEnd,
    ToolCallStart? toolCallStart,
    ToolCallArgs? toolCallArgs,
    ToolCallEnd? toolCallEnd,
    StateDelta? stateDelta,
  }) {
    final result = create();
    if (runStarted != null) result.runStarted = runStarted;
    if (runFinished != null) result.runFinished = runFinished;
    if (runError != null) result.runError = runError;
    if (textMessageStart != null) result.textMessageStart = textMessageStart;
    if (textMessageContent != null)
      result.textMessageContent = textMessageContent;
    if (textMessageEnd != null) result.textMessageEnd = textMessageEnd;
    if (toolCallStart != null) result.toolCallStart = toolCallStart;
    if (toolCallArgs != null) result.toolCallArgs = toolCallArgs;
    if (toolCallEnd != null) result.toolCallEnd = toolCallEnd;
    if (stateDelta != null) result.stateDelta = stateDelta;
    return result;
  }

  RunEvent._();

  factory RunEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RunEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, RunEvent_Event> _RunEvent_EventByTag = {
    1: RunEvent_Event.runStarted,
    2: RunEvent_Event.runFinished,
    3: RunEvent_Event.runError,
    4: RunEvent_Event.textMessageStart,
    5: RunEvent_Event.textMessageContent,
    6: RunEvent_Event.textMessageEnd,
    7: RunEvent_Event.toolCallStart,
    8: RunEvent_Event.toolCallArgs,
    9: RunEvent_Event.toolCallEnd,
    10: RunEvent_Event.stateDelta,
    0: RunEvent_Event.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RunEvent',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'primerpeso.agent.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    ..aOM<RunStarted>(1, _omitFieldNames ? '' : 'runStarted',
        subBuilder: RunStarted.create)
    ..aOM<RunFinished>(2, _omitFieldNames ? '' : 'runFinished',
        subBuilder: RunFinished.create)
    ..aOM<RunError>(3, _omitFieldNames ? '' : 'runError',
        subBuilder: RunError.create)
    ..aOM<TextMessageStart>(4, _omitFieldNames ? '' : 'textMessageStart',
        subBuilder: TextMessageStart.create)
    ..aOM<TextMessageContent>(5, _omitFieldNames ? '' : 'textMessageContent',
        subBuilder: TextMessageContent.create)
    ..aOM<TextMessageEnd>(6, _omitFieldNames ? '' : 'textMessageEnd',
        subBuilder: TextMessageEnd.create)
    ..aOM<ToolCallStart>(7, _omitFieldNames ? '' : 'toolCallStart',
        subBuilder: ToolCallStart.create)
    ..aOM<ToolCallArgs>(8, _omitFieldNames ? '' : 'toolCallArgs',
        subBuilder: ToolCallArgs.create)
    ..aOM<ToolCallEnd>(9, _omitFieldNames ? '' : 'toolCallEnd',
        subBuilder: ToolCallEnd.create)
    ..aOM<StateDelta>(10, _omitFieldNames ? '' : 'stateDelta',
        subBuilder: StateDelta.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunEvent copyWith(void Function(RunEvent) updates) =>
      super.copyWith((message) => updates(message as RunEvent)) as RunEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunEvent create() => RunEvent._();
  @$core.override
  RunEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RunEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RunEvent>(create);
  static RunEvent? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  RunEvent_Event whichEvent() => _RunEvent_EventByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  void clearEvent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  RunStarted get runStarted => $_getN(0);
  @$pb.TagNumber(1)
  set runStarted(RunStarted value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRunStarted() => $_has(0);
  @$pb.TagNumber(1)
  void clearRunStarted() => $_clearField(1);
  @$pb.TagNumber(1)
  RunStarted ensureRunStarted() => $_ensure(0);

  @$pb.TagNumber(2)
  RunFinished get runFinished => $_getN(1);
  @$pb.TagNumber(2)
  set runFinished(RunFinished value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRunFinished() => $_has(1);
  @$pb.TagNumber(2)
  void clearRunFinished() => $_clearField(2);
  @$pb.TagNumber(2)
  RunFinished ensureRunFinished() => $_ensure(1);

  @$pb.TagNumber(3)
  RunError get runError => $_getN(2);
  @$pb.TagNumber(3)
  set runError(RunError value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRunError() => $_has(2);
  @$pb.TagNumber(3)
  void clearRunError() => $_clearField(3);
  @$pb.TagNumber(3)
  RunError ensureRunError() => $_ensure(2);

  @$pb.TagNumber(4)
  TextMessageStart get textMessageStart => $_getN(3);
  @$pb.TagNumber(4)
  set textMessageStart(TextMessageStart value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTextMessageStart() => $_has(3);
  @$pb.TagNumber(4)
  void clearTextMessageStart() => $_clearField(4);
  @$pb.TagNumber(4)
  TextMessageStart ensureTextMessageStart() => $_ensure(3);

  @$pb.TagNumber(5)
  TextMessageContent get textMessageContent => $_getN(4);
  @$pb.TagNumber(5)
  set textMessageContent(TextMessageContent value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTextMessageContent() => $_has(4);
  @$pb.TagNumber(5)
  void clearTextMessageContent() => $_clearField(5);
  @$pb.TagNumber(5)
  TextMessageContent ensureTextMessageContent() => $_ensure(4);

  @$pb.TagNumber(6)
  TextMessageEnd get textMessageEnd => $_getN(5);
  @$pb.TagNumber(6)
  set textMessageEnd(TextMessageEnd value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasTextMessageEnd() => $_has(5);
  @$pb.TagNumber(6)
  void clearTextMessageEnd() => $_clearField(6);
  @$pb.TagNumber(6)
  TextMessageEnd ensureTextMessageEnd() => $_ensure(5);

  @$pb.TagNumber(7)
  ToolCallStart get toolCallStart => $_getN(6);
  @$pb.TagNumber(7)
  set toolCallStart(ToolCallStart value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasToolCallStart() => $_has(6);
  @$pb.TagNumber(7)
  void clearToolCallStart() => $_clearField(7);
  @$pb.TagNumber(7)
  ToolCallStart ensureToolCallStart() => $_ensure(6);

  @$pb.TagNumber(8)
  ToolCallArgs get toolCallArgs => $_getN(7);
  @$pb.TagNumber(8)
  set toolCallArgs(ToolCallArgs value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasToolCallArgs() => $_has(7);
  @$pb.TagNumber(8)
  void clearToolCallArgs() => $_clearField(8);
  @$pb.TagNumber(8)
  ToolCallArgs ensureToolCallArgs() => $_ensure(7);

  @$pb.TagNumber(9)
  ToolCallEnd get toolCallEnd => $_getN(8);
  @$pb.TagNumber(9)
  set toolCallEnd(ToolCallEnd value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasToolCallEnd() => $_has(8);
  @$pb.TagNumber(9)
  void clearToolCallEnd() => $_clearField(9);
  @$pb.TagNumber(9)
  ToolCallEnd ensureToolCallEnd() => $_ensure(8);

  @$pb.TagNumber(10)
  StateDelta get stateDelta => $_getN(9);
  @$pb.TagNumber(10)
  set stateDelta(StateDelta value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStateDelta() => $_has(9);
  @$pb.TagNumber(10)
  void clearStateDelta() => $_clearField(10);
  @$pb.TagNumber(10)
  StateDelta ensureStateDelta() => $_ensure(9);
}

class AgentServiceApi {
  final $pb.RpcClient _client;

  AgentServiceApi(this._client);

  $async.Future<RunEvent> run($pb.ClientContext? ctx, RunRequest request) =>
      _client.invoke<RunEvent>(ctx, 'AgentService', 'Run', request, RunEvent());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
