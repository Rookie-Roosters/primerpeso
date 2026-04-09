// This is a generated file - do not edit.
//
// Generated from primerpeso/finance/v1/finance.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Money extends $pb.GeneratedMessage {
  factory Money({
    $core.String? currencyCode,
    $fixnum.Int64? units,
    $core.int? nanos,
  }) {
    final result = create();
    if (currencyCode != null) result.currencyCode = currencyCode;
    if (units != null) result.units = units;
    if (nanos != null) result.nanos = nanos;
    return result;
  }

  Money._();

  factory Money.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Money.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Money',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.finance.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currencyCode')
    ..aInt64(2, _omitFieldNames ? '' : 'units')
    ..aI(3, _omitFieldNames ? '' : 'nanos')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Money clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Money copyWith(void Function(Money) updates) =>
      super.copyWith((message) => updates(message as Money)) as Money;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Money create() => Money._();
  @$core.override
  Money createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Money getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Money>(create);
  static Money? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currencyCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set currencyCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrencyCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrencyCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get units => $_getI64(1);
  @$pb.TagNumber(2)
  set units($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUnits() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnits() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get nanos => $_getIZ(2);
  @$pb.TagNumber(3)
  set nanos($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNanos() => $_has(2);
  @$pb.TagNumber(3)
  void clearNanos() => $_clearField(3);
}

class Expense extends $pb.GeneratedMessage {
  factory Expense({
    $core.String? id,
    $core.String? merchantName,
    $core.String? displayTitle,
    $core.String? category,
    $core.String? sourceReceiptId,
    Money? amount,
    $0.Timestamp? occurredAt,
    $0.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (merchantName != null) result.merchantName = merchantName;
    if (displayTitle != null) result.displayTitle = displayTitle;
    if (category != null) result.category = category;
    if (sourceReceiptId != null) result.sourceReceiptId = sourceReceiptId;
    if (amount != null) result.amount = amount;
    if (occurredAt != null) result.occurredAt = occurredAt;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  Expense._();

  factory Expense.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Expense.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Expense',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.finance.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'merchantName')
    ..aOS(3, _omitFieldNames ? '' : 'displayTitle')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOS(5, _omitFieldNames ? '' : 'sourceReceiptId')
    ..aOM<Money>(6, _omitFieldNames ? '' : 'amount', subBuilder: Money.create)
    ..aOM<$0.Timestamp>(7, _omitFieldNames ? '' : 'occurredAt',
        subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(8, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Expense clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Expense copyWith(void Function(Expense) updates) =>
      super.copyWith((message) => updates(message as Expense)) as Expense;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Expense create() => Expense._();
  @$core.override
  Expense createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Expense getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Expense>(create);
  static Expense? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get merchantName => $_getSZ(1);
  @$pb.TagNumber(2)
  set merchantName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMerchantName() => $_has(1);
  @$pb.TagNumber(2)
  void clearMerchantName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayTitle => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayTitle($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sourceReceiptId => $_getSZ(4);
  @$pb.TagNumber(5)
  set sourceReceiptId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSourceReceiptId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceReceiptId() => $_clearField(5);

  @$pb.TagNumber(6)
  Money get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount(Money value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);
  @$pb.TagNumber(6)
  Money ensureAmount() => $_ensure(5);

  @$pb.TagNumber(7)
  $0.Timestamp get occurredAt => $_getN(6);
  @$pb.TagNumber(7)
  set occurredAt($0.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasOccurredAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearOccurredAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureOccurredAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $0.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($0.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $0.Timestamp ensureCreatedAt() => $_ensure(7);
}

class ScoreFactor extends $pb.GeneratedMessage {
  factory ScoreFactor({
    $core.String? key,
    $core.String? title,
    $core.String? explanation,
    $core.int? delta,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (title != null) result.title = title;
    if (explanation != null) result.explanation = explanation;
    if (delta != null) result.delta = delta;
    return result;
  }

  ScoreFactor._();

  factory ScoreFactor.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScoreFactor.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScoreFactor',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.finance.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'explanation')
    ..aI(4, _omitFieldNames ? '' : 'delta')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScoreFactor clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScoreFactor copyWith(void Function(ScoreFactor) updates) =>
      super.copyWith((message) => updates(message as ScoreFactor))
          as ScoreFactor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScoreFactor create() => ScoreFactor._();
  @$core.override
  ScoreFactor createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScoreFactor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScoreFactor>(create);
  static ScoreFactor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get explanation => $_getSZ(2);
  @$pb.TagNumber(3)
  set explanation($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExplanation() => $_has(2);
  @$pb.TagNumber(3)
  void clearExplanation() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get delta => $_getIZ(3);
  @$pb.TagNumber(4)
  set delta($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDelta() => $_has(3);
  @$pb.TagNumber(4)
  void clearDelta() => $_clearField(4);
}

class ScoreSummary extends $pb.GeneratedMessage {
  factory ScoreSummary({
    $core.int? score,
    $core.Iterable<ScoreFactor>? factors,
    $0.Timestamp? updatedAt,
  }) {
    final result = create();
    if (score != null) result.score = score;
    if (factors != null) result.factors.addAll(factors);
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  ScoreSummary._();

  factory ScoreSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScoreSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScoreSummary',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.finance.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'score')
    ..pPM<ScoreFactor>(2, _omitFieldNames ? '' : 'factors',
        subBuilder: ScoreFactor.create)
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScoreSummary clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScoreSummary copyWith(void Function(ScoreSummary) updates) =>
      super.copyWith((message) => updates(message as ScoreSummary))
          as ScoreSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScoreSummary create() => ScoreSummary._();
  @$core.override
  ScoreSummary createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScoreSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScoreSummary>(create);
  static ScoreSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get score => $_getIZ(0);
  @$pb.TagNumber(1)
  set score($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasScore() => $_has(0);
  @$pb.TagNumber(1)
  void clearScore() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<ScoreFactor> get factors => $_getList(1);

  @$pb.TagNumber(3)
  $0.Timestamp get updatedAt => $_getN(2);
  @$pb.TagNumber(3)
  set updatedAt($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureUpdatedAt() => $_ensure(2);
}

class ConfirmExpenseRequest extends $pb.GeneratedMessage {
  factory ConfirmExpenseRequest({
    $core.String? receiptId,
    $core.String? merchantName,
    $core.String? displayTitle,
    $core.String? category,
    Money? amount,
    $0.Timestamp? occurredAt,
  }) {
    final result = create();
    if (receiptId != null) result.receiptId = receiptId;
    if (merchantName != null) result.merchantName = merchantName;
    if (displayTitle != null) result.displayTitle = displayTitle;
    if (category != null) result.category = category;
    if (amount != null) result.amount = amount;
    if (occurredAt != null) result.occurredAt = occurredAt;
    return result;
  }

  ConfirmExpenseRequest._();

  factory ConfirmExpenseRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfirmExpenseRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfirmExpenseRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.finance.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiptId')
    ..aOS(2, _omitFieldNames ? '' : 'merchantName')
    ..aOS(3, _omitFieldNames ? '' : 'displayTitle')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOM<Money>(5, _omitFieldNames ? '' : 'amount', subBuilder: Money.create)
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'occurredAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmExpenseRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmExpenseRequest copyWith(
          void Function(ConfirmExpenseRequest) updates) =>
      super.copyWith((message) => updates(message as ConfirmExpenseRequest))
          as ConfirmExpenseRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmExpenseRequest create() => ConfirmExpenseRequest._();
  @$core.override
  ConfirmExpenseRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ConfirmExpenseRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfirmExpenseRequest>(create);
  static ConfirmExpenseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiptId => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiptId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReceiptId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiptId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get merchantName => $_getSZ(1);
  @$pb.TagNumber(2)
  set merchantName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMerchantName() => $_has(1);
  @$pb.TagNumber(2)
  void clearMerchantName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayTitle => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayTitle($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  Money get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount(Money value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);
  @$pb.TagNumber(5)
  Money ensureAmount() => $_ensure(4);

  @$pb.TagNumber(6)
  $0.Timestamp get occurredAt => $_getN(5);
  @$pb.TagNumber(6)
  set occurredAt($0.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasOccurredAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearOccurredAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.Timestamp ensureOccurredAt() => $_ensure(5);
}

class ConfirmExpenseResponse extends $pb.GeneratedMessage {
  factory ConfirmExpenseResponse({
    Expense? expense,
    ScoreSummary? scoreSummary,
  }) {
    final result = create();
    if (expense != null) result.expense = expense;
    if (scoreSummary != null) result.scoreSummary = scoreSummary;
    return result;
  }

  ConfirmExpenseResponse._();

  factory ConfirmExpenseResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfirmExpenseResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfirmExpenseResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.finance.v1'),
      createEmptyInstance: create)
    ..aOM<Expense>(1, _omitFieldNames ? '' : 'expense',
        subBuilder: Expense.create)
    ..aOM<ScoreSummary>(2, _omitFieldNames ? '' : 'scoreSummary',
        subBuilder: ScoreSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmExpenseResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmExpenseResponse copyWith(
          void Function(ConfirmExpenseResponse) updates) =>
      super.copyWith((message) => updates(message as ConfirmExpenseResponse))
          as ConfirmExpenseResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmExpenseResponse create() => ConfirmExpenseResponse._();
  @$core.override
  ConfirmExpenseResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ConfirmExpenseResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfirmExpenseResponse>(create);
  static ConfirmExpenseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Expense get expense => $_getN(0);
  @$pb.TagNumber(1)
  set expense(Expense value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasExpense() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpense() => $_clearField(1);
  @$pb.TagNumber(1)
  Expense ensureExpense() => $_ensure(0);

  @$pb.TagNumber(2)
  ScoreSummary get scoreSummary => $_getN(1);
  @$pb.TagNumber(2)
  set scoreSummary(ScoreSummary value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasScoreSummary() => $_has(1);
  @$pb.TagNumber(2)
  void clearScoreSummary() => $_clearField(2);
  @$pb.TagNumber(2)
  ScoreSummary ensureScoreSummary() => $_ensure(1);
}

class ListExpensesRequest extends $pb.GeneratedMessage {
  factory ListExpensesRequest({
    $core.int? pageSize,
  }) {
    final result = create();
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListExpensesRequest._();

  factory ListExpensesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListExpensesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListExpensesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.finance.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'pageSize')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListExpensesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListExpensesRequest copyWith(void Function(ListExpensesRequest) updates) =>
      super.copyWith((message) => updates(message as ListExpensesRequest))
          as ListExpensesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListExpensesRequest create() => ListExpensesRequest._();
  @$core.override
  ListExpensesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListExpensesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListExpensesRequest>(create);
  static ListExpensesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);
}

class ListExpensesResponse extends $pb.GeneratedMessage {
  factory ListExpensesResponse({
    $core.Iterable<Expense>? expenses,
  }) {
    final result = create();
    if (expenses != null) result.expenses.addAll(expenses);
    return result;
  }

  ListExpensesResponse._();

  factory ListExpensesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListExpensesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListExpensesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.finance.v1'),
      createEmptyInstance: create)
    ..pPM<Expense>(1, _omitFieldNames ? '' : 'expenses',
        subBuilder: Expense.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListExpensesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListExpensesResponse copyWith(void Function(ListExpensesResponse) updates) =>
      super.copyWith((message) => updates(message as ListExpensesResponse))
          as ListExpensesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListExpensesResponse create() => ListExpensesResponse._();
  @$core.override
  ListExpensesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListExpensesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListExpensesResponse>(create);
  static ListExpensesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Expense> get expenses => $_getList(0);
}

class GetScoreSummaryRequest extends $pb.GeneratedMessage {
  factory GetScoreSummaryRequest() => create();

  GetScoreSummaryRequest._();

  factory GetScoreSummaryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetScoreSummaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetScoreSummaryRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.finance.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetScoreSummaryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetScoreSummaryRequest copyWith(
          void Function(GetScoreSummaryRequest) updates) =>
      super.copyWith((message) => updates(message as GetScoreSummaryRequest))
          as GetScoreSummaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetScoreSummaryRequest create() => GetScoreSummaryRequest._();
  @$core.override
  GetScoreSummaryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetScoreSummaryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetScoreSummaryRequest>(create);
  static GetScoreSummaryRequest? _defaultInstance;
}

class GetScoreSummaryResponse extends $pb.GeneratedMessage {
  factory GetScoreSummaryResponse({
    ScoreSummary? summary,
  }) {
    final result = create();
    if (summary != null) result.summary = summary;
    return result;
  }

  GetScoreSummaryResponse._();

  factory GetScoreSummaryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetScoreSummaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetScoreSummaryResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.finance.v1'),
      createEmptyInstance: create)
    ..aOM<ScoreSummary>(1, _omitFieldNames ? '' : 'summary',
        subBuilder: ScoreSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetScoreSummaryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetScoreSummaryResponse copyWith(
          void Function(GetScoreSummaryResponse) updates) =>
      super.copyWith((message) => updates(message as GetScoreSummaryResponse))
          as GetScoreSummaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetScoreSummaryResponse create() => GetScoreSummaryResponse._();
  @$core.override
  GetScoreSummaryResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetScoreSummaryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetScoreSummaryResponse>(create);
  static GetScoreSummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ScoreSummary get summary => $_getN(0);
  @$pb.TagNumber(1)
  set summary(ScoreSummary value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSummary() => $_has(0);
  @$pb.TagNumber(1)
  void clearSummary() => $_clearField(1);
  @$pb.TagNumber(1)
  ScoreSummary ensureSummary() => $_ensure(0);
}

class FinanceServiceApi {
  final $pb.RpcClient _client;

  FinanceServiceApi(this._client);

  $async.Future<ConfirmExpenseResponse> confirmExpense(
          $pb.ClientContext? ctx, ConfirmExpenseRequest request) =>
      _client.invoke<ConfirmExpenseResponse>(ctx, 'FinanceService',
          'ConfirmExpense', request, ConfirmExpenseResponse());
  $async.Future<ListExpensesResponse> listExpenses(
          $pb.ClientContext? ctx, ListExpensesRequest request) =>
      _client.invoke<ListExpensesResponse>(ctx, 'FinanceService',
          'ListExpenses', request, ListExpensesResponse());
  $async.Future<GetScoreSummaryResponse> getScoreSummary(
          $pb.ClientContext? ctx, GetScoreSummaryRequest request) =>
      _client.invoke<GetScoreSummaryResponse>(ctx, 'FinanceService',
          'GetScoreSummary', request, GetScoreSummaryResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
