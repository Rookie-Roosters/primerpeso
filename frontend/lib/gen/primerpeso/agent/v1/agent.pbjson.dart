// This is a generated file - do not edit.
//
// Generated from primerpeso/agent/v1/agent.proto.

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

import 'package:protobuf/well_known_types/google/protobuf/struct.pbjson.dart'
    as $0;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pbjson.dart'
    as $2;

import '../../finance/v1/finance.pbjson.dart' as $1;

@$core.Deprecated('Use chatMessageDescriptor instead')
const ChatMessage$json = {
  '1': 'ChatMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `ChatMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMessageDescriptor = $convert.base64Decode(
    'CgtDaGF0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSEgoEcm9sZRgCIAEoCVIEcm9sZRIYCgdjb2'
    '50ZW50GAMgASgJUgdjb250ZW50');

@$core.Deprecated('Use toolDefinitionDescriptor instead')
const ToolDefinition$json = {
  '1': 'ToolDefinition',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'parameters',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'parameters'
    },
  ],
};

/// Descriptor for `ToolDefinition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toolDefinitionDescriptor = $convert.base64Decode(
    'Cg5Ub29sRGVmaW5pdGlvbhISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAIgAS'
    'gJUgtkZXNjcmlwdGlvbhI3CgpwYXJhbWV0ZXJzGAMgASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0'
    'cnVjdFIKcGFyYW1ldGVycw==');

@$core.Deprecated('Use runRequestDescriptor instead')
const RunRequest$json = {
  '1': 'RunRequest',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'run_id', '3': 2, '4': 1, '5': 9, '10': 'runId'},
    {
      '1': 'messages',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.primerpeso.agent.v1.ChatMessage',
      '10': 'messages'
    },
    {
      '1': 'state',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'state'
    },
    {
      '1': 'tools',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.primerpeso.agent.v1.ToolDefinition',
      '10': 'tools'
    },
  ],
};

/// Descriptor for `RunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runRequestDescriptor = $convert.base64Decode(
    'CgpSdW5SZXF1ZXN0EhsKCXRocmVhZF9pZBgBIAEoCVIIdGhyZWFkSWQSFQoGcnVuX2lkGAIgAS'
    'gJUgVydW5JZBI8CghtZXNzYWdlcxgDIAMoCzIgLnByaW1lcnBlc28uYWdlbnQudjEuQ2hhdE1l'
    'c3NhZ2VSCG1lc3NhZ2VzEi0KBXN0YXRlGAQgASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cnVjdF'
    'IFc3RhdGUSOQoFdG9vbHMYBSADKAsyIy5wcmltZXJwZXNvLmFnZW50LnYxLlRvb2xEZWZpbml0'
    'aW9uUgV0b29scw==');

@$core.Deprecated('Use runStartedDescriptor instead')
const RunStarted$json = {
  '1': 'RunStarted',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'run_id', '3': 2, '4': 1, '5': 9, '10': 'runId'},
  ],
};

/// Descriptor for `RunStarted`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runStartedDescriptor = $convert.base64Decode(
    'CgpSdW5TdGFydGVkEhsKCXRocmVhZF9pZBgBIAEoCVIIdGhyZWFkSWQSFQoGcnVuX2lkGAIgAS'
    'gJUgVydW5JZA==');

@$core.Deprecated('Use runFinishedDescriptor instead')
const RunFinished$json = {
  '1': 'RunFinished',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'run_id', '3': 2, '4': 1, '5': 9, '10': 'runId'},
  ],
};

/// Descriptor for `RunFinished`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runFinishedDescriptor = $convert.base64Decode(
    'CgtSdW5GaW5pc2hlZBIbCgl0aHJlYWRfaWQYASABKAlSCHRocmVhZElkEhUKBnJ1bl9pZBgCIA'
    'EoCVIFcnVuSWQ=');

