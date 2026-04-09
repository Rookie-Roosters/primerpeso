// This is a generated file - do not edit.
//
// Generated from primerpeso/documents/v1/documents.proto.

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

@$core.Deprecated('Use receiptStatusDescriptor instead')
const ReceiptStatus$json = {
  '1': 'ReceiptStatus',
  '2': [
    {'1': 'RECEIPT_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'RECEIPT_STATUS_PROCESSING', '2': 1},
    {'1': 'RECEIPT_STATUS_READY', '2': 2},
    {'1': 'RECEIPT_STATUS_FAILED', '2': 3},
  ],
};

/// Descriptor for `ReceiptStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List receiptStatusDescriptor = $convert.base64Decode(
    'Cg1SZWNlaXB0U3RhdHVzEh4KGlJFQ0VJUFRfU1RBVFVTX1VOU1BFQ0lGSUVEEAASHQoZUkVDRU'
    'lQVF9TVEFUVVNfUFJPQ0VTU0lORxABEhgKFFJFQ0VJUFRfU1RBVFVTX1JFQURZEAISGQoVUkVD'
    'RUlQVF9TVEFUVVNfRkFJTEVEEAM=');

@$core.Deprecated('Use extractionDecisionDescriptor instead')
const ExtractionDecision$json = {
  '1': 'ExtractionDecision',
  '2': [
    {'1': 'EXTRACTION_DECISION_UNSPECIFIED', '2': 0},
    {'1': 'EXTRACTION_DECISION_AUTO_REGISTER', '2': 1},
    {'1': 'EXTRACTION_DECISION_NEEDS_CLARIFICATION', '2': 2},
  ],
};

/// Descriptor for `ExtractionDecision`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List extractionDecisionDescriptor = $convert.base64Decode(
    'ChJFeHRyYWN0aW9uRGVjaXNpb24SIwofRVhUUkFDVElPTl9ERUNJU0lPTl9VTlNQRUNJRklFRB'
    'AAEiUKIUVYVFJBQ1RJT05fREVDSVNJT05fQVVUT19SRUdJU1RFUhABEisKJ0VYVFJBQ1RJT05f'
    'REVDSVNJT05fTkVFRFNfQ0xBUklGSUNBVElPThAC');

@$core.Deprecated('Use receiptLineItemDescriptor instead')
const ReceiptLineItem$json = {
  '1': 'ReceiptLineItem',
  '2': [
    {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'amount',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'amount'
    },
    {'1': 'quantity', '3': 3, '4': 1, '5': 5, '10': 'quantity'},
  ],
};

/// Descriptor for `ReceiptLineItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiptLineItemDescriptor = $convert.base64Decode(
    'Cg9SZWNlaXB0TGluZUl0ZW0SIAoLZGVzY3JpcHRpb24YASABKAlSC2Rlc2NyaXB0aW9uEjQKBm'
    'Ftb3VudBgCIAEoCzIcLnByaW1lcnBlc28uZmluYW5jZS52MS5Nb25leVIGYW1vdW50EhoKCHF1'
    'YW50aXR5GAMgASgFUghxdWFudGl0eQ==');

@$core.Deprecated('Use receiptDraftDescriptor instead')
const ReceiptDraft$json = {
  '1': 'ReceiptDraft',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.primerpeso.documents.v1.ReceiptStatus',
      '10': 'status'
    },
    {'1': 'merchant_name', '3': 3, '4': 1, '5': 9, '10': 'merchantName'},
    {
      '1': 'suggested_category',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'suggestedCategory'
    },
    {'1': 'redacted_raw_text', '3': 5, '4': 1, '5': 9, '10': 'redactedRawText'},
    {
      '1': 'line_items',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.primerpeso.documents.v1.ReceiptLineItem',
      '10': 'lineItems'
    },
    {
      '1': 'total',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Money',
      '10': 'total'
    },
    {
      '1': 'purchased_at',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'purchasedAt'
    },
    {
      '1': 'created_at',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `ReceiptDraft`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiptDraftDescriptor = $convert.base64Decode(
    'CgxSZWNlaXB0RHJhZnQSDgoCaWQYASABKAlSAmlkEj4KBnN0YXR1cxgCIAEoDjImLnByaW1lcn'
    'Blc28uZG9jdW1lbnRzLnYxLlJlY2VpcHRTdGF0dXNSBnN0YXR1cxIjCg1tZXJjaGFudF9uYW1l'
    'GAMgASgJUgxtZXJjaGFudE5hbWUSLQoSc3VnZ2VzdGVkX2NhdGVnb3J5GAQgASgJUhFzdWdnZX'
    'N0ZWRDYXRlZ29yeRIqChFyZWRhY3RlZF9yYXdfdGV4dBgFIAEoCVIPcmVkYWN0ZWRSYXdUZXh0'
    'EkcKCmxpbmVfaXRlbXMYBiADKAsyKC5wcmltZXJwZXNvLmRvY3VtZW50cy52MS5SZWNlaXB0TG'
    'luZUl0ZW1SCWxpbmVJdGVtcxIyCgV0b3RhbBgHIAEoCzIcLnByaW1lcnBlc28uZmluYW5jZS52'
    'MS5Nb25leVIFdG90YWwSPQoMcHVyY2hhc2VkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLl'
    'RpbWVzdGFtcFILcHVyY2hhc2VkQXQSOQoKY3JlYXRlZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90'
    'b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use uploadReceiptRequestDescriptor instead')
const UploadReceiptRequest$json = {
  '1': 'UploadReceiptRequest',
  '2': [
    {'1': 'content', '3': 1, '4': 1, '5': 12, '10': 'content'},
    {'1': 'filename', '3': 2, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'mime_type', '3': 3, '4': 1, '5': 9, '10': 'mimeType'},
  ],
};

/// Descriptor for `UploadReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadReceiptRequestDescriptor = $convert.base64Decode(
    'ChRVcGxvYWRSZWNlaXB0UmVxdWVzdBIYCgdjb250ZW50GAEgASgMUgdjb250ZW50EhoKCGZpbG'
    'VuYW1lGAIgASgJUghmaWxlbmFtZRIbCgltaW1lX3R5cGUYAyABKAlSCG1pbWVUeXBl');

