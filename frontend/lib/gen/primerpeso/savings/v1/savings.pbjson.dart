// This is a generated file - do not edit.
//
// Generated from primerpeso/savings/v1/savings.proto.

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
    as $1;

import '../../finance/v1/finance.pbjson.dart' as $0;

@$core.Deprecated('Use recurrenceFrequencyDescriptor instead')
const RecurrenceFrequency$json = {
  '1': 'RecurrenceFrequency',
  '2': [
    {'1': 'RECURRENCE_FREQUENCY_UNSPECIFIED', '2': 0},
    {'1': 'RECURRENCE_FREQUENCY_DAILY', '2': 1},
    {'1': 'RECURRENCE_FREQUENCY_WEEKLY', '2': 2},
    {'1': 'RECURRENCE_FREQUENCY_MONTHLY', '2': 3},
    {'1': 'RECURRENCE_FREQUENCY_YEARLY', '2': 4},
  ],
};

/// Descriptor for `RecurrenceFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List recurrenceFrequencyDescriptor = $convert.base64Decode(
    'ChNSZWN1cnJlbmNlRnJlcXVlbmN5EiQKIFJFQ1VSUkVOQ0VfRlJFUVVFTkNZX1VOU1BFQ0lGSU'
    'VEEAASHgoaUkVDVVJSRU5DRV9GUkVRVUVOQ1lfREFJTFkQARIfChtSRUNVUlJFTkNFX0ZSRVFV'
    'RU5DWV9XRUVLTFkQAhIgChxSRUNVUlJFTkNFX0ZSRVFVRU5DWV9NT05USExZEAMSHwobUkVDVV'
    'JSRU5DRV9GUkVRVUVOQ1lfWUVBUkxZEAQ=');

@$core.Deprecated('Use apartadoDescriptor instead')
const Apartado$json = {
  '1': 'Apartado',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'current_amount',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'currentAmount'
    },
    {
      '1': 'target_amount',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'targetAmount'
    },
    {
      '1': 'financial_goal_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'financialGoalId',
      '17': true
    },
    {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
    {
      '1': 'created_at',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
  '8': [
    {'1': '_financial_goal_id'},
  ],
};

/// Descriptor for `Apartado`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List apartadoDescriptor = $convert.base64Decode(
    'CghBcGFydGFkbxIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZXNjcm'
    'lwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SQwoOY3VycmVudF9hbW91bnQYBCABKAsyHC5wcmlt'
    'ZXJwZXNvLmZpbmFuY2UudjEuTW9uZXlSDWN1cnJlbnRBbW91bnQSQQoNdGFyZ2V0X2Ftb3VudB'
    'gFIAEoCzIcLnByaW1lcnBlc28uZmluYW5jZS52MS5Nb25leVIMdGFyZ2V0QW1vdW50Ei8KEWZp'
    'bmFuY2lhbF9nb2FsX2lkGAYgASgJSABSD2ZpbmFuY2lhbEdvYWxJZIgBARIbCglpc19hY3Rpdm'
    'UYByABKAhSCGlzQWN0aXZlEjkKCmNyZWF0ZWRfYXQYCCABKAsyGi5nb29nbGUucHJvdG9idWYu'
    'VGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2'
    'J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdEIUChJfZmluYW5jaWFsX2dvYWxfaWQ=');

@$core.Deprecated('Use financialGoalDescriptor instead')
const FinancialGoal$json = {
  '1': 'FinancialGoal',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'target_amount',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'targetAmount'
    },
    {
      '1': 'current_amount',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'currentAmount'
    },
    {
      '1': 'target_date',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'targetDate'
    },
    {'1': 'is_active', '3': 7, '4': 1, '5': 8, '10': 'isActive'},
    {
      '1': 'created_at',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `FinancialGoal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List financialGoalDescriptor = $convert.base64Decode(
    'Cg1GaW5hbmNpYWxHb2FsEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2'
    'Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhJBCg10YXJnZXRfYW1vdW50GAQgASgLMhwu'
    'cHJpbWVycGVzby5maW5hbmNlLnYxLk1vbmV5Ugx0YXJnZXRBbW91bnQSQwoOY3VycmVudF9hbW'
    '91bnQYBSABKAsyHC5wcmltZXJwZXNvLmZpbmFuY2UudjEuTW9uZXlSDWN1cnJlbnRBbW91bnQS'
    'OwoLdGFyZ2V0X2RhdGUYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgp0YXJnZX'
    'REYXRlEhsKCWlzX2FjdGl2ZRgHIAEoCFIIaXNBY3RpdmUSOQoKY3JlYXRlZF9hdBgIIAEoCzIa'
    'Lmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GAkgAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');

@$core.Deprecated('Use recurringPaymentReminderDescriptor instead')
const RecurringPaymentReminder$json = {
  '1': 'RecurringPaymentReminder',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'payee', '3': 3, '4': 1, '5': 9, '10': 'payee'},
    {
      '1': 'amount',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'amount'
    },
    {
      '1': 'frequency',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.primerpeso.savings.v1.RecurrenceFrequency',
      '10': 'frequency'
    },
    {'1': 'interval', '3': 6, '4': 1, '5': 5, '10': 'interval'},
    {
      '1': 'day_of_week',
      '3': 7,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'dayOfWeek',
      '17': true
    },
    {
      '1': 'day_of_month',
      '3': 8,
      '4': 1,
      '5': 5,
      '9': 1,
      '10': 'dayOfMonth',
      '17': true
    },
    {
      '1': 'month_of_year',
      '3': 9,
      '4': 1,
      '5': 5,
      '9': 2,
      '10': 'monthOfYear',
      '17': true
    },
    {'1': 'local_time', '3': 10, '4': 1, '5': 9, '10': 'localTime'},
    {'1': 'timezone', '3': 11, '4': 1, '5': 9, '10': 'timezone'},
    {
      '1': 'next_due_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'nextDueAt'
    },
    {'1': 'is_active', '3': 13, '4': 1, '5': 8, '10': 'isActive'},
    {
      '1': 'created_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
  '8': [
    {'1': '_day_of_week'},
    {'1': '_day_of_month'},
    {'1': '_month_of_year'},
  ],
};

/// Descriptor for `RecurringPaymentReminder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recurringPaymentReminderDescriptor = $convert.base64Decode(
    'ChhSZWN1cnJpbmdQYXltZW50UmVtaW5kZXISDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgAS'
    'gJUgV0aXRsZRIUCgVwYXllZRgDIAEoCVIFcGF5ZWUSNAoGYW1vdW50GAQgASgLMhwucHJpbWVy'
    'cGVzby5maW5hbmNlLnYxLk1vbmV5UgZhbW91bnQSSAoJZnJlcXVlbmN5GAUgASgOMioucHJpbW'
    'VycGVzby5zYXZpbmdzLnYxLlJlY3VycmVuY2VGcmVxdWVuY3lSCWZyZXF1ZW5jeRIaCghpbnRl'
    'cnZhbBgGIAEoBVIIaW50ZXJ2YWwSIwoLZGF5X29mX3dlZWsYByABKAVIAFIJZGF5T2ZXZWVriA'
    'EBEiUKDGRheV9vZl9tb250aBgIIAEoBUgBUgpkYXlPZk1vbnRoiAEBEicKDW1vbnRoX29mX3ll'
    'YXIYCSABKAVIAlILbW9udGhPZlllYXKIAQESHQoKbG9jYWxfdGltZRgKIAEoCVIJbG9jYWxUaW'
    '1lEhoKCHRpbWV6b25lGAsgASgJUgh0aW1lem9uZRI6CgtuZXh0X2R1ZV9hdBgMIAEoCzIaLmdv'
    'b2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCW5leHREdWVBdBIbCglpc19hY3RpdmUYDSABKAhSCG'
    'lzQWN0aXZlEjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1w'
    'UgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSCXVwZGF0ZWRBdEIOCgxfZGF5X29mX3dlZWtCDwoNX2RheV9vZl9tb250aEIQCg5fbW9u'
    'dGhfb2ZfeWVhcg==');

@$core.Deprecated('Use createApartadoRequestDescriptor instead')
const CreateApartadoRequest$json = {
  '1': 'CreateApartadoRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'current_amount',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'currentAmount'
    },
    {
      '1': 'target_amount',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'targetAmount'
    },
    {
      '1': 'financial_goal_id',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'financialGoalId',
      '17': true
    },
  ],
  '8': [
    {'1': '_financial_goal_id'},
  ],
};

