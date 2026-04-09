// This is a generated file - do not edit.
//
// Generated from primerpeso/finance/v1/finance.proto.

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

@$core.Deprecated('Use moneyDescriptor instead')
const Money$json = {
  '1': 'Money',
  '2': [
    {'1': 'currency_code', '3': 1, '4': 1, '5': 9, '10': 'currencyCode'},
    {'1': 'units', '3': 2, '4': 1, '5': 3, '10': 'units'},
    {'1': 'nanos', '3': 3, '4': 1, '5': 5, '10': 'nanos'},
  ],
};

/// Descriptor for `Money`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moneyDescriptor = $convert.base64Decode(
    'CgVNb25leRIjCg1jdXJyZW5jeV9jb2RlGAEgASgJUgxjdXJyZW5jeUNvZGUSFAoFdW5pdHMYAi'
    'ABKANSBXVuaXRzEhQKBW5hbm9zGAMgASgFUgVuYW5vcw==');

@$core.Deprecated('Use expenseDescriptor instead')
const Expense$json = {
  '1': 'Expense',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'merchant_name', '3': 2, '4': 1, '5': 9, '10': 'merchantName'},
    {'1': 'display_title', '3': 3, '4': 1, '5': 9, '10': 'displayTitle'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {'1': 'source_receipt_id', '3': 5, '4': 1, '5': 9, '10': 'sourceReceiptId'},
    {
      '1': 'amount',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'amount'
    },
    {
      '1': 'occurred_at',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'occurredAt'
    },
    {
      '1': 'created_at',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `Expense`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List expenseDescriptor = $convert.base64Decode(
    'CgdFeHBlbnNlEg4KAmlkGAEgASgJUgJpZBIjCg1tZXJjaGFudF9uYW1lGAIgASgJUgxtZXJjaG'
    'FudE5hbWUSIwoNZGlzcGxheV90aXRsZRgDIAEoCVIMZGlzcGxheVRpdGxlEhoKCGNhdGVnb3J5'
    'GAQgASgJUghjYXRlZ29yeRIqChFzb3VyY2VfcmVjZWlwdF9pZBgFIAEoCVIPc291cmNlUmVjZW'
    'lwdElkEjQKBmFtb3VudBgGIAEoCzIcLnByaW1lcnBlc28uZmluYW5jZS52MS5Nb25leVIGYW1v'
    'dW50EjsKC29jY3VycmVkX2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKb2'
    'NjdXJyZWRBdBI5CgpjcmVhdGVkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFIJY3JlYXRlZEF0');

@$core.Deprecated('Use scoreFactorDescriptor instead')
const ScoreFactor$json = {
  '1': 'ScoreFactor',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'explanation', '3': 3, '4': 1, '5': 9, '10': 'explanation'},
    {'1': 'delta', '3': 4, '4': 1, '5': 5, '10': 'delta'},
  ],
};

/// Descriptor for `ScoreFactor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scoreFactorDescriptor = $convert.base64Decode(
    'CgtTY29yZUZhY3RvchIQCgNrZXkYASABKAlSA2tleRIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIA'
    'oLZXhwbGFuYXRpb24YAyABKAlSC2V4cGxhbmF0aW9uEhQKBWRlbHRhGAQgASgFUgVkZWx0YQ==');