@$core.Deprecated('Use runErrorDescriptor instead')
const RunError$json = {
  '1': 'RunError',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'run_id', '3': 2, '4': 1, '5': 9, '10': 'runId'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'code', '3': 4, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `RunError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runErrorDescriptor = $convert.base64Decode(
    'CghSdW5FcnJvchIbCgl0aHJlYWRfaWQYASABKAlSCHRocmVhZElkEhUKBnJ1bl9pZBgCIAEoCV'
    'IFcnVuSWQSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZRISCgRjb2RlGAQgASgJUgRjb2Rl');

@$core.Deprecated('Use textMessageStartDescriptor instead')
const TextMessageStart$json = {
  '1': 'TextMessageStart',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'run_id', '3': 2, '4': 1, '5': 9, '10': 'runId'},
    {'1': 'message_id', '3': 3, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'role', '3': 4, '4': 1, '5': 9, '10': 'role'},
  ],
};

/// Descriptor for `TextMessageStart`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textMessageStartDescriptor = $convert.base64Decode(
    'ChBUZXh0TWVzc2FnZVN0YXJ0EhsKCXRocmVhZF9pZBgBIAEoCVIIdGhyZWFkSWQSFQoGcnVuX2'
    'lkGAIgASgJUgVydW5JZBIdCgptZXNzYWdlX2lkGAMgASgJUgltZXNzYWdlSWQSEgoEcm9sZRgE'
    'IAEoCVIEcm9sZQ==');

@$core.Deprecated('Use textMessageContentDescriptor instead')
const TextMessageContent$json = {
  '1': 'TextMessageContent',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'run_id', '3': 2, '4': 1, '5': 9, '10': 'runId'},
    {'1': 'message_id', '3': 3, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'delta', '3': 4, '4': 1, '5': 9, '10': 'delta'},
  ],
};

/// Descriptor for `TextMessageContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textMessageContentDescriptor = $convert.base64Decode(
    'ChJUZXh0TWVzc2FnZUNvbnRlbnQSGwoJdGhyZWFkX2lkGAEgASgJUgh0aHJlYWRJZBIVCgZydW'
    '5faWQYAiABKAlSBXJ1bklkEh0KCm1lc3NhZ2VfaWQYAyABKAlSCW1lc3NhZ2VJZBIUCgVkZWx0'
    'YRgEIAEoCVIFZGVsdGE=');

@$core.Deprecated('Use textMessageEndDescriptor instead')
const TextMessageEnd$json = {
  '1': 'TextMessageEnd',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'run_id', '3': 2, '4': 1, '5': 9, '10': 'runId'},
    {'1': 'message_id', '3': 3, '4': 1, '5': 9, '10': 'messageId'},
  ],
};

/// Descriptor for `TextMessageEnd`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textMessageEndDescriptor = $convert.base64Decode(
    'Cg5UZXh0TWVzc2FnZUVuZBIbCgl0aHJlYWRfaWQYASABKAlSCHRocmVhZElkEhUKBnJ1bl9pZB'
    'gCIAEoCVIFcnVuSWQSHQoKbWVzc2FnZV9pZBgDIAEoCVIJbWVzc2FnZUlk');

@$core.Deprecated('Use toolCallStartDescriptor instead')
const ToolCallStart$json = {
  '1': 'ToolCallStart',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'run_id', '3': 2, '4': 1, '5': 9, '10': 'runId'},
    {'1': 'tool_call_id', '3': 3, '4': 1, '5': 9, '10': 'toolCallId'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `ToolCallStart`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toolCallStartDescriptor = $convert.base64Decode(
    'Cg1Ub29sQ2FsbFN0YXJ0EhsKCXRocmVhZF9pZBgBIAEoCVIIdGhyZWFkSWQSFQoGcnVuX2lkGA'
    'IgASgJUgVydW5JZBIgCgx0b29sX2NhbGxfaWQYAyABKAlSCnRvb2xDYWxsSWQSEgoEbmFtZRgE'
    'IAEoCVIEbmFtZQ==');

@$core.Deprecated('Use toolCallArgsDescriptor instead')
const ToolCallArgs$json = {
  '1': 'ToolCallArgs',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'run_id', '3': 2, '4': 1, '5': 9, '10': 'runId'},
    {'1': 'tool_call_id', '3': 3, '4': 1, '5': 9, '10': 'toolCallId'},
    {'1': 'delta', '3': 4, '4': 1, '5': 9, '10': 'delta'},
  ],
};

/// Descriptor for `ToolCallArgs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toolCallArgsDescriptor = $convert.base64Decode(
    'CgxUb29sQ2FsbEFyZ3MSGwoJdGhyZWFkX2lkGAEgASgJUgh0aHJlYWRJZBIVCgZydW5faWQYAi'
    'ABKAlSBXJ1bklkEiAKDHRvb2xfY2FsbF9pZBgDIAEoCVIKdG9vbENhbGxJZBIUCgVkZWx0YRgE'
    'IAEoCVIFZGVsdGE=');