@$core.Deprecated('Use uploadReceiptResponseDescriptor instead')
const UploadReceiptResponse$json = {
  '1': 'UploadReceiptResponse',
  '2': [
    {
      '1': 'draft',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.documents.v1.ReceiptDraft',
      '10': 'draft'
    },
    {
      '1': 'decision',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.primerpeso.documents.v1.ExtractionDecision',
      '10': 'decision'
    },
    {'1': 'missing_fields', '3': 3, '4': 3, '5': 9, '10': 'missingFields'},
    {'1': 'rationale', '3': 4, '4': 1, '5': 9, '10': 'rationale'},
    {'1': 'confidence', '3': 5, '4': 1, '5': 1, '10': 'confidence'},
    {
      '1': 'expense',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.Expense',
      '10': 'expense'
    },
    {
      '1': 'score_summary',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.finance.v1.ScoreSummary',
      '10': 'scoreSummary'
    },
  ],
};

/// Descriptor for `UploadReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadReceiptResponseDescriptor = $convert.base64Decode(
    'ChVVcGxvYWRSZWNlaXB0UmVzcG9uc2USOwoFZHJhZnQYASABKAsyJS5wcmltZXJwZXNvLmRvY3'
    'VtZW50cy52MS5SZWNlaXB0RHJhZnRSBWRyYWZ0EkcKCGRlY2lzaW9uGAIgASgOMisucHJpbWVy'
    'cGVzby5kb2N1bWVudHMudjEuRXh0cmFjdGlvbkRlY2lzaW9uUghkZWNpc2lvbhIlCg5taXNzaW'
    '5nX2ZpZWxkcxgDIAMoCVINbWlzc2luZ0ZpZWxkcxIcCglyYXRpb25hbGUYBCABKAlSCXJhdGlv'
    'bmFsZRIeCgpjb25maWRlbmNlGAUgASgBUgpjb25maWRlbmNlEjgKB2V4cGVuc2UYBiABKAsyHi'
    '5wcmltZXJwZXNvLmZpbmFuY2UudjEuRXhwZW5zZVIHZXhwZW5zZRJICg1zY29yZV9zdW1tYXJ5'
    'GAcgASgLMiMucHJpbWVycGVzby5maW5hbmNlLnYxLlNjb3JlU3VtbWFyeVIMc2NvcmVTdW1tYX'
    'J5');

@$core.Deprecated('Use getReceiptDraftRequestDescriptor instead')
const GetReceiptDraftRequest$json = {
  '1': 'GetReceiptDraftRequest',
  '2': [
    {'1': 'receipt_id', '3': 1, '4': 1, '5': 9, '10': 'receiptId'},
  ],
};

/// Descriptor for `GetReceiptDraftRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReceiptDraftRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRSZWNlaXB0RHJhZnRSZXF1ZXN0Eh0KCnJlY2VpcHRfaWQYASABKAlSCXJlY2VpcHRJZA'
        '==');

@$core.Deprecated('Use getReceiptDraftResponseDescriptor instead')
const GetReceiptDraftResponse$json = {
  '1': 'GetReceiptDraftResponse',
  '2': [
    {
      '1': 'draft',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.primerpeso.documents.v1.ReceiptDraft',
      '10': 'draft'
    },
  ],
};

/// Descriptor for `GetReceiptDraftResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getReceiptDraftResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRSZWNlaXB0RHJhZnRSZXNwb25zZRI7CgVkcmFmdBgBIAEoCzIlLnByaW1lcnBlc28uZG'
        '9jdW1lbnRzLnYxLlJlY2VpcHREcmFmdFIFZHJhZnQ=');