@$core.Deprecated('Use scoreSummaryDescriptor instead')
const ScoreSummary$json = {
  '1': 'ScoreSummary',
  '2': [
    {'1': 'score', '3': 1, '4': 1, '5': 5, '10': 'score'},
    {
      '1': 'factors',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.primerpeso.finance.v1.ScoreFactor',
      '10': 'factors'
    },
    {
      '1': 'updated_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `ScoreSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scoreSummaryDescriptor = $convert.base64Decode(
    'CgxTY29yZVN1bW1hcnkSFAoFc2NvcmUYASABKAVSBXNjb3JlEjwKB2ZhY3RvcnMYAiADKAsyIi'
    '5wcmltZXJwZXNvLmZpbmFuY2UudjEuU2NvcmVGYWN0b3JSB2ZhY3RvcnMSOQoKdXBkYXRlZF9h'
    'dBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use confirmExpenseRequestDescriptor instead')
const ConfirmExpenseRequest$json = {
  '1': 'ConfirmExpenseRequest',
  '2': [
    {'1': 'receipt_id', '3': 1, '4': 1, '5': 9, '10': 'receiptId'},
    {'1': 'merchant_name', '3': 2, '4': 1, '5': 9, '10': 'merchantName'},
    {'1': 'display_title', '3': 3, '4': 1, '5': 9, '10': 'displayTitle'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    {
      '1': 'amount',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'amount'
    },
    {
      '1': 'occurred_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'occurredAt'
    },
  ],
};

/// Descriptor for `ConfirmExpenseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmExpenseRequestDescriptor = $convert.base64Decode(
    'ChVDb25maXJtRXhwZW5zZVJlcXVlc3QSHQoKcmVjZWlwdF9pZBgBIAEoCVIJcmVjZWlwdElkEi'
    'MKDW1lcmNoYW50X25hbWUYAiABKAlSDG1lcmNoYW50TmFtZRIjCg1kaXNwbGF5X3RpdGxlGAMg'
    'ASgJUgxkaXNwbGF5VGl0bGUSGgoIY2F0ZWdvcnkYBCABKAlSCGNhdGVnb3J5EjQKBmFtb3VudB'
    'gFIAEoCzIcLnByaW1lcnBlc28uZmluYW5jZS52MS5Nb25leVIGYW1vdW50EjsKC29jY3VycmVk'
    'X2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKb2NjdXJyZWRBdA==');

@$core.Deprecated('Use confirmExpenseResponseDescriptor instead')
const ConfirmExpenseResponse$json = {
  '1': 'ConfirmExpenseResponse',
  '2': [
    {
      '1': 'expense',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Expense',
      '10': 'expense'
    },
    {
      '1': 'score_summary',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.ScoreSummary',
      '10': 'scoreSummary'
    },
  ],
};

/// Descriptor for `ConfirmExpenseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmExpenseResponseDescriptor = $convert.base64Decode(
    'ChZDb25maXJtRXhwZW5zZVJlc3BvbnNlEjgKB2V4cGVuc2UYASABKAsyHi5wcmltZXJwZXNvLm'
    'ZpbmFuY2UudjEuRXhwZW5zZVIHZXhwZW5zZRJICg1zY29yZV9zdW1tYXJ5GAIgASgLMiMucHJp'
    'bWVycGVzby5maW5hbmNlLnYxLlNjb3JlU3VtbWFyeVIMc2NvcmVTdW1tYXJ5');

@$core.Deprecated('Use listExpensesRequestDescriptor instead')
const ListExpensesRequest$json = {
  '1': 'ListExpensesRequest',
  '2': [
    {'1': 'page_size', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListExpensesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listExpensesRequestDescriptor =
    $convert.base64Decode(
        'ChNMaXN0RXhwZW5zZXNSZXF1ZXN0EhsKCXBhZ2Vfc2l6ZRgBIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use listExpensesResponseDescriptor instead')
const ListExpensesResponse$json = {
  '1': 'ListExpensesResponse',
  '2': [
    {
      '1': 'expenses',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.primerpeso.finance.v1.Expense',
      '10': 'expenses'
    },
  ],
};

/// Descriptor for `ListExpensesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listExpensesResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0RXhwZW5zZXNSZXNwb25zZRI6CghleHBlbnNlcxgBIAMoCzIeLnByaW1lcnBlc28uZm'
    'luYW5jZS52MS5FeHBlbnNlUghleHBlbnNlcw==');

@$core.Deprecated('Use getScoreSummaryRequestDescriptor instead')
const GetScoreSummaryRequest$json = {
  '1': 'GetScoreSummaryRequest',
};

/// Descriptor for `GetScoreSummaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getScoreSummaryRequestDescriptor =
    $convert.base64Decode('ChZHZXRTY29yZVN1bW1hcnlSZXF1ZXN0');

@$core.Deprecated('Use getScoreSummaryResponseDescriptor instead')
const GetScoreSummaryResponse$json = {
  '1': 'GetScoreSummaryResponse',
  '2': [
    {
      '1': 'summary',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.ScoreSummary',
      '10': 'summary'
    },
  ],
};

/// Descriptor for `GetScoreSummaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getScoreSummaryResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRTY29yZVN1bW1hcnlSZXNwb25zZRI9CgdzdW1tYXJ5GAEgASgLMiMucHJpbWVycGVzby'
        '5maW5hbmNlLnYxLlNjb3JlU3VtbWFyeVIHc3VtbWFyeQ==');

const $core.Map<$core.String, $core.dynamic> FinanceServiceBase$json = {
  '1': 'FinanceService',
  '2': [
    {
      '1': 'ConfirmExpense',
      '2': '.primerpeso.finance.v1.ConfirmExpenseRequest',
      '3': '.primerpeso.finance.v1.ConfirmExpenseResponse'
    },
    {
      '1': 'ListExpenses',
      '2': '.primerpeso.finance.v1.ListExpensesRequest',
      '3': '.primerpeso.finance.v1.ListExpensesResponse'
    },
    {
      '1': 'GetScoreSummary',
      '2': '.primerpeso.finance.v1.GetScoreSummaryRequest',
      '3': '.primerpeso.finance.v1.GetScoreSummaryResponse'
    },
  ],
};

@$core.Deprecated('Use financeServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    FinanceServiceBase$messageJson = {
  '.primerpeso.finance.v1.ConfirmExpenseRequest': ConfirmExpenseRequest$json,
  '.primerpeso.finance.v1.Money': Money$json,
  '.google.protobuf.Timestamp': $0.Timestamp$json,
  '.primerpeso.finance.v1.ConfirmExpenseResponse': ConfirmExpenseResponse$json,
  '.primerpeso.finance.v1.Expense': Expense$json,
  '.primerpeso.finance.v1.ScoreSummary': ScoreSummary$json,
  '.primerpeso.finance.v1.ScoreFactor': ScoreFactor$json,
  '.primerpeso.finance.v1.ListExpensesRequest': ListExpensesRequest$json,
  '.primerpeso.finance.v1.ListExpensesResponse': ListExpensesResponse$json,
  '.primerpeso.finance.v1.GetScoreSummaryRequest': GetScoreSummaryRequest$json,
  '.primerpeso.finance.v1.GetScoreSummaryResponse':
      GetScoreSummaryResponse$json,
};

/// Descriptor for `FinanceService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List financeServiceDescriptor = $convert.base64Decode(
    'Cg5GaW5hbmNlU2VydmljZRJtCg5Db25maXJtRXhwZW5zZRIsLnByaW1lcnBlc28uZmluYW5jZS'
    '52MS5Db25maXJtRXhwZW5zZVJlcXVlc3QaLS5wcmltZXJwZXNvLmZpbmFuY2UudjEuQ29uZmly'
    'bUV4cGVuc2VSZXNwb25zZRJnCgxMaXN0RXhwZW5zZXMSKi5wcmltZXJwZXNvLmZpbmFuY2Uudj'
    'EuTGlzdEV4cGVuc2VzUmVxdWVzdBorLnByaW1lcnBlc28uZmluYW5jZS52MS5MaXN0RXhwZW5z'
    'ZXNSZXNwb25zZRJwCg9HZXRTY29yZVN1bW1hcnkSLS5wcmltZXJwZXNvLmZpbmFuY2UudjEuR2'
    'V0U2NvcmVTdW1tYXJ5UmVxdWVzdBouLnByaW1lcnBlc28uZmluYW5jZS52MS5HZXRTY29yZVN1'
    'bW1hcnlSZXNwb25zZQ==');