/// Descriptor for `CreateApartadoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createApartadoRequestDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVBcGFydGFkb1JlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIgCgtkZXNjcmlwdG'
    'lvbhgCIAEoCVILZGVzY3JpcHRpb24SQwoOY3VycmVudF9hbW91bnQYAyABKAsyHC5wcmltZXJw'
    'ZXNvLmZpbmFuY2UudjEuTW9uZXlSDWN1cnJlbnRBbW91bnQSQQoNdGFyZ2V0X2Ftb3VudBgEIA'
    'EoCzIcLnByaW1lcnBlc28uZmluYW5jZS52MS5Nb25leVIMdGFyZ2V0QW1vdW50Ei8KEWZpbmFu'
    'Y2lhbF9nb2FsX2lkGAUgASgJSABSD2ZpbmFuY2lhbEdvYWxJZIgBAUIUChJfZmluYW5jaWFsX2'
    'dvYWxfaWQ=');

@$core.Deprecated('Use createApartadoResponseDescriptor instead')
const CreateApartadoResponse$json = {
  '1': 'CreateApartadoResponse',
  '2': [
    {
      '1': 'apartado',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.Apartado',
      '10': 'apartado'
    },
  ],
};

/// Descriptor for `CreateApartadoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createApartadoResponseDescriptor =
    $convert.base64Decode(
        'ChZDcmVhdGVBcGFydGFkb1Jlc3BvbnNlEjsKCGFwYXJ0YWRvGAEgASgLMh8ucHJpbWVycGVzby'
        '5zYXZpbmdzLnYxLkFwYXJ0YWRvUghhcGFydGFkbw==');

@$core.Deprecated('Use getApartadoRequestDescriptor instead')
const GetApartadoRequest$json = {
  '1': 'GetApartadoRequest',
  '2': [
    {'1': 'apartado_id', '3': 1, '4': 1, '5': 9, '10': 'apartadoId'},
  ],
};

/// Descriptor for `GetApartadoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getApartadoRequestDescriptor = $convert.base64Decode(
    'ChJHZXRBcGFydGFkb1JlcXVlc3QSHwoLYXBhcnRhZG9faWQYASABKAlSCmFwYXJ0YWRvSWQ=');

@$core.Deprecated('Use getApartadoResponseDescriptor instead')
const GetApartadoResponse$json = {
  '1': 'GetApartadoResponse',
  '2': [
    {
      '1': 'apartado',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.Apartado',
      '10': 'apartado'
    },
  ],
};

/// Descriptor for `GetApartadoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getApartadoResponseDescriptor = $convert.base64Decode(
    'ChNHZXRBcGFydGFkb1Jlc3BvbnNlEjsKCGFwYXJ0YWRvGAEgASgLMh8ucHJpbWVycGVzby5zYX'
    'ZpbmdzLnYxLkFwYXJ0YWRvUghhcGFydGFkbw==');

