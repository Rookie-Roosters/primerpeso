// This is a generated file - do not edit.
//
// Generated from primerpeso/savings/v1/savings.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RecurrenceFrequency extends $pb.ProtobufEnum {
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_UNSPECIFIED =
      RecurrenceFrequency._(
          0, _omitEnumNames ? '' : 'RECURRENCE_FREQUENCY_UNSPECIFIED');
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_DAILY =
      RecurrenceFrequency._(
          1, _omitEnumNames ? '' : 'RECURRENCE_FREQUENCY_DAILY');
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_WEEKLY =
      RecurrenceFrequency._(
          2, _omitEnumNames ? '' : 'RECURRENCE_FREQUENCY_WEEKLY');
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_MONTHLY =
      RecurrenceFrequency._(
          3, _omitEnumNames ? '' : 'RECURRENCE_FREQUENCY_MONTHLY');
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_YEARLY =
      RecurrenceFrequency._(
          4, _omitEnumNames ? '' : 'RECURRENCE_FREQUENCY_YEARLY');

  static const $core.List<RecurrenceFrequency> values = <RecurrenceFrequency>[
    RECURRENCE_FREQUENCY_UNSPECIFIED,
    RECURRENCE_FREQUENCY_DAILY,
    RECURRENCE_FREQUENCY_WEEKLY,
    RECURRENCE_FREQUENCY_MONTHLY,
    RECURRENCE_FREQUENCY_YEARLY,
  ];

  static final $core.List<RecurrenceFrequency?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static RecurrenceFrequency? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RecurrenceFrequency._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
