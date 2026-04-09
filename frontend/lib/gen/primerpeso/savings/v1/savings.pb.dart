// This is a generated file - do not edit.
//
// Generated from primerpeso/savings/v1/savings.proto.

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
    as $1;

import '../../finance/v1/finance.pb.dart' as $0;
import 'savings.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'savings.pbenum.dart';

class Apartado extends $pb.GeneratedMessage {
  factory Apartado({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $0.Money? currentAmount,
    $0.Money? targetAmount,
    $core.String? financialGoalId,
    $core.bool? isActive,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (financialGoalId != null) result.financialGoalId = financialGoalId;
    if (isActive != null) result.isActive = isActive;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Apartado._();

  factory Apartado.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Apartado.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Apartado',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOM<$0.Money>(4, _omitFieldNames ? '' : 'currentAmount',
        subBuilder: $0.Money.create)
    ..aOM<$0.Money>(5, _omitFieldNames ? '' : 'targetAmount',
        subBuilder: $0.Money.create)
    ..aOS(6, _omitFieldNames ? '' : 'financialGoalId')
    ..aOB(7, _omitFieldNames ? '' : 'isActive')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Apartado clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Apartado copyWith(void Function(Apartado) updates) =>
      super.copyWith((message) => updates(message as Apartado)) as Apartado;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Apartado create() => Apartado._();
  @$core.override
  Apartado createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Apartado getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Apartado>(create);
  static Apartado? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Money get currentAmount => $_getN(3);
  @$pb.TagNumber(4)
  set currentAmount($0.Money value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentAmount() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Money ensureCurrentAmount() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.Money get targetAmount => $_getN(4);
  @$pb.TagNumber(5)
  set targetAmount($0.Money value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAmount() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Money ensureTargetAmount() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get financialGoalId => $_getSZ(5);
  @$pb.TagNumber(6)
  set financialGoalId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFinancialGoalId() => $_has(5);
  @$pb.TagNumber(6)
  void clearFinancialGoalId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isActive => $_getBF(6);
  @$pb.TagNumber(7)
  set isActive($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsActive() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsActive() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get updatedAt => $_getN(8);
  @$pb.TagNumber(9)
  set updatedAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureUpdatedAt() => $_ensure(8);
}

class FinancialGoal extends $pb.GeneratedMessage {
  factory FinancialGoal({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $0.Money? targetAmount,
    $0.Money? currentAmount,
    $1.Timestamp? targetDate,
    $core.bool? isActive,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (targetDate != null) result.targetDate = targetDate;
    if (isActive != null) result.isActive = isActive;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  FinancialGoal._();

  factory FinancialGoal.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FinancialGoal.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FinancialGoal',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOM<$0.Money>(4, _omitFieldNames ? '' : 'targetAmount',
        subBuilder: $0.Money.create)
    ..aOM<$0.Money>(5, _omitFieldNames ? '' : 'currentAmount',
        subBuilder: $0.Money.create)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'targetDate',
        subBuilder: $1.Timestamp.create)
    ..aOB(7, _omitFieldNames ? '' : 'isActive')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinancialGoal clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinancialGoal copyWith(void Function(FinancialGoal) updates) =>
      super.copyWith((message) => updates(message as FinancialGoal))
          as FinancialGoal;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinancialGoal create() => FinancialGoal._();
  @$core.override
  FinancialGoal createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FinancialGoal getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FinancialGoal>(create);
  static FinancialGoal? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Money get targetAmount => $_getN(3);
  @$pb.TagNumber(4)
  set targetAmount($0.Money value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetAmount() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Money ensureTargetAmount() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.Money get currentAmount => $_getN(4);
  @$pb.TagNumber(5)
  set currentAmount($0.Money value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrentAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentAmount() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Money ensureCurrentAmount() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Timestamp get targetDate => $_getN(5);
  @$pb.TagNumber(6)
  set targetDate($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasTargetDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetDate() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureTargetDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get isActive => $_getBF(6);
  @$pb.TagNumber(7)
  set isActive($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsActive() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsActive() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get updatedAt => $_getN(8);
  @$pb.TagNumber(9)
  set updatedAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureUpdatedAt() => $_ensure(8);
}

class RecurringPaymentReminder extends $pb.GeneratedMessage {
  factory RecurringPaymentReminder({
    $core.String? id,
    $core.String? title,
    $core.String? payee,
    $0.Money? amount,
    RecurrenceFrequency? frequency,
    $core.int? interval,
    $core.int? dayOfWeek,
    $core.int? dayOfMonth,
    $core.int? monthOfYear,
    $core.String? localTime,
    $core.String? timezone,
    $1.Timestamp? nextDueAt,
    $core.bool? isActive,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (payee != null) result.payee = payee;
    if (amount != null) result.amount = amount;
    if (frequency != null) result.frequency = frequency;
    if (interval != null) result.interval = interval;
    if (dayOfWeek != null) result.dayOfWeek = dayOfWeek;
    if (dayOfMonth != null) result.dayOfMonth = dayOfMonth;
    if (monthOfYear != null) result.monthOfYear = monthOfYear;
    if (localTime != null) result.localTime = localTime;
    if (timezone != null) result.timezone = timezone;
    if (nextDueAt != null) result.nextDueAt = nextDueAt;
    if (isActive != null) result.isActive = isActive;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  RecurringPaymentReminder._();

  factory RecurringPaymentReminder.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecurringPaymentReminder.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecurringPaymentReminder',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'payee')
    ..aOM<$0.Money>(4, _omitFieldNames ? '' : 'amount',
        subBuilder: $0.Money.create)
    ..aE<RecurrenceFrequency>(5, _omitFieldNames ? '' : 'frequency',
        enumValues: RecurrenceFrequency.values)
    ..aI(6, _omitFieldNames ? '' : 'interval')
    ..aI(7, _omitFieldNames ? '' : 'dayOfWeek')
    ..aI(8, _omitFieldNames ? '' : 'dayOfMonth')
    ..aI(9, _omitFieldNames ? '' : 'monthOfYear')
    ..aOS(10, _omitFieldNames ? '' : 'localTime')
    ..aOS(11, _omitFieldNames ? '' : 'timezone')
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'nextDueAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(13, _omitFieldNames ? '' : 'isActive')
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringPaymentReminder clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecurringPaymentReminder copyWith(
          void Function(RecurringPaymentReminder) updates) =>
      super.copyWith((message) => updates(message as RecurringPaymentReminder))
          as RecurringPaymentReminder;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecurringPaymentReminder create() => RecurringPaymentReminder._();
  @$core.override
  RecurringPaymentReminder createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecurringPaymentReminder getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecurringPaymentReminder>(create);
  static RecurringPaymentReminder? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get payee => $_getSZ(2);
  @$pb.TagNumber(3)
  set payee($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPayee() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayee() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Money get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($0.Money value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Money ensureAmount() => $_ensure(3);

  @$pb.TagNumber(5)
  RecurrenceFrequency get frequency => $_getN(4);
  @$pb.TagNumber(5)
  set frequency(RecurrenceFrequency value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFrequency() => $_has(4);
  @$pb.TagNumber(5)
  void clearFrequency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get interval => $_getIZ(5);
  @$pb.TagNumber(6)
  set interval($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasInterval() => $_has(5);
  @$pb.TagNumber(6)
  void clearInterval() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get dayOfWeek => $_getIZ(6);
  @$pb.TagNumber(7)
  set dayOfWeek($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDayOfWeek() => $_has(6);
  @$pb.TagNumber(7)
  void clearDayOfWeek() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get dayOfMonth => $_getIZ(7);
  @$pb.TagNumber(8)
  set dayOfMonth($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDayOfMonth() => $_has(7);
  @$pb.TagNumber(8)
  void clearDayOfMonth() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get monthOfYear => $_getIZ(8);
  @$pb.TagNumber(9)
  set monthOfYear($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMonthOfYear() => $_has(8);
  @$pb.TagNumber(9)
  void clearMonthOfYear() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get localTime => $_getSZ(9);
  @$pb.TagNumber(10)
  set localTime($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLocalTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearLocalTime() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get timezone => $_getSZ(10);
  @$pb.TagNumber(11)
  set timezone($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTimezone() => $_has(10);
  @$pb.TagNumber(11)
  void clearTimezone() => $_clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get nextDueAt => $_getN(11);
  @$pb.TagNumber(12)
  set nextDueAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasNextDueAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearNextDueAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureNextDueAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.bool get isActive => $_getBF(12);
  @$pb.TagNumber(13)
  set isActive($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIsActive() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsActive() => $_clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get updatedAt => $_getN(14);
  @$pb.TagNumber(15)
  set updatedAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearUpdatedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureUpdatedAt() => $_ensure(14);
}

class CreateApartadoRequest extends $pb.GeneratedMessage {
  factory CreateApartadoRequest({
    $core.String? name,
    $core.String? description,
    $0.Money? currentAmount,
    $0.Money? targetAmount,
    $core.String? financialGoalId,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (financialGoalId != null) result.financialGoalId = financialGoalId;
    return result;
  }

  CreateApartadoRequest._();

  factory CreateApartadoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateApartadoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateApartadoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOM<$0.Money>(3, _omitFieldNames ? '' : 'currentAmount',
        subBuilder: $0.Money.create)
    ..aOM<$0.Money>(4, _omitFieldNames ? '' : 'targetAmount',
        subBuilder: $0.Money.create)
    ..aOS(5, _omitFieldNames ? '' : 'financialGoalId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateApartadoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateApartadoRequest copyWith(
          void Function(CreateApartadoRequest) updates) =>
      super.copyWith((message) => updates(message as CreateApartadoRequest))
          as CreateApartadoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateApartadoRequest create() => CreateApartadoRequest._();
  @$core.override
  CreateApartadoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateApartadoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateApartadoRequest>(create);
  static CreateApartadoRequest? _defaultInstance;

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
  $0.Money get currentAmount => $_getN(2);
  @$pb.TagNumber(3)
  set currentAmount($0.Money value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentAmount() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Money ensureCurrentAmount() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.Money get targetAmount => $_getN(3);
  @$pb.TagNumber(4)
  set targetAmount($0.Money value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetAmount() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Money ensureTargetAmount() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get financialGoalId => $_getSZ(4);
  @$pb.TagNumber(5)
  set financialGoalId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFinancialGoalId() => $_has(4);
  @$pb.TagNumber(5)
  void clearFinancialGoalId() => $_clearField(5);
}

class CreateApartadoResponse extends $pb.GeneratedMessage {
  factory CreateApartadoResponse({
    Apartado? apartado,
  }) {
    final result = create();
    if (apartado != null) result.apartado = apartado;
    return result;
  }

  CreateApartadoResponse._();

  factory CreateApartadoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateApartadoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateApartadoResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<Apartado>(1, _omitFieldNames ? '' : 'apartado',
        subBuilder: Apartado.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateApartadoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateApartadoResponse copyWith(
          void Function(CreateApartadoResponse) updates) =>
      super.copyWith((message) => updates(message as CreateApartadoResponse))
          as CreateApartadoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateApartadoResponse create() => CreateApartadoResponse._();
  @$core.override
  CreateApartadoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateApartadoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateApartadoResponse>(create);
  static CreateApartadoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Apartado get apartado => $_getN(0);
  @$pb.TagNumber(1)
  set apartado(Apartado value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasApartado() => $_has(0);
  @$pb.TagNumber(1)
  void clearApartado() => $_clearField(1);
  @$pb.TagNumber(1)
  Apartado ensureApartado() => $_ensure(0);
}

class GetApartadoRequest extends $pb.GeneratedMessage {
  factory GetApartadoRequest({
    $core.String? apartadoId,
  }) {
    final result = create();
    if (apartadoId != null) result.apartadoId = apartadoId;
    return result;
  }

  GetApartadoRequest._();

  factory GetApartadoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetApartadoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetApartadoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'apartadoId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetApartadoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetApartadoRequest copyWith(void Function(GetApartadoRequest) updates) =>
      super.copyWith((message) => updates(message as GetApartadoRequest))
          as GetApartadoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetApartadoRequest create() => GetApartadoRequest._();
  @$core.override
  GetApartadoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetApartadoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetApartadoRequest>(create);
  static GetApartadoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get apartadoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set apartadoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApartadoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApartadoId() => $_clearField(1);
}

class GetApartadoResponse extends $pb.GeneratedMessage {
  factory GetApartadoResponse({
    Apartado? apartado,
  }) {
    final result = create();
    if (apartado != null) result.apartado = apartado;
    return result;
  }

  GetApartadoResponse._();

  factory GetApartadoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetApartadoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetApartadoResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<Apartado>(1, _omitFieldNames ? '' : 'apartado',
        subBuilder: Apartado.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetApartadoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetApartadoResponse copyWith(void Function(GetApartadoResponse) updates) =>
      super.copyWith((message) => updates(message as GetApartadoResponse))
          as GetApartadoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetApartadoResponse create() => GetApartadoResponse._();
  @$core.override
  GetApartadoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetApartadoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetApartadoResponse>(create);
  static GetApartadoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Apartado get apartado => $_getN(0);
  @$pb.TagNumber(1)
  set apartado(Apartado value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasApartado() => $_has(0);
  @$pb.TagNumber(1)
  void clearApartado() => $_clearField(1);
  @$pb.TagNumber(1)
  Apartado ensureApartado() => $_ensure(0);
}

class ListApartadosRequest extends $pb.GeneratedMessage {
  factory ListApartadosRequest({
    $core.int? pageSize,
  }) {
    final result = create();
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListApartadosRequest._();

  factory ListApartadosRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListApartadosRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListApartadosRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'pageSize')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListApartadosRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListApartadosRequest copyWith(void Function(ListApartadosRequest) updates) =>
      super.copyWith((message) => updates(message as ListApartadosRequest))
          as ListApartadosRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListApartadosRequest create() => ListApartadosRequest._();
  @$core.override
  ListApartadosRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListApartadosRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListApartadosRequest>(create);
  static ListApartadosRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);
}

class ListApartadosResponse extends $pb.GeneratedMessage {
  factory ListApartadosResponse({
    $core.Iterable<Apartado>? apartados,
  }) {
    final result = create();
    if (apartados != null) result.apartados.addAll(apartados);
    return result;
  }

  ListApartadosResponse._();

  factory ListApartadosResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListApartadosResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListApartadosResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..pPM<Apartado>(1, _omitFieldNames ? '' : 'apartados',
        subBuilder: Apartado.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListApartadosResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListApartadosResponse copyWith(
          void Function(ListApartadosResponse) updates) =>
      super.copyWith((message) => updates(message as ListApartadosResponse))
          as ListApartadosResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListApartadosResponse create() => ListApartadosResponse._();
  @$core.override
  ListApartadosResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListApartadosResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListApartadosResponse>(create);
  static ListApartadosResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Apartado> get apartados => $_getList(0);
}

class UpdateApartadoRequest extends $pb.GeneratedMessage {
  factory UpdateApartadoRequest({
    $core.String? apartadoId,
    $core.String? name,
    $core.String? description,
    $0.Money? currentAmount,
    $0.Money? targetAmount,
    $core.String? financialGoalId,
  }) {
    final result = create();
    if (apartadoId != null) result.apartadoId = apartadoId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (currentAmount != null) result.currentAmount = currentAmount;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (financialGoalId != null) result.financialGoalId = financialGoalId;
    return result;
  }

  UpdateApartadoRequest._();

  factory UpdateApartadoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateApartadoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateApartadoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'apartadoId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOM<$0.Money>(4, _omitFieldNames ? '' : 'currentAmount',
        subBuilder: $0.Money.create)
    ..aOM<$0.Money>(5, _omitFieldNames ? '' : 'targetAmount',
        subBuilder: $0.Money.create)
    ..aOS(6, _omitFieldNames ? '' : 'financialGoalId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateApartadoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateApartadoRequest copyWith(
          void Function(UpdateApartadoRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateApartadoRequest))
          as UpdateApartadoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateApartadoRequest create() => UpdateApartadoRequest._();
  @$core.override
  UpdateApartadoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateApartadoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateApartadoRequest>(create);
  static UpdateApartadoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get apartadoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set apartadoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApartadoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApartadoId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Money get currentAmount => $_getN(3);
  @$pb.TagNumber(4)
  set currentAmount($0.Money value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentAmount() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Money ensureCurrentAmount() => $_ensure(3);

  @$pb.TagNumber(5)
  $0.Money get targetAmount => $_getN(4);
  @$pb.TagNumber(5)
  set targetAmount($0.Money value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetAmount() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Money ensureTargetAmount() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get financialGoalId => $_getSZ(5);
  @$pb.TagNumber(6)
  set financialGoalId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFinancialGoalId() => $_has(5);
  @$pb.TagNumber(6)
  void clearFinancialGoalId() => $_clearField(6);
}

class UpdateApartadoResponse extends $pb.GeneratedMessage {
  factory UpdateApartadoResponse({
    Apartado? apartado,
  }) {
    final result = create();
    if (apartado != null) result.apartado = apartado;
    return result;
  }

  UpdateApartadoResponse._();

  factory UpdateApartadoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateApartadoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateApartadoResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<Apartado>(1, _omitFieldNames ? '' : 'apartado',
        subBuilder: Apartado.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateApartadoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateApartadoResponse copyWith(
          void Function(UpdateApartadoResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateApartadoResponse))
          as UpdateApartadoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateApartadoResponse create() => UpdateApartadoResponse._();
  @$core.override
  UpdateApartadoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateApartadoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateApartadoResponse>(create);
  static UpdateApartadoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Apartado get apartado => $_getN(0);
  @$pb.TagNumber(1)
  set apartado(Apartado value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasApartado() => $_has(0);
  @$pb.TagNumber(1)
  void clearApartado() => $_clearField(1);
  @$pb.TagNumber(1)
  Apartado ensureApartado() => $_ensure(0);
}

class DeleteApartadoRequest extends $pb.GeneratedMessage {
  factory DeleteApartadoRequest({
    $core.String? apartadoId,
  }) {
    final result = create();
    if (apartadoId != null) result.apartadoId = apartadoId;
    return result;
  }

  DeleteApartadoRequest._();

  factory DeleteApartadoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteApartadoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteApartadoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'apartadoId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteApartadoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteApartadoRequest copyWith(
          void Function(DeleteApartadoRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteApartadoRequest))
          as DeleteApartadoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteApartadoRequest create() => DeleteApartadoRequest._();
  @$core.override
  DeleteApartadoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteApartadoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteApartadoRequest>(create);
  static DeleteApartadoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get apartadoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set apartadoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApartadoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearApartadoId() => $_clearField(1);
}

class DeleteApartadoResponse extends $pb.GeneratedMessage {
  factory DeleteApartadoResponse({
    Apartado? apartado,
  }) {
    final result = create();
    if (apartado != null) result.apartado = apartado;
    return result;
  }

  DeleteApartadoResponse._();

  factory DeleteApartadoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteApartadoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteApartadoResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<Apartado>(1, _omitFieldNames ? '' : 'apartado',
        subBuilder: Apartado.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteApartadoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteApartadoResponse copyWith(
          void Function(DeleteApartadoResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteApartadoResponse))
          as DeleteApartadoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteApartadoResponse create() => DeleteApartadoResponse._();
  @$core.override
  DeleteApartadoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteApartadoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteApartadoResponse>(create);
  static DeleteApartadoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Apartado get apartado => $_getN(0);
  @$pb.TagNumber(1)
  set apartado(Apartado value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasApartado() => $_has(0);
  @$pb.TagNumber(1)
  void clearApartado() => $_clearField(1);
  @$pb.TagNumber(1)
  Apartado ensureApartado() => $_ensure(0);
}

class CreateFinancialGoalRequest extends $pb.GeneratedMessage {
  factory CreateFinancialGoalRequest({
    $core.String? name,
    $core.String? description,
    $0.Money? targetAmount,
    $1.Timestamp? targetDate,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (targetDate != null) result.targetDate = targetDate;
    return result;
  }

  CreateFinancialGoalRequest._();

  factory CreateFinancialGoalRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateFinancialGoalRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateFinancialGoalRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOM<$0.Money>(3, _omitFieldNames ? '' : 'targetAmount',
        subBuilder: $0.Money.create)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'targetDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFinancialGoalRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFinancialGoalRequest copyWith(
          void Function(CreateFinancialGoalRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateFinancialGoalRequest))
          as CreateFinancialGoalRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalRequest create() => CreateFinancialGoalRequest._();
  @$core.override
  CreateFinancialGoalRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateFinancialGoalRequest>(create);
  static CreateFinancialGoalRequest? _defaultInstance;

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
  $0.Money get targetAmount => $_getN(2);
  @$pb.TagNumber(3)
  set targetAmount($0.Money value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTargetAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetAmount() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Money ensureTargetAmount() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Timestamp get targetDate => $_getN(3);
  @$pb.TagNumber(4)
  set targetDate($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetDate() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureTargetDate() => $_ensure(3);
}

class CreateFinancialGoalResponse extends $pb.GeneratedMessage {
  factory CreateFinancialGoalResponse({
    FinancialGoal? financialGoal,
  }) {
    final result = create();
    if (financialGoal != null) result.financialGoal = financialGoal;
    return result;
  }

  CreateFinancialGoalResponse._();

  factory CreateFinancialGoalResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateFinancialGoalResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateFinancialGoalResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<FinancialGoal>(1, _omitFieldNames ? '' : 'financialGoal',
        subBuilder: FinancialGoal.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFinancialGoalResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFinancialGoalResponse copyWith(
          void Function(CreateFinancialGoalResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateFinancialGoalResponse))
          as CreateFinancialGoalResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalResponse create() =>
      CreateFinancialGoalResponse._();
  @$core.override
  CreateFinancialGoalResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateFinancialGoalResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateFinancialGoalResponse>(create);
  static CreateFinancialGoalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FinancialGoal get financialGoal => $_getN(0);
  @$pb.TagNumber(1)
  set financialGoal(FinancialGoal value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFinancialGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearFinancialGoal() => $_clearField(1);
  @$pb.TagNumber(1)
  FinancialGoal ensureFinancialGoal() => $_ensure(0);
}

class GetFinancialGoalRequest extends $pb.GeneratedMessage {
  factory GetFinancialGoalRequest({
    $core.String? financialGoalId,
  }) {
    final result = create();
    if (financialGoalId != null) result.financialGoalId = financialGoalId;
    return result;
  }

  GetFinancialGoalRequest._();

  factory GetFinancialGoalRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFinancialGoalRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFinancialGoalRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'financialGoalId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFinancialGoalRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFinancialGoalRequest copyWith(
          void Function(GetFinancialGoalRequest) updates) =>
      super.copyWith((message) => updates(message as GetFinancialGoalRequest))
          as GetFinancialGoalRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalRequest create() => GetFinancialGoalRequest._();
  @$core.override
  GetFinancialGoalRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFinancialGoalRequest>(create);
  static GetFinancialGoalRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get financialGoalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set financialGoalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFinancialGoalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFinancialGoalId() => $_clearField(1);
}

class GetFinancialGoalResponse extends $pb.GeneratedMessage {
  factory GetFinancialGoalResponse({
    FinancialGoal? financialGoal,
  }) {
    final result = create();
    if (financialGoal != null) result.financialGoal = financialGoal;
    return result;
  }

  GetFinancialGoalResponse._();

  factory GetFinancialGoalResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFinancialGoalResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFinancialGoalResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<FinancialGoal>(1, _omitFieldNames ? '' : 'financialGoal',
        subBuilder: FinancialGoal.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFinancialGoalResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFinancialGoalResponse copyWith(
          void Function(GetFinancialGoalResponse) updates) =>
      super.copyWith((message) => updates(message as GetFinancialGoalResponse))
          as GetFinancialGoalResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalResponse create() => GetFinancialGoalResponse._();
  @$core.override
  GetFinancialGoalResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFinancialGoalResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFinancialGoalResponse>(create);
  static GetFinancialGoalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FinancialGoal get financialGoal => $_getN(0);
  @$pb.TagNumber(1)
  set financialGoal(FinancialGoal value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFinancialGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearFinancialGoal() => $_clearField(1);
  @$pb.TagNumber(1)
  FinancialGoal ensureFinancialGoal() => $_ensure(0);
}

class ListFinancialGoalsRequest extends $pb.GeneratedMessage {
  factory ListFinancialGoalsRequest({
    $core.int? pageSize,
  }) {
    final result = create();
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListFinancialGoalsRequest._();

  factory ListFinancialGoalsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListFinancialGoalsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListFinancialGoalsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'pageSize')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListFinancialGoalsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListFinancialGoalsRequest copyWith(
          void Function(ListFinancialGoalsRequest) updates) =>
      super.copyWith((message) => updates(message as ListFinancialGoalsRequest))
          as ListFinancialGoalsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListFinancialGoalsRequest create() => ListFinancialGoalsRequest._();
  @$core.override
  ListFinancialGoalsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListFinancialGoalsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListFinancialGoalsRequest>(create);
  static ListFinancialGoalsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);
}

class ListFinancialGoalsResponse extends $pb.GeneratedMessage {
  factory ListFinancialGoalsResponse({
    $core.Iterable<FinancialGoal>? financialGoals,
  }) {
    final result = create();
    if (financialGoals != null) result.financialGoals.addAll(financialGoals);
    return result;
  }

  ListFinancialGoalsResponse._();

  factory ListFinancialGoalsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListFinancialGoalsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListFinancialGoalsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..pPM<FinancialGoal>(1, _omitFieldNames ? '' : 'financialGoals',
        subBuilder: FinancialGoal.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListFinancialGoalsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListFinancialGoalsResponse copyWith(
          void Function(ListFinancialGoalsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListFinancialGoalsResponse))
          as ListFinancialGoalsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListFinancialGoalsResponse create() => ListFinancialGoalsResponse._();
  @$core.override
  ListFinancialGoalsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListFinancialGoalsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListFinancialGoalsResponse>(create);
  static ListFinancialGoalsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FinancialGoal> get financialGoals => $_getList(0);
}

class UpdateFinancialGoalRequest extends $pb.GeneratedMessage {
  factory UpdateFinancialGoalRequest({
    $core.String? financialGoalId,
    $core.String? name,
    $core.String? description,
    $0.Money? targetAmount,
    $1.Timestamp? targetDate,
  }) {
    final result = create();
    if (financialGoalId != null) result.financialGoalId = financialGoalId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (targetAmount != null) result.targetAmount = targetAmount;
    if (targetDate != null) result.targetDate = targetDate;
    return result;
  }

  UpdateFinancialGoalRequest._();

  factory UpdateFinancialGoalRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFinancialGoalRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFinancialGoalRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'financialGoalId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOM<$0.Money>(4, _omitFieldNames ? '' : 'targetAmount',
        subBuilder: $0.Money.create)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'targetDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFinancialGoalRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFinancialGoalRequest copyWith(
          void Function(UpdateFinancialGoalRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateFinancialGoalRequest))
          as UpdateFinancialGoalRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalRequest create() => UpdateFinancialGoalRequest._();
  @$core.override
  UpdateFinancialGoalRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFinancialGoalRequest>(create);
  static UpdateFinancialGoalRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get financialGoalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set financialGoalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFinancialGoalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFinancialGoalId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Money get targetAmount => $_getN(3);
  @$pb.TagNumber(4)
  set targetAmount($0.Money value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetAmount() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Money ensureTargetAmount() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Timestamp get targetDate => $_getN(4);
  @$pb.TagNumber(5)
  set targetDate($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetDate() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureTargetDate() => $_ensure(4);
}

class UpdateFinancialGoalResponse extends $pb.GeneratedMessage {
  factory UpdateFinancialGoalResponse({
    FinancialGoal? financialGoal,
  }) {
    final result = create();
    if (financialGoal != null) result.financialGoal = financialGoal;
    return result;
  }

  UpdateFinancialGoalResponse._();

  factory UpdateFinancialGoalResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFinancialGoalResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFinancialGoalResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<FinancialGoal>(1, _omitFieldNames ? '' : 'financialGoal',
        subBuilder: FinancialGoal.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFinancialGoalResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFinancialGoalResponse copyWith(
          void Function(UpdateFinancialGoalResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateFinancialGoalResponse))
          as UpdateFinancialGoalResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalResponse create() =>
      UpdateFinancialGoalResponse._();
  @$core.override
  UpdateFinancialGoalResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateFinancialGoalResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFinancialGoalResponse>(create);
  static UpdateFinancialGoalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FinancialGoal get financialGoal => $_getN(0);
  @$pb.TagNumber(1)
  set financialGoal(FinancialGoal value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFinancialGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearFinancialGoal() => $_clearField(1);
  @$pb.TagNumber(1)
  FinancialGoal ensureFinancialGoal() => $_ensure(0);
}

class DeleteFinancialGoalRequest extends $pb.GeneratedMessage {
  factory DeleteFinancialGoalRequest({
    $core.String? financialGoalId,
  }) {
    final result = create();
    if (financialGoalId != null) result.financialGoalId = financialGoalId;
    return result;
  }

  DeleteFinancialGoalRequest._();

  factory DeleteFinancialGoalRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteFinancialGoalRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteFinancialGoalRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'financialGoalId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteFinancialGoalRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteFinancialGoalRequest copyWith(
          void Function(DeleteFinancialGoalRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteFinancialGoalRequest))
          as DeleteFinancialGoalRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteFinancialGoalRequest create() => DeleteFinancialGoalRequest._();
  @$core.override
  DeleteFinancialGoalRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteFinancialGoalRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteFinancialGoalRequest>(create);
  static DeleteFinancialGoalRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get financialGoalId => $_getSZ(0);
  @$pb.TagNumber(1)
  set financialGoalId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFinancialGoalId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFinancialGoalId() => $_clearField(1);
}

class DeleteFinancialGoalResponse extends $pb.GeneratedMessage {
  factory DeleteFinancialGoalResponse({
    FinancialGoal? financialGoal,
  }) {
    final result = create();
    if (financialGoal != null) result.financialGoal = financialGoal;
    return result;
  }

  DeleteFinancialGoalResponse._();

  factory DeleteFinancialGoalResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteFinancialGoalResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteFinancialGoalResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<FinancialGoal>(1, _omitFieldNames ? '' : 'financialGoal',
        subBuilder: FinancialGoal.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteFinancialGoalResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteFinancialGoalResponse copyWith(
          void Function(DeleteFinancialGoalResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteFinancialGoalResponse))
          as DeleteFinancialGoalResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteFinancialGoalResponse create() =>
      DeleteFinancialGoalResponse._();
  @$core.override
  DeleteFinancialGoalResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteFinancialGoalResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteFinancialGoalResponse>(create);
  static DeleteFinancialGoalResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FinancialGoal get financialGoal => $_getN(0);
  @$pb.TagNumber(1)
  set financialGoal(FinancialGoal value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFinancialGoal() => $_has(0);
  @$pb.TagNumber(1)
  void clearFinancialGoal() => $_clearField(1);
  @$pb.TagNumber(1)
  FinancialGoal ensureFinancialGoal() => $_ensure(0);
}

class CreateRecurringPaymentReminderRequest extends $pb.GeneratedMessage {
  factory CreateRecurringPaymentReminderRequest({
    $core.String? title,
    $core.String? payee,
    $0.Money? amount,
    RecurrenceFrequency? frequency,
    $core.int? interval,
    $core.int? dayOfWeek,
    $core.int? dayOfMonth,
    $core.int? monthOfYear,
    $core.String? localTime,
    $core.String? timezone,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (payee != null) result.payee = payee;
    if (amount != null) result.amount = amount;
    if (frequency != null) result.frequency = frequency;
    if (interval != null) result.interval = interval;
    if (dayOfWeek != null) result.dayOfWeek = dayOfWeek;
    if (dayOfMonth != null) result.dayOfMonth = dayOfMonth;
    if (monthOfYear != null) result.monthOfYear = monthOfYear;
    if (localTime != null) result.localTime = localTime;
    if (timezone != null) result.timezone = timezone;
    return result;
  }

  CreateRecurringPaymentReminderRequest._();

  factory CreateRecurringPaymentReminderRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateRecurringPaymentReminderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateRecurringPaymentReminderRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'payee')
    ..aOM<$0.Money>(3, _omitFieldNames ? '' : 'amount',
        subBuilder: $0.Money.create)
    ..aE<RecurrenceFrequency>(4, _omitFieldNames ? '' : 'frequency',
        enumValues: RecurrenceFrequency.values)
    ..aI(5, _omitFieldNames ? '' : 'interval')
    ..aI(6, _omitFieldNames ? '' : 'dayOfWeek')
    ..aI(7, _omitFieldNames ? '' : 'dayOfMonth')
    ..aI(8, _omitFieldNames ? '' : 'monthOfYear')
    ..aOS(9, _omitFieldNames ? '' : 'localTime')
    ..aOS(10, _omitFieldNames ? '' : 'timezone')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringPaymentReminderRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringPaymentReminderRequest copyWith(
          void Function(CreateRecurringPaymentReminderRequest) updates) =>
      super.copyWith((message) =>
              updates(message as CreateRecurringPaymentReminderRequest))
          as CreateRecurringPaymentReminderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRecurringPaymentReminderRequest create() =>
      CreateRecurringPaymentReminderRequest._();
  @$core.override
  CreateRecurringPaymentReminderRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateRecurringPaymentReminderRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          CreateRecurringPaymentReminderRequest>(create);
  static CreateRecurringPaymentReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get payee => $_getSZ(1);
  @$pb.TagNumber(2)
  set payee($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPayee() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayee() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.Money get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($0.Money value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Money ensureAmount() => $_ensure(2);

  @$pb.TagNumber(4)
  RecurrenceFrequency get frequency => $_getN(3);
  @$pb.TagNumber(4)
  set frequency(RecurrenceFrequency value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFrequency() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrequency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get interval => $_getIZ(4);
  @$pb.TagNumber(5)
  set interval($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInterval() => $_has(4);
  @$pb.TagNumber(5)
  void clearInterval() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get dayOfWeek => $_getIZ(5);
  @$pb.TagNumber(6)
  set dayOfWeek($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDayOfWeek() => $_has(5);
  @$pb.TagNumber(6)
  void clearDayOfWeek() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get dayOfMonth => $_getIZ(6);
  @$pb.TagNumber(7)
  set dayOfMonth($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDayOfMonth() => $_has(6);
  @$pb.TagNumber(7)
  void clearDayOfMonth() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get monthOfYear => $_getIZ(7);
  @$pb.TagNumber(8)
  set monthOfYear($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMonthOfYear() => $_has(7);
  @$pb.TagNumber(8)
  void clearMonthOfYear() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get localTime => $_getSZ(8);
  @$pb.TagNumber(9)
  set localTime($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasLocalTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearLocalTime() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get timezone => $_getSZ(9);
  @$pb.TagNumber(10)
  set timezone($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTimezone() => $_has(9);
  @$pb.TagNumber(10)
  void clearTimezone() => $_clearField(10);
}

class CreateRecurringPaymentReminderResponse extends $pb.GeneratedMessage {
  factory CreateRecurringPaymentReminderResponse({
    RecurringPaymentReminder? recurringPaymentReminder,
  }) {
    final result = create();
    if (recurringPaymentReminder != null)
      result.recurringPaymentReminder = recurringPaymentReminder;
    return result;
  }

  CreateRecurringPaymentReminderResponse._();

  factory CreateRecurringPaymentReminderResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateRecurringPaymentReminderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateRecurringPaymentReminderResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<RecurringPaymentReminder>(
        1, _omitFieldNames ? '' : 'recurringPaymentReminder',
        subBuilder: RecurringPaymentReminder.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringPaymentReminderResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRecurringPaymentReminderResponse copyWith(
          void Function(CreateRecurringPaymentReminderResponse) updates) =>
      super.copyWith((message) =>
              updates(message as CreateRecurringPaymentReminderResponse))
          as CreateRecurringPaymentReminderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRecurringPaymentReminderResponse create() =>
      CreateRecurringPaymentReminderResponse._();
  @$core.override
  CreateRecurringPaymentReminderResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateRecurringPaymentReminderResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          CreateRecurringPaymentReminderResponse>(create);
  static CreateRecurringPaymentReminderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  RecurringPaymentReminder get recurringPaymentReminder => $_getN(0);
  @$pb.TagNumber(1)
  set recurringPaymentReminder(RecurringPaymentReminder value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurringPaymentReminder() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurringPaymentReminder() => $_clearField(1);
  @$pb.TagNumber(1)
  RecurringPaymentReminder ensureRecurringPaymentReminder() => $_ensure(0);
}

class GetRecurringPaymentReminderRequest extends $pb.GeneratedMessage {
  factory GetRecurringPaymentReminderRequest({
    $core.String? recurringPaymentReminderId,
  }) {
    final result = create();
    if (recurringPaymentReminderId != null)
      result.recurringPaymentReminderId = recurringPaymentReminderId;
    return result;
  }

  GetRecurringPaymentReminderRequest._();

  factory GetRecurringPaymentReminderRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecurringPaymentReminderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecurringPaymentReminderRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recurringPaymentReminderId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringPaymentReminderRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringPaymentReminderRequest copyWith(
          void Function(GetRecurringPaymentReminderRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetRecurringPaymentReminderRequest))
          as GetRecurringPaymentReminderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecurringPaymentReminderRequest create() =>
      GetRecurringPaymentReminderRequest._();
  @$core.override
  GetRecurringPaymentReminderRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetRecurringPaymentReminderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecurringPaymentReminderRequest>(
          create);
  static GetRecurringPaymentReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recurringPaymentReminderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recurringPaymentReminderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurringPaymentReminderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurringPaymentReminderId() => $_clearField(1);
}

class GetRecurringPaymentReminderResponse extends $pb.GeneratedMessage {
  factory GetRecurringPaymentReminderResponse({
    RecurringPaymentReminder? recurringPaymentReminder,
  }) {
    final result = create();
    if (recurringPaymentReminder != null)
      result.recurringPaymentReminder = recurringPaymentReminder;
    return result;
  }

  GetRecurringPaymentReminderResponse._();

  factory GetRecurringPaymentReminderResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecurringPaymentReminderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecurringPaymentReminderResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<RecurringPaymentReminder>(
        1, _omitFieldNames ? '' : 'recurringPaymentReminder',
        subBuilder: RecurringPaymentReminder.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringPaymentReminderResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecurringPaymentReminderResponse copyWith(
          void Function(GetRecurringPaymentReminderResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetRecurringPaymentReminderResponse))
          as GetRecurringPaymentReminderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecurringPaymentReminderResponse create() =>
      GetRecurringPaymentReminderResponse._();
  @$core.override
  GetRecurringPaymentReminderResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetRecurringPaymentReminderResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetRecurringPaymentReminderResponse>(create);
  static GetRecurringPaymentReminderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  RecurringPaymentReminder get recurringPaymentReminder => $_getN(0);
  @$pb.TagNumber(1)
  set recurringPaymentReminder(RecurringPaymentReminder value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurringPaymentReminder() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurringPaymentReminder() => $_clearField(1);
  @$pb.TagNumber(1)
  RecurringPaymentReminder ensureRecurringPaymentReminder() => $_ensure(0);
}

class ListRecurringPaymentRemindersRequest extends $pb.GeneratedMessage {
  factory ListRecurringPaymentRemindersRequest({
    $core.int? pageSize,
  }) {
    final result = create();
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListRecurringPaymentRemindersRequest._();

  factory ListRecurringPaymentRemindersRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListRecurringPaymentRemindersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRecurringPaymentRemindersRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'pageSize')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRecurringPaymentRemindersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRecurringPaymentRemindersRequest copyWith(
          void Function(ListRecurringPaymentRemindersRequest) updates) =>
      super.copyWith((message) =>
              updates(message as ListRecurringPaymentRemindersRequest))
          as ListRecurringPaymentRemindersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRecurringPaymentRemindersRequest create() =>
      ListRecurringPaymentRemindersRequest._();
  @$core.override
  ListRecurringPaymentRemindersRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListRecurringPaymentRemindersRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ListRecurringPaymentRemindersRequest>(create);
  static ListRecurringPaymentRemindersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);
}

class ListRecurringPaymentRemindersResponse extends $pb.GeneratedMessage {
  factory ListRecurringPaymentRemindersResponse({
    $core.Iterable<RecurringPaymentReminder>? recurringPaymentReminders,
  }) {
    final result = create();
    if (recurringPaymentReminders != null)
      result.recurringPaymentReminders.addAll(recurringPaymentReminders);
    return result;
  }

  ListRecurringPaymentRemindersResponse._();

  factory ListRecurringPaymentRemindersResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListRecurringPaymentRemindersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRecurringPaymentRemindersResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..pPM<RecurringPaymentReminder>(
        1, _omitFieldNames ? '' : 'recurringPaymentReminders',
        subBuilder: RecurringPaymentReminder.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRecurringPaymentRemindersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRecurringPaymentRemindersResponse copyWith(
          void Function(ListRecurringPaymentRemindersResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ListRecurringPaymentRemindersResponse))
          as ListRecurringPaymentRemindersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRecurringPaymentRemindersResponse create() =>
      ListRecurringPaymentRemindersResponse._();
  @$core.override
  ListRecurringPaymentRemindersResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListRecurringPaymentRemindersResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ListRecurringPaymentRemindersResponse>(create);
  static ListRecurringPaymentRemindersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RecurringPaymentReminder> get recurringPaymentReminders =>
      $_getList(0);
}

class UpdateRecurringPaymentReminderRequest extends $pb.GeneratedMessage {
  factory UpdateRecurringPaymentReminderRequest({
    $core.String? recurringPaymentReminderId,
    $core.String? title,
    $core.String? payee,
    $0.Money? amount,
    RecurrenceFrequency? frequency,
    $core.int? interval,
    $core.int? dayOfWeek,
    $core.int? dayOfMonth,
    $core.int? monthOfYear,
    $core.String? localTime,
    $core.String? timezone,
  }) {
    final result = create();
    if (recurringPaymentReminderId != null)
      result.recurringPaymentReminderId = recurringPaymentReminderId;
    if (title != null) result.title = title;
    if (payee != null) result.payee = payee;
    if (amount != null) result.amount = amount;
    if (frequency != null) result.frequency = frequency;
    if (interval != null) result.interval = interval;
    if (dayOfWeek != null) result.dayOfWeek = dayOfWeek;
    if (dayOfMonth != null) result.dayOfMonth = dayOfMonth;
    if (monthOfYear != null) result.monthOfYear = monthOfYear;
    if (localTime != null) result.localTime = localTime;
    if (timezone != null) result.timezone = timezone;
    return result;
  }

  UpdateRecurringPaymentReminderRequest._();

  factory UpdateRecurringPaymentReminderRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateRecurringPaymentReminderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateRecurringPaymentReminderRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recurringPaymentReminderId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'payee')
    ..aOM<$0.Money>(4, _omitFieldNames ? '' : 'amount',
        subBuilder: $0.Money.create)
    ..aE<RecurrenceFrequency>(5, _omitFieldNames ? '' : 'frequency',
        enumValues: RecurrenceFrequency.values)
    ..aI(6, _omitFieldNames ? '' : 'interval')
    ..aI(7, _omitFieldNames ? '' : 'dayOfWeek')
    ..aI(8, _omitFieldNames ? '' : 'dayOfMonth')
    ..aI(9, _omitFieldNames ? '' : 'monthOfYear')
    ..aOS(10, _omitFieldNames ? '' : 'localTime')
    ..aOS(11, _omitFieldNames ? '' : 'timezone')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecurringPaymentReminderRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecurringPaymentReminderRequest copyWith(
          void Function(UpdateRecurringPaymentReminderRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateRecurringPaymentReminderRequest))
          as UpdateRecurringPaymentReminderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateRecurringPaymentReminderRequest create() =>
      UpdateRecurringPaymentReminderRequest._();
  @$core.override
  UpdateRecurringPaymentReminderRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateRecurringPaymentReminderRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateRecurringPaymentReminderRequest>(create);
  static UpdateRecurringPaymentReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recurringPaymentReminderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recurringPaymentReminderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurringPaymentReminderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurringPaymentReminderId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get payee => $_getSZ(2);
  @$pb.TagNumber(3)
  set payee($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPayee() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayee() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.Money get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($0.Money value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Money ensureAmount() => $_ensure(3);

  @$pb.TagNumber(5)
  RecurrenceFrequency get frequency => $_getN(4);
  @$pb.TagNumber(5)
  set frequency(RecurrenceFrequency value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFrequency() => $_has(4);
  @$pb.TagNumber(5)
  void clearFrequency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get interval => $_getIZ(5);
  @$pb.TagNumber(6)
  set interval($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasInterval() => $_has(5);
  @$pb.TagNumber(6)
  void clearInterval() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get dayOfWeek => $_getIZ(6);
  @$pb.TagNumber(7)
  set dayOfWeek($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDayOfWeek() => $_has(6);
  @$pb.TagNumber(7)
  void clearDayOfWeek() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get dayOfMonth => $_getIZ(7);
  @$pb.TagNumber(8)
  set dayOfMonth($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDayOfMonth() => $_has(7);
  @$pb.TagNumber(8)
  void clearDayOfMonth() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get monthOfYear => $_getIZ(8);
  @$pb.TagNumber(9)
  set monthOfYear($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMonthOfYear() => $_has(8);
  @$pb.TagNumber(9)
  void clearMonthOfYear() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get localTime => $_getSZ(9);
  @$pb.TagNumber(10)
  set localTime($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLocalTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearLocalTime() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get timezone => $_getSZ(10);
  @$pb.TagNumber(11)
  set timezone($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTimezone() => $_has(10);
  @$pb.TagNumber(11)
  void clearTimezone() => $_clearField(11);
}

class UpdateRecurringPaymentReminderResponse extends $pb.GeneratedMessage {
  factory UpdateRecurringPaymentReminderResponse({
    RecurringPaymentReminder? recurringPaymentReminder,
  }) {
    final result = create();
    if (recurringPaymentReminder != null)
      result.recurringPaymentReminder = recurringPaymentReminder;
    return result;
  }

  UpdateRecurringPaymentReminderResponse._();

  factory UpdateRecurringPaymentReminderResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateRecurringPaymentReminderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateRecurringPaymentReminderResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<RecurringPaymentReminder>(
        1, _omitFieldNames ? '' : 'recurringPaymentReminder',
        subBuilder: RecurringPaymentReminder.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecurringPaymentReminderResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRecurringPaymentReminderResponse copyWith(
          void Function(UpdateRecurringPaymentReminderResponse) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateRecurringPaymentReminderResponse))
          as UpdateRecurringPaymentReminderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateRecurringPaymentReminderResponse create() =>
      UpdateRecurringPaymentReminderResponse._();
  @$core.override
  UpdateRecurringPaymentReminderResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateRecurringPaymentReminderResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateRecurringPaymentReminderResponse>(create);
  static UpdateRecurringPaymentReminderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  RecurringPaymentReminder get recurringPaymentReminder => $_getN(0);
  @$pb.TagNumber(1)
  set recurringPaymentReminder(RecurringPaymentReminder value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurringPaymentReminder() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurringPaymentReminder() => $_clearField(1);
  @$pb.TagNumber(1)
  RecurringPaymentReminder ensureRecurringPaymentReminder() => $_ensure(0);
}

class DeleteRecurringPaymentReminderRequest extends $pb.GeneratedMessage {
  factory DeleteRecurringPaymentReminderRequest({
    $core.String? recurringPaymentReminderId,
  }) {
    final result = create();
    if (recurringPaymentReminderId != null)
      result.recurringPaymentReminderId = recurringPaymentReminderId;
    return result;
  }

  DeleteRecurringPaymentReminderRequest._();

  factory DeleteRecurringPaymentReminderRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteRecurringPaymentReminderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteRecurringPaymentReminderRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recurringPaymentReminderId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecurringPaymentReminderRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecurringPaymentReminderRequest copyWith(
          void Function(DeleteRecurringPaymentReminderRequest) updates) =>
      super.copyWith((message) =>
              updates(message as DeleteRecurringPaymentReminderRequest))
          as DeleteRecurringPaymentReminderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRecurringPaymentReminderRequest create() =>
      DeleteRecurringPaymentReminderRequest._();
  @$core.override
  DeleteRecurringPaymentReminderRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteRecurringPaymentReminderRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          DeleteRecurringPaymentReminderRequest>(create);
  static DeleteRecurringPaymentReminderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recurringPaymentReminderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recurringPaymentReminderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurringPaymentReminderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurringPaymentReminderId() => $_clearField(1);
}

class DeleteRecurringPaymentReminderResponse extends $pb.GeneratedMessage {
  factory DeleteRecurringPaymentReminderResponse({
    RecurringPaymentReminder? recurringPaymentReminder,
  }) {
    final result = create();
    if (recurringPaymentReminder != null)
      result.recurringPaymentReminder = recurringPaymentReminder;
    return result;
  }

  DeleteRecurringPaymentReminderResponse._();

  factory DeleteRecurringPaymentReminderResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteRecurringPaymentReminderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteRecurringPaymentReminderResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.savings.v1'),
      createEmptyInstance: create)
    ..aOM<RecurringPaymentReminder>(
        1, _omitFieldNames ? '' : 'recurringPaymentReminder',
        subBuilder: RecurringPaymentReminder.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecurringPaymentReminderResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRecurringPaymentReminderResponse copyWith(
          void Function(DeleteRecurringPaymentReminderResponse) updates) =>
      super.copyWith((message) =>
              updates(message as DeleteRecurringPaymentReminderResponse))
          as DeleteRecurringPaymentReminderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRecurringPaymentReminderResponse create() =>
      DeleteRecurringPaymentReminderResponse._();
  @$core.override
  DeleteRecurringPaymentReminderResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteRecurringPaymentReminderResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          DeleteRecurringPaymentReminderResponse>(create);
  static DeleteRecurringPaymentReminderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  RecurringPaymentReminder get recurringPaymentReminder => $_getN(0);
  @$pb.TagNumber(1)
  set recurringPaymentReminder(RecurringPaymentReminder value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRecurringPaymentReminder() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecurringPaymentReminder() => $_clearField(1);
  @$pb.TagNumber(1)
  RecurringPaymentReminder ensureRecurringPaymentReminder() => $_ensure(0);
}

class SavingsServiceApi {
  final $pb.RpcClient _client;

  SavingsServiceApi(this._client);

  $async.Future<CreateApartadoResponse> createApartado(
          $pb.ClientContext? ctx, CreateApartadoRequest request) =>
      _client.invoke<CreateApartadoResponse>(ctx, 'SavingsService',
          'CreateApartado', request, CreateApartadoResponse());
  $async.Future<GetApartadoResponse> getApartado(
          $pb.ClientContext? ctx, GetApartadoRequest request) =>
      _client.invoke<GetApartadoResponse>(
          ctx, 'SavingsService', 'GetApartado', request, GetApartadoResponse());
  $async.Future<ListApartadosResponse> listApartados(
          $pb.ClientContext? ctx, ListApartadosRequest request) =>
      _client.invoke<ListApartadosResponse>(ctx, 'SavingsService',
          'ListApartados', request, ListApartadosResponse());
  $async.Future<UpdateApartadoResponse> updateApartado(
          $pb.ClientContext? ctx, UpdateApartadoRequest request) =>
      _client.invoke<UpdateApartadoResponse>(ctx, 'SavingsService',
          'UpdateApartado', request, UpdateApartadoResponse());
  $async.Future<DeleteApartadoResponse> deleteApartado(
          $pb.ClientContext? ctx, DeleteApartadoRequest request) =>
      _client.invoke<DeleteApartadoResponse>(ctx, 'SavingsService',
          'DeleteApartado', request, DeleteApartadoResponse());
  $async.Future<CreateFinancialGoalResponse> createFinancialGoal(
          $pb.ClientContext? ctx, CreateFinancialGoalRequest request) =>
      _client.invoke<CreateFinancialGoalResponse>(ctx, 'SavingsService',
          'CreateFinancialGoal', request, CreateFinancialGoalResponse());
  $async.Future<GetFinancialGoalResponse> getFinancialGoal(
          $pb.ClientContext? ctx, GetFinancialGoalRequest request) =>
      _client.invoke<GetFinancialGoalResponse>(ctx, 'SavingsService',
          'GetFinancialGoal', request, GetFinancialGoalResponse());
  $async.Future<ListFinancialGoalsResponse> listFinancialGoals(
          $pb.ClientContext? ctx, ListFinancialGoalsRequest request) =>
      _client.invoke<ListFinancialGoalsResponse>(ctx, 'SavingsService',
          'ListFinancialGoals', request, ListFinancialGoalsResponse());
  $async.Future<UpdateFinancialGoalResponse> updateFinancialGoal(
          $pb.ClientContext? ctx, UpdateFinancialGoalRequest request) =>
      _client.invoke<UpdateFinancialGoalResponse>(ctx, 'SavingsService',
          'UpdateFinancialGoal', request, UpdateFinancialGoalResponse());
  $async.Future<DeleteFinancialGoalResponse> deleteFinancialGoal(
          $pb.ClientContext? ctx, DeleteFinancialGoalRequest request) =>
      _client.invoke<DeleteFinancialGoalResponse>(ctx, 'SavingsService',
          'DeleteFinancialGoal', request, DeleteFinancialGoalResponse());
  $async.Future<CreateRecurringPaymentReminderResponse>
      createRecurringPaymentReminder($pb.ClientContext? ctx,
              CreateRecurringPaymentReminderRequest request) =>
          _client.invoke<CreateRecurringPaymentReminderResponse>(
              ctx,
              'SavingsService',
              'CreateRecurringPaymentReminder',
              request,
              CreateRecurringPaymentReminderResponse());
  $async.Future<GetRecurringPaymentReminderResponse>
      getRecurringPaymentReminder($pb.ClientContext? ctx,
              GetRecurringPaymentReminderRequest request) =>
          _client.invoke<GetRecurringPaymentReminderResponse>(
              ctx,
              'SavingsService',
              'GetRecurringPaymentReminder',
              request,
              GetRecurringPaymentReminderResponse());
  $async.Future<ListRecurringPaymentRemindersResponse>
      listRecurringPaymentReminders($pb.ClientContext? ctx,
              ListRecurringPaymentRemindersRequest request) =>
          _client.invoke<ListRecurringPaymentRemindersResponse>(
              ctx,
              'SavingsService',
              'ListRecurringPaymentReminders',
              request,
              ListRecurringPaymentRemindersResponse());
  $async.Future<UpdateRecurringPaymentReminderResponse>
      updateRecurringPaymentReminder($pb.ClientContext? ctx,
              UpdateRecurringPaymentReminderRequest request) =>
          _client.invoke<UpdateRecurringPaymentReminderResponse>(
              ctx,
              'SavingsService',
              'UpdateRecurringPaymentReminder',
              request,
              UpdateRecurringPaymentReminderResponse());
  $async.Future<DeleteRecurringPaymentReminderResponse>
      deleteRecurringPaymentReminder($pb.ClientContext? ctx,
              DeleteRecurringPaymentReminderRequest request) =>
          _client.invoke<DeleteRecurringPaymentReminderResponse>(
              ctx,
              'SavingsService',
              'DeleteRecurringPaymentReminder',
              request,
              DeleteRecurringPaymentReminderResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