@$core.Deprecated('Use listApartadosRequestDescriptor instead')
const ListApartadosRequest$json = {
  '1': 'ListApartadosRequest',
  '2': [
    {'1': 'page_size', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListApartadosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listApartadosRequestDescriptor =
    $convert.base64Decode(
        'ChRMaXN0QXBhcnRhZG9zUmVxdWVzdBIbCglwYWdlX3NpemUYASABKAVSCHBhZ2VTaXpl');

@$core.Deprecated('Use listApartadosResponseDescriptor instead')
const ListApartadosResponse$json = {
  '1': 'ListApartadosResponse',
  '2': [
    {
      '1': 'apartados',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.primerpeso.savings.v1.Apartado',
      '10': 'apartados'
    },
  ],
};

/// Descriptor for `ListApartadosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listApartadosResponseDescriptor = $convert.base64Decode(
    'ChVMaXN0QXBhcnRhZG9zUmVzcG9uc2USPQoJYXBhcnRhZG9zGAEgAygLMh8ucHJpbWVycGVzby'
    '5zYXZpbmdzLnYxLkFwYXJ0YWRvUglhcGFydGFkb3M=');

@$core.Deprecated('Use updateApartadoRequestDescriptor instead')
const UpdateApartadoRequest$json = {
  '1': 'UpdateApartadoRequest',
  '2': [
    {'1': 'apartado_id', '3': 1, '4': 1, '5': 9, '10': 'apartadoId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'current_amount',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'currentAmount'
    },
    {
      '1': 'target_amount',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'targetAmount'
    },
    {
      '1': 'financial_goal_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'financialGoalId',
      '17': true
    },
  ],
  '8': [
    {'1': '_financial_goal_id'},
  ],
};

/// Descriptor for `UpdateApartadoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateApartadoRequestDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVBcGFydGFkb1JlcXVlc3QSHwoLYXBhcnRhZG9faWQYASABKAlSCmFwYXJ0YWRvSW'
    'QSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24S'
    'QwoOY3VycmVudF9hbW91bnQYBCABKAsyHC5wcmltZXJwZXNvLmZpbmFuY2UudjEuTW9uZXlSDW'
    'N1cnJlbnRBbW91bnQSQQoNdGFyZ2V0X2Ftb3VudBgFIAEoCzIcLnByaW1lcnBlc28uZmluYW5j'
    'ZS52MS5Nb25leVIMdGFyZ2V0QW1vdW50Ei8KEWZpbmFuY2lhbF9nb2FsX2lkGAYgASgJSABSD2'
    'ZpbmFuY2lhbEdvYWxJZIgBAUIUChJfZmluYW5jaWFsX2dvYWxfaWQ=');

@$core.Deprecated('Use updateApartadoResponseDescriptor instead')
const UpdateApartadoResponse$json = {
  '1': 'UpdateApartadoResponse',
  '2': [
    {
      '1': 'apartado',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.Apartado',
      '10': 'apartado'
    },
  ],
};

/// Descriptor for `UpdateApartadoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateApartadoResponseDescriptor =
    $convert.base64Decode(
        'ChZVcGRhdGVBcGFydGFkb1Jlc3BvbnNlEjsKCGFwYXJ0YWRvGAEgASgLMh8ucHJpbWVycGVzby'
        '5zYXZpbmdzLnYxLkFwYXJ0YWRvUghhcGFydGFkbw==');

@$core.Deprecated('Use deleteApartadoRequestDescriptor instead')
const DeleteApartadoRequest$json = {
  '1': 'DeleteApartadoRequest',
  '2': [
    {'1': 'apartado_id', '3': 1, '4': 1, '5': 9, '10': 'apartadoId'},
  ],
};

/// Descriptor for `DeleteApartadoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteApartadoRequestDescriptor = $convert.base64Decode(
    'ChVEZWxldGVBcGFydGFkb1JlcXVlc3QSHwoLYXBhcnRhZG9faWQYASABKAlSCmFwYXJ0YWRvSW'
    'Q=');

@$core.Deprecated('Use deleteApartadoResponseDescriptor instead')
const DeleteApartadoResponse$json = {
  '1': 'DeleteApartadoResponse',
  '2': [
    {
      '1': 'apartado',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.Apartado',
      '10': 'apartado'
    },
  ],
};

/// Descriptor for `DeleteApartadoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteApartadoResponseDescriptor =
    $convert.base64Decode(
        'ChZEZWxldGVBcGFydGFkb1Jlc3BvbnNlEjsKCGFwYXJ0YWRvGAEgASgLMh8ucHJpbWVycGVzby'
        '5zYXZpbmdzLnYxLkFwYXJ0YWRvUghhcGFydGFkbw==');

@$core.Deprecated('Use createFinancialGoalRequestDescriptor instead')
const CreateFinancialGoalRequest$json = {
  '1': 'CreateFinancialGoalRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'target_amount',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'targetAmount'
    },
    {
      '1': 'target_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'targetDate'
    },
  ],
};

/// Descriptor for `CreateFinancialGoalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFinancialGoalRequestDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVGaW5hbmNpYWxHb2FsUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2'
    'NyaXB0aW9uGAIgASgJUgtkZXNjcmlwdGlvbhJBCg10YXJnZXRfYW1vdW50GAMgASgLMhwucHJp'
    'bWVycGVzby5maW5hbmNlLnYxLk1vbmV5Ugx0YXJnZXRBbW91bnQSOwoLdGFyZ2V0X2RhdGUYBC'
    'ABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgp0YXJnZXREYXRl');

@$core.Deprecated('Use createFinancialGoalResponseDescriptor instead')
const CreateFinancialGoalResponse$json = {
  '1': 'CreateFinancialGoalResponse',
  '2': [
    {
      '1': 'financial_goal',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.FinancialGoal',
      '10': 'financialGoal'
    },
  ],
};

/// Descriptor for `CreateFinancialGoalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFinancialGoalResponseDescriptor =
    $convert.base64Decode(
        'ChtDcmVhdGVGaW5hbmNpYWxHb2FsUmVzcG9uc2USSwoOZmluYW5jaWFsX2dvYWwYASABKAsyJC'
        '5wcmltZXJwZXNvLnNhdmluZ3MudjEuRmluYW5jaWFsR29hbFINZmluYW5jaWFsR29hbA==');

@$core.Deprecated('Use getFinancialGoalRequestDescriptor instead')
const GetFinancialGoalRequest$json = {
  '1': 'GetFinancialGoalRequest',
  '2': [
    {'1': 'financial_goal_id', '3': 1, '4': 1, '5': 9, '10': 'financialGoalId'},
  ],
};

/// Descriptor for `GetFinancialGoalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinancialGoalRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRGaW5hbmNpYWxHb2FsUmVxdWVzdBIqChFmaW5hbmNpYWxfZ29hbF9pZBgBIAEoCVIPZm'
        'luYW5jaWFsR29hbElk');

@$core.Deprecated('Use getFinancialGoalResponseDescriptor instead')
const GetFinancialGoalResponse$json = {
  '1': 'GetFinancialGoalResponse',
  '2': [
    {
      '1': 'financial_goal',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.FinancialGoal',
      '10': 'financialGoal'
    },
  ],
};

/// Descriptor for `GetFinancialGoalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFinancialGoalResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRGaW5hbmNpYWxHb2FsUmVzcG9uc2USSwoOZmluYW5jaWFsX2dvYWwYASABKAsyJC5wcm'
        'ltZXJwZXNvLnNhdmluZ3MudjEuRmluYW5jaWFsR29hbFINZmluYW5jaWFsR29hbA==');