@$core.Deprecated('Use toolCallEndDescriptor instead')
const ToolCallEnd$json = {
  '1': 'ToolCallEnd',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'run_id', '3': 2, '4': 1, '5': 9, '10': 'runId'},
    {'1': 'tool_call_id', '3': 3, '4': 1, '5': 9, '10': 'toolCallId'},
  ],
};

/// Descriptor for `ToolCallEnd`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toolCallEndDescriptor = $convert.base64Decode(
    'CgtUb29sQ2FsbEVuZBIbCgl0aHJlYWRfaWQYASABKAlSCHRocmVhZElkEhUKBnJ1bl9pZBgCIA'
    'EoCVIFcnVuSWQSIAoMdG9vbF9jYWxsX2lkGAMgASgJUgp0b29sQ2FsbElk');

@$core.Deprecated('Use stateDeltaDescriptor instead')
const StateDelta$json = {
  '1': 'StateDelta',
  '2': [
    {'1': 'thread_id', '3': 1, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'run_id', '3': 2, '4': 1, '5': 9, '10': 'runId'},
    {
      '1': 'delta',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'delta'
    },
    {
      '1': 'score_summary',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.ScoreSummary',
      '10': 'scoreSummary'
    },
  ],
};

/// Descriptor for `StateDelta`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stateDeltaDescriptor = $convert.base64Decode(
    'CgpTdGF0ZURlbHRhEhsKCXRocmVhZF9pZBgBIAEoCVIIdGhyZWFkSWQSFQoGcnVuX2lkGAIgAS'
    'gJUgVydW5JZBItCgVkZWx0YRgDIAEoCzIXLmdvb2dsZS5wcm90b2J1Zi5TdHJ1Y3RSBWRlbHRh'
    'EkgKDXNjb3JlX3N1bW1hcnkYBCABKAsyIy5wcmltZXJwZXNvLmZpbmFuY2UudjEuU2NvcmVTdW'
    '1tYXJ5UgxzY29yZVN1bW1hcnk=');

@$core.Deprecated('Use runEventDescriptor instead')
const RunEvent$json = {
  '1': 'RunEvent',
  '2': [
    {
      '1': 'run_started',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.agent.v1.RunStarted',
      '9': 0,
      '10': 'runStarted'
    },
    {
      '1': 'run_finished',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.agent.v1.RunFinished',
      '9': 0,
      '10': 'runFinished'
    },
    {
      '1': 'run_error',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.agent.v1.RunError',
      '9': 0,
      '10': 'runError'
    },
    {
      '1': 'text_message_start',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.agent.v1.TextMessageStart',
      '9': 0,
      '10': 'textMessageStart'
    },
    {
      '1': 'text_message_content',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.agent.v1.TextMessageContent',
      '9': 0,
      '10': 'textMessageContent'
    },
    {
      '1': 'text_message_end',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.agent.v1.TextMessageEnd',
      '9': 0,
      '10': 'textMessageEnd'
    },
    {
      '1': 'tool_call_start',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.agent.v1.ToolCallStart',
      '9': 0,
      '10': 'toolCallStart'
    },
    {
      '1': 'tool_call_args',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.agent.v1.ToolCallArgs',
      '9': 0,
      '10': 'toolCallArgs'
    },
    {
      '1': 'tool_call_end',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.agent.v1.ToolCallEnd',
      '9': 0,
      '10': 'toolCallEnd'
    },
    {
      '1': 'state_delta',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.agent.v1.StateDelta',
      '9': 0,
      '10': 'stateDelta'
    },
  ],
  '8': [
    {'1': 'event'},
  ],
};

