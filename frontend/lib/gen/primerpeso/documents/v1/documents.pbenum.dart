// This is a generated file - do not edit.
//
// Generated from primerpeso/documents/v1/documents.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ReceiptStatus extends $pb.ProtobufEnum {
  static const ReceiptStatus RECEIPT_STATUS_UNSPECIFIED =
      ReceiptStatus._(0, _omitEnumNames ? '' : 'RECEIPT_STATUS_UNSPECIFIED');
  static const ReceiptStatus RECEIPT_STATUS_PROCESSING =
      ReceiptStatus._(1, _omitEnumNames ? '' : 'RECEIPT_STATUS_PROCESSING');
  static const ReceiptStatus RECEIPT_STATUS_READY =
      ReceiptStatus._(2, _omitEnumNames ? '' : 'RECEIPT_STATUS_READY');
  static const ReceiptStatus RECEIPT_STATUS_FAILED =
      ReceiptStatus._(3, _omitEnumNames ? '' : 'RECEIPT_STATUS_FAILED');

  static const $core.List<ReceiptStatus> values = <ReceiptStatus>[
    RECEIPT_STATUS_UNSPECIFIED,
    RECEIPT_STATUS_PROCESSING,
    RECEIPT_STATUS_READY,
    RECEIPT_STATUS_FAILED,
  ];

  static final $core.List<ReceiptStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ReceiptStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ReceiptStatus._(super.value, super.name);
}

class ExtractionDecision extends $pb.ProtobufEnum {
  static const ExtractionDecision EXTRACTION_DECISION_UNSPECIFIED =
      ExtractionDecision._(
          0, _omitEnumNames ? '' : 'EXTRACTION_DECISION_UNSPECIFIED');
  static const ExtractionDecision EXTRACTION_DECISION_AUTO_REGISTER =
      ExtractionDecision._(
          1, _omitEnumNames ? '' : 'EXTRACTION_DECISION_AUTO_REGISTER');
  static const ExtractionDecision EXTRACTION_DECISION_NEEDS_CLARIFICATION =
      ExtractionDecision._(
          2, _omitEnumNames ? '' : 'EXTRACTION_DECISION_NEEDS_CLARIFICATION');

  static const $core.List<ExtractionDecision> values = <ExtractionDecision>[
    EXTRACTION_DECISION_UNSPECIFIED,
    EXTRACTION_DECISION_AUTO_REGISTER,
    EXTRACTION_DECISION_NEEDS_CLARIFICATION,
  ];

  static final $core.List<ExtractionDecision?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ExtractionDecision? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ExtractionDecision._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