@$core.Deprecated('Use listFinancialGoalsRequestDescriptor instead')
const ListFinancialGoalsRequest$json = {
  '1': 'ListFinancialGoalsRequest',
  '2': [
    {'1': 'page_size', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListFinancialGoalsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listFinancialGoalsRequestDescriptor =
    $convert.base64Decode(
        'ChlMaXN0RmluYW5jaWFsR29hbHNSZXF1ZXN0EhsKCXBhZ2Vfc2l6ZRgBIAEoBVIIcGFnZVNpem'
        'U=');

@$core.Deprecated('Use listFinancialGoalsResponseDescriptor instead')
const ListFinancialGoalsResponse$json = {
  '1': 'ListFinancialGoalsResponse',
  '2': [
    {
      '1': 'financial_goals',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.primerpeso.savings.v1.FinancialGoal',
      '10': 'financialGoals'
    },
  ],
};

/// Descriptor for `ListFinancialGoalsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listFinancialGoalsResponseDescriptor =
    $convert.base64Decode(
        'ChpMaXN0RmluYW5jaWFsR29hbHNSZXNwb25zZRJNCg9maW5hbmNpYWxfZ29hbHMYASADKAsyJC'
        '5wcmltZXJwZXNvLnNhdmluZ3MudjEuRmluYW5jaWFsR29hbFIOZmluYW5jaWFsR29hbHM=');

@$core.Deprecated('Use updateFinancialGoalRequestDescriptor instead')
const UpdateFinancialGoalRequest$json = {
  '1': 'UpdateFinancialGoalRequest',
  '2': [
    {'1': 'financial_goal_id', '3': 1, '4': 1, '5': 9, '10': 'financialGoalId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'target_amount',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'targetAmount'
    },
    {
      '1': 'target_date',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'targetDate'
    },
  ],
};

/// Descriptor for `UpdateFinancialGoalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFinancialGoalRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVGaW5hbmNpYWxHb2FsUmVxdWVzdBIqChFmaW5hbmNpYWxfZ29hbF9pZBgBIAEoCV'
    'IPZmluYW5jaWFsR29hbElkEhIKBG5hbWUYAiABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAyAB'
    'KAlSC2Rlc2NyaXB0aW9uEkEKDXRhcmdldF9hbW91bnQYBCABKAsyHC5wcmltZXJwZXNvLmZpbm'
    'FuY2UudjEuTW9uZXlSDHRhcmdldEFtb3VudBI7Cgt0YXJnZXRfZGF0ZRgFIAEoCzIaLmdvb2ds'
    'ZS5wcm90b2J1Zi5UaW1lc3RhbXBSCnRhcmdldERhdGU=');

@$core.Deprecated('Use updateFinancialGoalResponseDescriptor instead')
const UpdateFinancialGoalResponse$json = {
  '1': 'UpdateFinancialGoalResponse',
  '2': [
    {
      '1': 'financial_goal',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.FinancialGoal',
      '10': 'financialGoal'
    },
  ],
};

/// Descriptor for `UpdateFinancialGoalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFinancialGoalResponseDescriptor =
    $convert.base64Decode(
        'ChtVcGRhdGVGaW5hbmNpYWxHb2FsUmVzcG9uc2USSwoOZmluYW5jaWFsX2dvYWwYASABKAsyJC'
        '5wcmltZXJwZXNvLnNhdmluZ3MudjEuRmluYW5jaWFsR29hbFINZmluYW5jaWFsR29hbA==');

@$core.Deprecated('Use deleteFinancialGoalRequestDescriptor instead')
const DeleteFinancialGoalRequest$json = {
  '1': 'DeleteFinancialGoalRequest',
  '2': [
    {'1': 'financial_goal_id', '3': 1, '4': 1, '5': 9, '10': 'financialGoalId'},
  ],
};

/// Descriptor for `DeleteFinancialGoalRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFinancialGoalRequestDescriptor =
    $convert.base64Decode(
        'ChpEZWxldGVGaW5hbmNpYWxHb2FsUmVxdWVzdBIqChFmaW5hbmNpYWxfZ29hbF9pZBgBIAEoCV'
        'IPZmluYW5jaWFsR29hbElk');

@$core.Deprecated('Use deleteFinancialGoalResponseDescriptor instead')
const DeleteFinancialGoalResponse$json = {
  '1': 'DeleteFinancialGoalResponse',
  '2': [
    {
      '1': 'financial_goal',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.FinancialGoal',
      '10': 'financialGoal'
    },
  ],
};

/// Descriptor for `DeleteFinancialGoalResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFinancialGoalResponseDescriptor =
    $convert.base64Decode(
        'ChtEZWxldGVGaW5hbmNpYWxHb2FsUmVzcG9uc2USSwoOZmluYW5jaWFsX2dvYWwYASABKAsyJC'
        '5wcmltZXJwZXNvLnNhdmluZ3MudjEuRmluYW5jaWFsR29hbFINZmluYW5jaWFsR29hbA==');

@$core.Deprecated('Use createRecurringPaymentReminderRequestDescriptor instead')
const CreateRecurringPaymentReminderRequest$json = {
  '1': 'CreateRecurringPaymentReminderRequest',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'payee', '3': 2, '4': 1, '5': 9, '10': 'payee'},
    {
      '1': 'amount',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'amount'
    },
    {
      '1': 'frequency',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.primerpeso.savings.v1.RecurrenceFrequency',
      '10': 'frequency'
    },
    {'1': 'interval', '3': 5, '4': 1, '5': 5, '10': 'interval'},
    {
      '1': 'day_of_week',
      '3': 6,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'dayOfWeek',
      '17': true
    },
    {
      '1': 'day_of_month',
      '3': 7,
      '4': 1,
      '5': 5,
      '9': 1,
      '10': 'dayOfMonth',
      '17': true
    },
    {
      '1': 'month_of_year',
      '3': 8,
      '4': 1,
      '5': 5,
      '9': 2,
      '10': 'monthOfYear',
      '17': true
    },
    {'1': 'local_time', '3': 9, '4': 1, '5': 9, '10': 'localTime'},
    {'1': 'timezone', '3': 10, '4': 1, '5': 9, '10': 'timezone'},
  ],
  '8': [
    {'1': '_day_of_week'},
    {'1': '_day_of_month'},
    {'1': '_month_of_year'},
  ],
};