/// Descriptor for `RunEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runEventDescriptor = $convert.base64Decode(
    'CghSdW5FdmVudBJCCgtydW5fc3RhcnRlZBgBIAEoCzIfLnByaW1lcnBlc28uYWdlbnQudjEuUn'
    'VuU3RhcnRlZEgAUgpydW5TdGFydGVkEkUKDHJ1bl9maW5pc2hlZBgCIAEoCzIgLnByaW1lcnBl'
    'c28uYWdlbnQudjEuUnVuRmluaXNoZWRIAFILcnVuRmluaXNoZWQSPAoJcnVuX2Vycm9yGAMgAS'
    'gLMh0ucHJpbWVycGVzby5hZ2VudC52MS5SdW5FcnJvckgAUghydW5FcnJvchJVChJ0ZXh0X21l'
    'c3NhZ2Vfc3RhcnQYBCABKAsyJS5wcmltZXJwZXNvLmFnZW50LnYxLlRleHRNZXNzYWdlU3Rhcn'
    'RIAFIQdGV4dE1lc3NhZ2VTdGFydBJbChR0ZXh0X21lc3NhZ2VfY29udGVudBgFIAEoCzInLnBy'
    'aW1lcnBlc28uYWdlbnQudjEuVGV4dE1lc3NhZ2VDb250ZW50SABSEnRleHRNZXNzYWdlQ29udG'
    'VudBJPChB0ZXh0X21lc3NhZ2VfZW5kGAYgASgLMiMucHJpbWVycGVzby5hZ2VudC52MS5UZXh0'
    'TWVzc2FnZUVuZEgAUg50ZXh0TWVzc2FnZUVuZBJMCg90b29sX2NhbGxfc3RhcnQYByABKAsyIi'
    '5wcmltZXJwZXNvLmFnZW50LnYxLlRvb2xDYWxsU3RhcnRIAFINdG9vbENhbGxTdGFydBJJCg50'
    'b29sX2NhbGxfYXJncxgIIAEoCzIhLnByaW1lcnBlc28uYWdlbnQudjEuVG9vbENhbGxBcmdzSA'
    'BSDHRvb2xDYWxsQXJncxJGCg10b29sX2NhbGxfZW5kGAkgASgLMiAucHJpbWVycGVzby5hZ2Vu'
    'dC52MS5Ub29sQ2FsbEVuZEgAUgt0b29sQ2FsbEVuZBJCCgtzdGF0ZV9kZWx0YRgKIAEoCzIfLn'
    'ByaW1lcnBlc28uYWdlbnQudjEuU3RhdGVEZWx0YUgAUgpzdGF0ZURlbHRhQgcKBWV2ZW50');

const $core.Map<$core.String, $core.dynamic> AgentServiceBase$json = {
  '1': 'AgentService',
  '2': [
    {
      '1': 'Run',
      '2': '.primerpeso.agent.v1.RunRequest',
      '3': '.primerpeso.agent.v1.RunEvent',
      '6': true
    },
  ],
};

@$core.Deprecated('Use agentServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    AgentServiceBase$messageJson = {
  '.primerpeso.agent.v1.RunRequest': RunRequest$json,
  '.primerpeso.agent.v1.ChatMessage': ChatMessage$json,
  '.google.protobuf.Struct': $0.Struct$json,
  '.google.protobuf.Struct.FieldsEntry': $0.Struct_FieldsEntry$json,
  '.google.protobuf.Value': $0.Value$json,
  '.google.protobuf.ListValue': $0.ListValue$json,
  '.primerpeso.agent.v1.ToolDefinition': ToolDefinition$json,
  '.primerpeso.agent.v1.RunEvent': RunEvent$json,
  '.primerpeso.agent.v1.RunStarted': RunStarted$json,
  '.primerpeso.agent.v1.RunFinished': RunFinished$json,
  '.primerpeso.agent.v1.RunError': RunError$json,
  '.primerpeso.agent.v1.TextMessageStart': TextMessageStart$json,
  '.primerpeso.agent.v1.TextMessageContent': TextMessageContent$json,
  '.primerpeso.agent.v1.TextMessageEnd': TextMessageEnd$json,
  '.primerpeso.agent.v1.ToolCallStart': ToolCallStart$json,
  '.primerpeso.agent.v1.ToolCallArgs': ToolCallArgs$json,
  '.primerpeso.agent.v1.ToolCallEnd': ToolCallEnd$json,
  '.primerpeso.agent.v1.StateDelta': StateDelta$json,
  '.primerpeso.finance.v1.ScoreSummary': $1.ScoreSummary$json,
  '.primerpeso.finance.v1.ScoreFactor': $1.ScoreFactor$json,
  '.google.protobuf.Timestamp': $2.Timestamp$json,
};

/// Descriptor for `AgentService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List agentServiceDescriptor = $convert.base64Decode(
    'CgxBZ2VudFNlcnZpY2USRwoDUnVuEh8ucHJpbWVycGVzby5hZ2VudC52MS5SdW5SZXF1ZXN0Gh'
    '0ucHJpbWVycGVzby5hZ2VudC52MS5SdW5FdmVudDAB');