@$core.Deprecated('Use listReceiptDraftsRequestDescriptor instead')
const ListReceiptDraftsRequest$json = {
  '1': 'ListReceiptDraftsRequest',
  '2': [
    {'1': 'page_size', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListReceiptDraftsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listReceiptDraftsRequestDescriptor =
    $convert.base64Decode(
        'ChhMaXN0UmVjZWlwdERyYWZ0c1JlcXVlc3QSGwoJcGFnZV9zaXplGAEgASgFUghwYWdlU2l6ZQ'
        '==');

@$core.Deprecated('Use listReceiptDraftsResponseDescriptor instead')
const ListReceiptDraftsResponse$json = {
  '1': 'ListReceiptDraftsResponse',
  '2': [
    {
      '1': 'drafts',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.primerpeso.documents.v1.ReceiptDraft',
      '10': 'drafts'
    },
  ],
};

/// Descriptor for `ListReceiptDraftsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listReceiptDraftsResponseDescriptor =
    $convert.base64Decode(
        'ChlMaXN0UmVjZWlwdERyYWZ0c1Jlc3BvbnNlEj0KBmRyYWZ0cxgBIAMoCzIlLnByaW1lcnBlc2'
        '8uZG9jdW1lbnRzLnYxLlJlY2VpcHREcmFmdFIGZHJhZnRz');

const $core.Map<$core.String, $core.dynamic> ReceiptServiceBase$json = {
  '1': 'ReceiptService',
  '2': [
    {
      '1': 'UploadReceipt',
      '2': '.primerpeso.documents.v1.UploadReceiptRequest',
      '3': '.primerpeso.documents.v1.UploadReceiptResponse'
    },
    {
      '1': 'GetReceiptDraft',
      '2': '.primerpeso.documents.v1.GetReceiptDraftRequest',
      '3': '.primerpeso.documents.v1.GetReceiptDraftResponse'
    },
    {
      '1': 'ListReceiptDrafts',
      '2': '.primerpeso.documents.v1.ListReceiptDraftsRequest',
      '3': '.primerpeso.documents.v1.ListReceiptDraftsResponse'
    },
  ],
};

@$core.Deprecated('Use receiptServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ReceiptServiceBase$messageJson = {
  '.primerpeso.documents.v1.UploadReceiptRequest': UploadReceiptRequest$json,
  '.primerpeso.documents.v1.UploadReceiptResponse': UploadReceiptResponse$json,
  '.primerpeso.documents.v1.ReceiptDraft': ReceiptDraft$json,
  '.primerpeso.documents.v1.ReceiptLineItem': ReceiptLineItem$json,
  '.primerpeso.finance.v1.Money': $0.Money$json,
  '.google.protobuf.Timestamp': $1.Timestamp$json,
  '.primerpeso.finance.v1.Expense': $0.Expense$json,
  '.primerpeso.finance.v1.ScoreSummary': $0.ScoreSummary$json,
  '.primerpeso.finance.v1.ScoreFactor': $0.ScoreFactor$json,
  '.primerpeso.documents.v1.GetReceiptDraftRequest':
      GetReceiptDraftRequest$json,
  '.primerpeso.documents.v1.GetReceiptDraftResponse':
      GetReceiptDraftResponse$json,
  '.primerpeso.documents.v1.ListReceiptDraftsRequest':
      ListReceiptDraftsRequest$json,
  '.primerpeso.documents.v1.ListReceiptDraftsResponse':
      ListReceiptDraftsResponse$json,
};

/// Descriptor for `ReceiptService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List receiptServiceDescriptor = $convert.base64Decode(
    'Cg5SZWNlaXB0U2VydmljZRJuCg1VcGxvYWRSZWNlaXB0Ei0ucHJpbWVycGVzby5kb2N1bWVudH'
    'MudjEuVXBsb2FkUmVjZWlwdFJlcXVlc3QaLi5wcmltZXJwZXNvLmRvY3VtZW50cy52MS5VcGxv'
    'YWRSZWNlaXB0UmVzcG9uc2USdAoPR2V0UmVjZWlwdERyYWZ0Ei8ucHJpbWVycGVzby5kb2N1bW'
    'VudHMudjEuR2V0UmVjZWlwdERyYWZ0UmVxdWVzdBowLnByaW1lcnBlc28uZG9jdW1lbnRzLnYx'
    'LkdldFJlY2VpcHREcmFmdFJlc3BvbnNlEnoKEUxpc3RSZWNlaXB0RHJhZnRzEjEucHJpbWVycG'
    'Vzby5kb2N1bWVudHMudjEuTGlzdFJlY2VpcHREcmFmdHNSZXF1ZXN0GjIucHJpbWVycGVzby5k'
    'b2N1bWVudHMudjEuTGlzdFJlY2VpcHREcmFmdHNSZXNwb25zZQ==');