/// Descriptor for `CreateRecurringPaymentReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecurringPaymentReminderRequestDescriptor = $convert.base64Decode(
    'CiVDcmVhdGVSZWN1cnJpbmdQYXltZW50UmVtaW5kZXJSZXF1ZXN0EhQKBXRpdGxlGAEgASgJUg'
    'V0aXRsZRIUCgVwYXllZRgCIAEoCVIFcGF5ZWUSNAoGYW1vdW50GAMgASgLMhwucHJpbWVycGVz'
    'by5maW5hbmNlLnYxLk1vbmV5UgZhbW91bnQSSAoJZnJlcXVlbmN5GAQgASgOMioucHJpbWVycG'
    'Vzby5zYXZpbmdzLnYxLlJlY3VycmVuY2VGcmVxdWVuY3lSCWZyZXF1ZW5jeRIaCghpbnRlcnZh'
    'bBgFIAEoBVIIaW50ZXJ2YWwSIwoLZGF5X29mX3dlZWsYBiABKAVIAFIJZGF5T2ZXZWVriAEBEi'
    'UKDGRheV9vZl9tb250aBgHIAEoBUgBUgpkYXlPZk1vbnRoiAEBEicKDW1vbnRoX29mX3llYXIY'
    'CCABKAVIAlILbW9udGhPZlllYXKIAQESHQoKbG9jYWxfdGltZRgJIAEoCVIJbG9jYWxUaW1lEh'
    'oKCHRpbWV6b25lGAogASgJUgh0aW1lem9uZUIOCgxfZGF5X29mX3dlZWtCDwoNX2RheV9vZl9t'
    'b250aEIQCg5fbW9udGhfb2ZfeWVhcg==');

@$core
    .Deprecated('Use createRecurringPaymentReminderResponseDescriptor instead')
const CreateRecurringPaymentReminderResponse$json = {
  '1': 'CreateRecurringPaymentReminderResponse',
  '2': [
    {
      '1': 'recurring_payment_reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.RecurringPaymentReminder',
      '10': 'recurringPaymentReminder'
    },
  ],
};

/// Descriptor for `CreateRecurringPaymentReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRecurringPaymentReminderResponseDescriptor =
    $convert.base64Decode(
        'CiZDcmVhdGVSZWN1cnJpbmdQYXltZW50UmVtaW5kZXJSZXNwb25zZRJtChpyZWN1cnJpbmdfcG'
        'F5bWVudF9yZW1pbmRlchgBIAEoCzIvLnByaW1lcnBlc28uc2F2aW5ncy52MS5SZWN1cnJpbmdQ'
        'YXltZW50UmVtaW5kZXJSGHJlY3VycmluZ1BheW1lbnRSZW1pbmRlcg==');

@$core.Deprecated('Use getRecurringPaymentReminderRequestDescriptor instead')
const GetRecurringPaymentReminderRequest$json = {
  '1': 'GetRecurringPaymentReminderRequest',
  '2': [
    {
      '1': 'recurring_payment_reminder_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'recurringPaymentReminderId'
    },
  ],
};

/// Descriptor for `GetRecurringPaymentReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecurringPaymentReminderRequestDescriptor =
    $convert.base64Decode(
        'CiJHZXRSZWN1cnJpbmdQYXltZW50UmVtaW5kZXJSZXF1ZXN0EkEKHXJlY3VycmluZ19wYXltZW'
        '50X3JlbWluZGVyX2lkGAEgASgJUhpyZWN1cnJpbmdQYXltZW50UmVtaW5kZXJJZA==');

@$core.Deprecated('Use getRecurringPaymentReminderResponseDescriptor instead')
const GetRecurringPaymentReminderResponse$json = {
  '1': 'GetRecurringPaymentReminderResponse',
  '2': [
    {
      '1': 'recurring_payment_reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.RecurringPaymentReminder',
      '10': 'recurringPaymentReminder'
    },
  ],
};

/// Descriptor for `GetRecurringPaymentReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecurringPaymentReminderResponseDescriptor =
    $convert.base64Decode(
        'CiNHZXRSZWN1cnJpbmdQYXltZW50UmVtaW5kZXJSZXNwb25zZRJtChpyZWN1cnJpbmdfcGF5bW'
        'VudF9yZW1pbmRlchgBIAEoCzIvLnByaW1lcnBlc28uc2F2aW5ncy52MS5SZWN1cnJpbmdQYXlt'
        'ZW50UmVtaW5kZXJSGHJlY3VycmluZ1BheW1lbnRSZW1pbmRlcg==');

@$core.Deprecated('Use listRecurringPaymentRemindersRequestDescriptor instead')
const ListRecurringPaymentRemindersRequest$json = {
  '1': 'ListRecurringPaymentRemindersRequest',
  '2': [
    {'1': 'page_size', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListRecurringPaymentRemindersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRecurringPaymentRemindersRequestDescriptor =
    $convert.base64Decode(
        'CiRMaXN0UmVjdXJyaW5nUGF5bWVudFJlbWluZGVyc1JlcXVlc3QSGwoJcGFnZV9zaXplGAEgAS'
        'gFUghwYWdlU2l6ZQ==');

@$core.Deprecated('Use listRecurringPaymentRemindersResponseDescriptor instead')
const ListRecurringPaymentRemindersResponse$json = {
  '1': 'ListRecurringPaymentRemindersResponse',
  '2': [
    {
      '1': 'recurring_payment_reminders',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.primerpeso.savings.v1.RecurringPaymentReminder',
      '10': 'recurringPaymentReminders'
    },
  ],
};

/// Descriptor for `ListRecurringPaymentRemindersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRecurringPaymentRemindersResponseDescriptor =
    $convert.base64Decode(
        'CiVMaXN0UmVjdXJyaW5nUGF5bWVudFJlbWluZGVyc1Jlc3BvbnNlEm8KG3JlY3VycmluZ19wYX'
        'ltZW50X3JlbWluZGVycxgBIAMoCzIvLnByaW1lcnBlc28uc2F2aW5ncy52MS5SZWN1cnJpbmdQ'
        'YXltZW50UmVtaW5kZXJSGXJlY3VycmluZ1BheW1lbnRSZW1pbmRlcnM=');

@$core.Deprecated('Use updateRecurringPaymentReminderRequestDescriptor instead')
const UpdateRecurringPaymentReminderRequest$json = {
  '1': 'UpdateRecurringPaymentReminderRequest',
  '2': [
    {
      '1': 'recurring_payment_reminder_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'recurringPaymentReminderId'
    },
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'payee', '3': 3, '4': 1, '5': 9, '10': 'payee'},
    {
      '1': 'amount',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'amount'
    },
    {
      '1': 'frequency',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.primerpeso.savings.v1.RecurrenceFrequency',
      '10': 'frequency'
    },
    {'1': 'interval', '3': 6, '4': 1, '5': 5, '10': 'interval'},
    {
      '1': 'day_of_week',
      '3': 7,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'dayOfWeek',
      '17': true
    },
    {
      '1': 'day_of_month',
      '3': 8,
      '4': 1,
      '5': 5,
      '9': 1,
      '10': 'dayOfMonth',
      '17': true
    },
    {
      '1': 'month_of_year',
      '3': 9,
      '4': 1,
      '5': 5,
      '9': 2,
      '10': 'monthOfYear',
      '17': true
    },
    {'1': 'local_time', '3': 10, '4': 1, '5': 9, '10': 'localTime'},
    {'1': 'timezone', '3': 11, '4': 1, '5': 9, '10': 'timezone'},
  ],
  '8': [
    {'1': '_day_of_week'},
    {'1': '_day_of_month'},
    {'1': '_month_of_year'},
  ],
};

/// Descriptor for `UpdateRecurringPaymentReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRecurringPaymentReminderRequestDescriptor = $convert.base64Decode(
    'CiVVcGRhdGVSZWN1cnJpbmdQYXltZW50UmVtaW5kZXJSZXF1ZXN0EkEKHXJlY3VycmluZ19wYX'
    'ltZW50X3JlbWluZGVyX2lkGAEgASgJUhpyZWN1cnJpbmdQYXltZW50UmVtaW5kZXJJZBIUCgV0'
    'aXRsZRgCIAEoCVIFdGl0bGUSFAoFcGF5ZWUYAyABKAlSBXBheWVlEjQKBmFtb3VudBgEIAEoCz'
    'IcLnByaW1lcnBlc28uZmluYW5jZS52MS5Nb25leVIGYW1vdW50EkgKCWZyZXF1ZW5jeRgFIAEo'
    'DjIqLnByaW1lcnBlc28uc2F2aW5ncy52MS5SZWN1cnJlbmNlRnJlcXVlbmN5UglmcmVxdWVuY3'
    'kSGgoIaW50ZXJ2YWwYBiABKAVSCGludGVydmFsEiMKC2RheV9vZl93ZWVrGAcgASgFSABSCWRh'
    'eU9mV2Vla4gBARIlCgxkYXlfb2ZfbW9udGgYCCABKAVIAVIKZGF5T2ZNb250aIgBARInCg1tb2'
    '50aF9vZl95ZWFyGAkgASgFSAJSC21vbnRoT2ZZZWFyiAEBEh0KCmxvY2FsX3RpbWUYCiABKAlS'
    'CWxvY2FsVGltZRIaCgh0aW1lem9uZRgLIAEoCVIIdGltZXpvbmVCDgoMX2RheV9vZl93ZWVrQg'
    '8KDV9kYXlfb2ZfbW9udGhCEAoOX21vbnRoX29mX3llYXI=');

@$core
    .Deprecated('Use updateRecurringPaymentReminderResponseDescriptor instead')
const UpdateRecurringPaymentReminderResponse$json = {
  '1': 'UpdateRecurringPaymentReminderResponse',
  '2': [
    {
      '1': 'recurring_payment_reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.RecurringPaymentReminder',
      '10': 'recurringPaymentReminder'
    },
  ],
};

/// Descriptor for `UpdateRecurringPaymentReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRecurringPaymentReminderResponseDescriptor =
    $convert.base64Decode(
        'CiZVcGRhdGVSZWN1cnJpbmdQYXltZW50UmVtaW5kZXJSZXNwb25zZRJtChpyZWN1cnJpbmdfcG'
        'F5bWVudF9yZW1pbmRlchgBIAEoCzIvLnByaW1lcnBlc28uc2F2aW5ncy52MS5SZWN1cnJpbmdQ'
        'YXltZW50UmVtaW5kZXJSGHJlY3VycmluZ1BheW1lbnRSZW1pbmRlcg==');

@$core.Deprecated('Use deleteRecurringPaymentReminderRequestDescriptor instead')
const DeleteRecurringPaymentReminderRequest$json = {
  '1': 'DeleteRecurringPaymentReminderRequest',
  '2': [
    {
      '1': 'recurring_payment_reminder_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'recurringPaymentReminderId'
    },
  ],
};

/// Descriptor for `DeleteRecurringPaymentReminderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRecurringPaymentReminderRequestDescriptor =
    $convert.base64Decode(
        'CiVEZWxldGVSZWN1cnJpbmdQYXltZW50UmVtaW5kZXJSZXF1ZXN0EkEKHXJlY3VycmluZ19wYX'
        'ltZW50X3JlbWluZGVyX2lkGAEgASgJUhpyZWN1cnJpbmdQYXltZW50UmVtaW5kZXJJZA==');

@$core
    .Deprecated('Use deleteRecurringPaymentReminderResponseDescriptor instead')
const DeleteRecurringPaymentReminderResponse$json = {
  '1': 'DeleteRecurringPaymentReminderResponse',
  '2': [
    {
      '1': 'recurring_payment_reminder',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.savings.v1.RecurringPaymentReminder',
      '10': 'recurringPaymentReminder'
    },
  ],
};

/// Descriptor for `DeleteRecurringPaymentReminderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRecurringPaymentReminderResponseDescriptor =
    $convert.base64Decode(
        'CiZEZWxldGVSZWN1cnJpbmdQYXltZW50UmVtaW5kZXJSZXNwb25zZRJtChpyZWN1cnJpbmdfcG'
        'F5bWVudF9yZW1pbmRlchgBIAEoCzIvLnByaW1lcnBlc28uc2F2aW5ncy52MS5SZWN1cnJpbmdQ'
        'YXltZW50UmVtaW5kZXJSGHJlY3VycmluZ1BheW1lbnRSZW1pbmRlcg==');

const $core.Map<$core.String, $core.dynamic> SavingsServiceBase$json = {
  '1': 'SavingsService',
  '2': [
    {
      '1': 'CreateApartado',
      '2': '.primerpeso.savings.v1.CreateApartadoRequest',
      '3': '.primerpeso.savings.v1.CreateApartadoResponse'
    },
    {
      '1': 'GetApartado',
      '2': '.primerpeso.savings.v1.GetApartadoRequest',
      '3': '.primerpeso.savings.v1.GetApartadoResponse'
    },
    {
      '1': 'ListApartados',
      '2': '.primerpeso.savings.v1.ListApartadosRequest',
      '3': '.primerpeso.savings.v1.ListApartadosResponse'
    },
    {
      '1': 'UpdateApartado',
      '2': '.primerpeso.savings.v1.UpdateApartadoRequest',
      '3': '.primerpeso.savings.v1.UpdateApartadoResponse'
    },
    {
      '1': 'DeleteApartado',
      '2': '.primerpeso.savings.v1.DeleteApartadoRequest',
      '3': '.primerpeso.savings.v1.DeleteApartadoResponse'
    },
    {
      '1': 'CreateFinancialGoal',
      '2': '.primerpeso.savings.v1.CreateFinancialGoalRequest',
      '3': '.primerpeso.savings.v1.CreateFinancialGoalResponse'
    },
    {
      '1': 'GetFinancialGoal',
      '2': '.primerpeso.savings.v1.GetFinancialGoalRequest',
      '3': '.primerpeso.savings.v1.GetFinancialGoalResponse'
    },
    {
      '1': 'ListFinancialGoals',
      '2': '.primerpeso.savings.v1.ListFinancialGoalsRequest',
      '3': '.primerpeso.savings.v1.ListFinancialGoalsResponse'
    },
    {
      '1': 'UpdateFinancialGoal',
      '2': '.primerpeso.savings.v1.UpdateFinancialGoalRequest',
      '3': '.primerpeso.savings.v1.UpdateFinancialGoalResponse'
    },
    {
      '1': 'DeleteFinancialGoal',
      '2': '.primerpeso.savings.v1.DeleteFinancialGoalRequest',
      '3': '.primerpeso.savings.v1.DeleteFinancialGoalResponse'
    },
    {
      '1': 'CreateRecurringPaymentReminder',
      '2': '.primerpeso.savings.v1.CreateRecurringPaymentReminderRequest',
      '3': '.primerpeso.savings.v1.CreateRecurringPaymentReminderResponse'
    },
    {
      '1': 'GetRecurringPaymentReminder',
      '2': '.primerpeso.savings.v1.GetRecurringPaymentReminderRequest',
      '3': '.primerpeso.savings.v1.GetRecurringPaymentReminderResponse'
    },
    {
      '1': 'ListRecurringPaymentReminders',
      '2': '.primerpeso.savings.v1.ListRecurringPaymentRemindersRequest',
      '3': '.primerpeso.savings.v1.ListRecurringPaymentRemindersResponse'
    },
    {
      '1': 'UpdateRecurringPaymentReminder',
      '2': '.primerpeso.savings.v1.UpdateRecurringPaymentReminderRequest',
      '3': '.primerpeso.savings.v1.UpdateRecurringPaymentReminderResponse'
    },
    {
      '1': 'DeleteRecurringPaymentReminder',
      '2': '.primerpeso.savings.v1.DeleteRecurringPaymentReminderRequest',
      '3': '.primerpeso.savings.v1.DeleteRecurringPaymentReminderResponse'
    },
  ],
};

@$core.Deprecated('Use savingsServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    SavingsServiceBase$messageJson = {
  '.primerpeso.savings.v1.CreateApartadoRequest': CreateApartadoRequest$json,
  '.primerpeso.finance.v1.Money': $0.Money$json,
  '.primerpeso.savings.v1.CreateApartadoResponse': CreateApartadoResponse$json,
  '.primerpeso.savings.v1.Apartado': Apartado$json,
  '.google.protobuf.Timestamp': $1.Timestamp$json,
  '.primerpeso.savings.v1.GetApartadoRequest': GetApartadoRequest$json,
  '.primerpeso.savings.v1.GetApartadoResponse': GetApartadoResponse$json,
  '.primerpeso.savings.v1.ListApartadosRequest': ListApartadosRequest$json,
  '.primerpeso.savings.v1.ListApartadosResponse': ListApartadosResponse$json,
  '.primerpeso.savings.v1.UpdateApartadoRequest': UpdateApartadoRequest$json,
  '.primerpeso.savings.v1.UpdateApartadoResponse': UpdateApartadoResponse$json,
  '.primerpeso.savings.v1.DeleteApartadoRequest': DeleteApartadoRequest$json,
  '.primerpeso.savings.v1.DeleteApartadoResponse': DeleteApartadoResponse$json,
  '.primerpeso.savings.v1.CreateFinancialGoalRequest':
      CreateFinancialGoalRequest$json,
  '.primerpeso.savings.v1.CreateFinancialGoalResponse':
      CreateFinancialGoalResponse$json,
  '.primerpeso.savings.v1.FinancialGoal': FinancialGoal$json,
  '.primerpeso.savings.v1.GetFinancialGoalRequest':
      GetFinancialGoalRequest$json,
  '.primerpeso.savings.v1.GetFinancialGoalResponse':
      GetFinancialGoalResponse$json,
  '.primerpeso.savings.v1.ListFinancialGoalsRequest':
      ListFinancialGoalsRequest$json,
  '.primerpeso.savings.v1.ListFinancialGoalsResponse':
      ListFinancialGoalsResponse$json,
  '.primerpeso.savings.v1.UpdateFinancialGoalRequest':
      UpdateFinancialGoalRequest$json,
  '.primerpeso.savings.v1.UpdateFinancialGoalResponse':
      UpdateFinancialGoalResponse$json,
  '.primerpeso.savings.v1.DeleteFinancialGoalRequest':
      DeleteFinancialGoalRequest$json,
  '.primerpeso.savings.v1.DeleteFinancialGoalResponse':
      DeleteFinancialGoalResponse$json,
  '.primerpeso.savings.v1.CreateRecurringPaymentReminderRequest':
      CreateRecurringPaymentReminderRequest$json,
  '.primerpeso.savings.v1.CreateRecurringPaymentReminderResponse':
      CreateRecurringPaymentReminderResponse$json,
  '.primerpeso.savings.v1.RecurringPaymentReminder':
      RecurringPaymentReminder$json,
  '.primerpeso.savings.v1.GetRecurringPaymentReminderRequest':
      GetRecurringPaymentReminderRequest$json,
  '.primerpeso.savings.v1.GetRecurringPaymentReminderResponse':
      GetRecurringPaymentReminderResponse$json,
  '.primerpeso.savings.v1.ListRecurringPaymentRemindersRequest':
      ListRecurringPaymentRemindersRequest$json,
  '.primerpeso.savings.v1.ListRecurringPaymentRemindersResponse':
      ListRecurringPaymentRemindersResponse$json,
  '.primerpeso.savings.v1.UpdateRecurringPaymentReminderRequest':
      UpdateRecurringPaymentReminderRequest$json,
  '.primerpeso.savings.v1.UpdateRecurringPaymentReminderResponse':
      UpdateRecurringPaymentReminderResponse$json,
  '.primerpeso.savings.v1.DeleteRecurringPaymentReminderRequest':
      DeleteRecurringPaymentReminderRequest$json,
  '.primerpeso.savings.v1.DeleteRecurringPaymentReminderResponse':
      DeleteRecurringPaymentReminderResponse$json,
};

/// Descriptor for `SavingsService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List savingsServiceDescriptor = $convert.base64Decode(
    'Cg5TYXZpbmdzU2VydmljZRJtCg5DcmVhdGVBcGFydGFkbxIsLnByaW1lcnBlc28uc2F2aW5ncy'
    '52MS5DcmVhdGVBcGFydGFkb1JlcXVlc3QaLS5wcmltZXJwZXNvLnNhdmluZ3MudjEuQ3JlYXRl'
    'QXBhcnRhZG9SZXNwb25zZRJkCgtHZXRBcGFydGFkbxIpLnByaW1lcnBlc28uc2F2aW5ncy52MS'
    '5HZXRBcGFydGFkb1JlcXVlc3QaKi5wcmltZXJwZXNvLnNhdmluZ3MudjEuR2V0QXBhcnRhZG9S'
    'ZXNwb25zZRJqCg1MaXN0QXBhcnRhZG9zEisucHJpbWVycGVzby5zYXZpbmdzLnYxLkxpc3RBcG'
    'FydGFkb3NSZXF1ZXN0GiwucHJpbWVycGVzby5zYXZpbmdzLnYxLkxpc3RBcGFydGFkb3NSZXNw'
    'b25zZRJtCg5VcGRhdGVBcGFydGFkbxIsLnByaW1lcnBlc28uc2F2aW5ncy52MS5VcGRhdGVBcG'
    'FydGFkb1JlcXVlc3QaLS5wcmltZXJwZXNvLnNhdmluZ3MudjEuVXBkYXRlQXBhcnRhZG9SZXNw'
    'b25zZRJtCg5EZWxldGVBcGFydGFkbxIsLnByaW1lcnBlc28uc2F2aW5ncy52MS5EZWxldGVBcG'
    'FydGFkb1JlcXVlc3QaLS5wcmltZXJwZXNvLnNhdmluZ3MudjEuRGVsZXRlQXBhcnRhZG9SZXNw'
    'b25zZRJ8ChNDcmVhdGVGaW5hbmNpYWxHb2FsEjEucHJpbWVycGVzby5zYXZpbmdzLnYxLkNyZW'
    'F0ZUZpbmFuY2lhbEdvYWxSZXF1ZXN0GjIucHJpbWVycGVzby5zYXZpbmdzLnYxLkNyZWF0ZUZp'
    'bmFuY2lhbEdvYWxSZXNwb25zZRJzChBHZXRGaW5hbmNpYWxHb2FsEi4ucHJpbWVycGVzby5zYX'
    'ZpbmdzLnYxLkdldEZpbmFuY2lhbEdvYWxSZXF1ZXN0Gi8ucHJpbWVycGVzby5zYXZpbmdzLnYx'
    'LkdldEZpbmFuY2lhbEdvYWxSZXNwb25zZRJ5ChJMaXN0RmluYW5jaWFsR29hbHMSMC5wcmltZX'
    'JwZXNvLnNhdmluZ3MudjEuTGlzdEZpbmFuY2lhbEdvYWxzUmVxdWVzdBoxLnByaW1lcnBlc28u'
    'c2F2aW5ncy52MS5MaXN0RmluYW5jaWFsR29hbHNSZXNwb25zZRJ8ChNVcGRhdGVGaW5hbmNpYW'
    'xHb2FsEjEucHJpbWVycGVzby5zYXZpbmdzLnYxLlVwZGF0ZUZpbmFuY2lhbEdvYWxSZXF1ZXN0'
    'GjIucHJpbWVycGVzby5zYXZpbmdzLnYxLlVwZGF0ZUZpbmFuY2lhbEdvYWxSZXNwb25zZRJ8Ch'
    'NEZWxldGVGaW5hbmNpYWxHb2FsEjEucHJpbWVycGVzby5zYXZpbmdzLnYxLkRlbGV0ZUZpbmFu'
    'Y2lhbEdvYWxSZXF1ZXN0GjIucHJpbWVycGVzby5zYXZpbmdzLnYxLkRlbGV0ZUZpbmFuY2lhbE'
    'dvYWxSZXNwb25zZRKdAQoeQ3JlYXRlUmVjdXJyaW5nUGF5bWVudFJlbWluZGVyEjwucHJpbWVy'
    'cGVzby5zYXZpbmdzLnYxLkNyZWF0ZVJlY3VycmluZ1BheW1lbnRSZW1pbmRlclJlcXVlc3QaPS'
    '5wcmltZXJwZXNvLnNhdmluZ3MudjEuQ3JlYXRlUmVjdXJyaW5nUGF5bWVudFJlbWluZGVyUmVz'
    'cG9uc2USlAEKG0dldFJlY3VycmluZ1BheW1lbnRSZW1pbmRlchI5LnByaW1lcnBlc28uc2F2aW'
    '5ncy52MS5HZXRSZWN1cnJpbmdQYXltZW50UmVtaW5kZXJSZXF1ZXN0GjoucHJpbWVycGVzby5z'
    'YXZpbmdzLnYxLkdldFJlY3VycmluZ1BheW1lbnRSZW1pbmRlclJlc3BvbnNlEpoBCh1MaXN0Um'
    'VjdXJyaW5nUGF5bWVudFJlbWluZGVycxI7LnByaW1lcnBlc28uc2F2aW5ncy52MS5MaXN0UmVj'
    'dXJyaW5nUGF5bWVudFJlbWluZGVyc1JlcXVlc3QaPC5wcmltZXJwZXNvLnNhdmluZ3MudjEuTG'
    'lzdFJlY3VycmluZ1BheW1lbnRSZW1pbmRlcnNSZXNwb25zZRKdAQoeVXBkYXRlUmVjdXJyaW5n'
    'UGF5bWVudFJlbWluZGVyEjwucHJpbWVycGVzby5zYXZpbmdzLnYxLlVwZGF0ZVJlY3VycmluZ1'
    'BheW1lbnRSZW1pbmRlclJlcXVlc3QaPS5wcmltZXJwZXNvLnNhdmluZ3MudjEuVXBkYXRlUmVj'
    'dXJyaW5nUGF5bWVudFJlbWluZGVyUmVzcG9uc2USnQEKHkRlbGV0ZVJlY3VycmluZ1BheW1lbn'
    'RSZW1pbmRlchI8LnByaW1lcnBlc28uc2F2aW5ncy52MS5EZWxldGVSZWN1cnJpbmdQYXltZW50'
    'UmVtaW5kZXJSZXF1ZXN0Gj0ucHJpbWVycGVzby5zYXZpbmdzLnYxLkRlbGV0ZVJlY3VycmluZ1'
    'BheW1lbnRSZW1pbmRlclJlc3BvbnNl');
