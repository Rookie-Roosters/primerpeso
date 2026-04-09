// This is a generated file - do not edit.
//
// Generated from primerpeso/documents/v1/documents.proto.

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
import 'documents.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'documents.pbenum.dart';

class ReceiptLineItem extends $pb.GeneratedMessage {
  factory ReceiptLineItem({
    $core.String? description,
    $0.Money? amount,
    $core.int? quantity,
  }) {
    final result = create();
    if (description != null) result.description = description;
    if (amount != null) result.amount = amount;
    if (quantity != null) result.quantity = quantity;
    return result;
  }

  ReceiptLineItem._();

  factory ReceiptLineItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReceiptLineItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReceiptLineItem',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.documents.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..aOM<$0.Money>(2, _omitFieldNames ? '' : 'amount',
        subBuilder: $0.Money.create)
    ..aI(3, _omitFieldNames ? '' : 'quantity')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceiptLineItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceiptLineItem copyWith(void Function(ReceiptLineItem) updates) =>
      super.copyWith((message) => updates(message as ReceiptLineItem))
          as ReceiptLineItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceiptLineItem create() => ReceiptLineItem._();
  @$core.override
  ReceiptLineItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReceiptLineItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReceiptLineItem>(create);
  static ReceiptLineItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Money get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($0.Money value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Money ensureAmount() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get quantity => $_getIZ(2);
  @$pb.TagNumber(3)
  set quantity($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => $_clearField(3);
}

class ReceiptDraft extends $pb.GeneratedMessage {
  factory ReceiptDraft({
    $core.String? id,
    ReceiptStatus? status,
    $core.String? merchantName,
    $core.String? suggestedCategory,
    $core.String? redactedRawText,
    $core.Iterable<ReceiptLineItem>? lineItems,
    $0.Money? total,
    $1.Timestamp? purchasedAt,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (status != null) result.status = status;
    if (merchantName != null) result.merchantName = merchantName;
    if (suggestedCategory != null) result.suggestedCategory = suggestedCategory;
    if (redactedRawText != null) result.redactedRawText = redactedRawText;
    if (lineItems != null) result.lineItems.addAll(lineItems);
    if (total != null) result.total = total;
    if (purchasedAt != null) result.purchasedAt = purchasedAt;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  ReceiptDraft._();

  factory ReceiptDraft.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReceiptDraft.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReceiptDraft',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.documents.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aE<ReceiptStatus>(2, _omitFieldNames ? '' : 'status',
        enumValues: ReceiptStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'merchantName')
    ..aOS(4, _omitFieldNames ? '' : 'suggestedCategory')
    ..aOS(5, _omitFieldNames ? '' : 'redactedRawText')
    ..pPM<ReceiptLineItem>(6, _omitFieldNames ? '' : 'lineItems',
        subBuilder: ReceiptLineItem.create)
    ..aOM<$0.Money>(7, _omitFieldNames ? '' : 'total',
        subBuilder: $0.Money.create)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'purchasedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceiptDraft clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceiptDraft copyWith(void Function(ReceiptDraft) updates) =>
      super.copyWith((message) => updates(message as ReceiptDraft))
          as ReceiptDraft;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceiptDraft create() => ReceiptDraft._();
  @$core.override
  ReceiptDraft createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReceiptDraft getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReceiptDraft>(create);
  static ReceiptDraft? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  ReceiptStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(ReceiptStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get merchantName => $_getSZ(2);
  @$pb.TagNumber(3)
  set merchantName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMerchantName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMerchantName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get suggestedCategory => $_getSZ(3);
  @$pb.TagNumber(4)
  set suggestedCategory($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSuggestedCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuggestedCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get redactedRawText => $_getSZ(4);
  @$pb.TagNumber(5)
  set redactedRawText($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRedactedRawText() => $_has(4);
  @$pb.TagNumber(5)
  void clearRedactedRawText() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<ReceiptLineItem> get lineItems => $_getList(5);

  @$pb.TagNumber(7)
  $0.Money get total => $_getN(6);
  @$pb.TagNumber(7)
  set total($0.Money value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTotal() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotal() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.Money ensureTotal() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get purchasedAt => $_getN(7);
  @$pb.TagNumber(8)
  set purchasedAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPurchasedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearPurchasedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensurePurchasedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureCreatedAt() => $_ensure(8);
}

class UploadReceiptRequest extends $pb.GeneratedMessage {
  factory UploadReceiptRequest({
    $core.List<$core.int>? content,
    $core.String? filename,
    $core.String? mimeType,
  }) {
    final result = create();
    if (content != null) result.content = content;
    if (filename != null) result.filename = filename;
    if (mimeType != null) result.mimeType = mimeType;
    return result;
  }

  UploadReceiptRequest._();

  factory UploadReceiptRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadReceiptRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadReceiptRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.documents.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'content', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'filename')
    ..aOS(3, _omitFieldNames ? '' : 'mimeType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadReceiptRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadReceiptRequest copyWith(void Function(UploadReceiptRequest) updates) =>
      super.copyWith((message) => updates(message as UploadReceiptRequest))
          as UploadReceiptRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadReceiptRequest create() => UploadReceiptRequest._();
  @$core.override
  UploadReceiptRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadReceiptRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadReceiptRequest>(create);
  static UploadReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get content => $_getN(0);
  @$pb.TagNumber(1)
  set content($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get filename => $_getSZ(1);
  @$pb.TagNumber(2)
  set filename($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFilename() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilename() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mimeType => $_getSZ(2);
  @$pb.TagNumber(3)
  set mimeType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMimeType() => $_has(2);
  @$pb.TagNumber(3)
  void clearMimeType() => $_clearField(3);
}

class UploadReceiptResponse extends $pb.GeneratedMessage {
  factory UploadReceiptResponse({
    ReceiptDraft? draft,
    ExtractionDecision? decision,
    $core.Iterable<$core.String>? missingFields,
    $core.String? rationale,
    $core.double? confidence,
    $0.Expense? expense,
    $0.ScoreSummary? scoreSummary,
  }) {
    final result = create();
    if (draft != null) result.draft = draft;
    if (decision != null) result.decision = decision;
    if (missingFields != null) result.missingFields.addAll(missingFields);
    if (rationale != null) result.rationale = rationale;
    if (confidence != null) result.confidence = confidence;
    if (expense != null) result.expense = expense;
    if (scoreSummary != null) result.scoreSummary = scoreSummary;
    return result;
  }

  UploadReceiptResponse._();

  factory UploadReceiptResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadReceiptResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadReceiptResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.documents.v1'),
      createEmptyInstance: create)
    ..aOM<ReceiptDraft>(1, _omitFieldNames ? '' : 'draft',
        subBuilder: ReceiptDraft.create)
    ..aE<ExtractionDecision>(2, _omitFieldNames ? '' : 'decision',
        enumValues: ExtractionDecision.values)
    ..pPS(3, _omitFieldNames ? '' : 'missingFields')
    ..aOS(4, _omitFieldNames ? '' : 'rationale')
    ..aD(5, _omitFieldNames ? '' : 'confidence')
    ..aOM<$0.Expense>(6, _omitFieldNames ? '' : 'expense',
        subBuilder: $0.Expense.create)
    ..aOM<$0.ScoreSummary>(7, _omitFieldNames ? '' : 'scoreSummary',
        subBuilder: $0.ScoreSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadReceiptResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadReceiptResponse copyWith(
          void Function(UploadReceiptResponse) updates) =>
      super.copyWith((message) => updates(message as UploadReceiptResponse))
          as UploadReceiptResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadReceiptResponse create() => UploadReceiptResponse._();
  @$core.override
  UploadReceiptResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UploadReceiptResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadReceiptResponse>(create);
  static UploadReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ReceiptDraft get draft => $_getN(0);
  @$pb.TagNumber(1)
  set draft(ReceiptDraft value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDraft() => $_has(0);
  @$pb.TagNumber(1)
  void clearDraft() => $_clearField(1);
  @$pb.TagNumber(1)
  ReceiptDraft ensureDraft() => $_ensure(0);

  @$pb.TagNumber(2)
  ExtractionDecision get decision => $_getN(1);
  @$pb.TagNumber(2)
  set decision(ExtractionDecision value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDecision() => $_has(1);
  @$pb.TagNumber(2)
  void clearDecision() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get missingFields => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get rationale => $_getSZ(3);
  @$pb.TagNumber(4)
  set rationale($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRationale() => $_has(3);
  @$pb.TagNumber(4)
  void clearRationale() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get confidence => $_getN(4);
  @$pb.TagNumber(5)
  set confidence($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasConfidence() => $_has(4);
  @$pb.TagNumber(5)
  void clearConfidence() => $_clearField(5);

  @$pb.TagNumber(6)
  $0.Expense get expense => $_getN(5);
  @$pb.TagNumber(6)
  set expense($0.Expense value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasExpense() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpense() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.Expense ensureExpense() => $_ensure(5);

  @$pb.TagNumber(7)
  $0.ScoreSummary get scoreSummary => $_getN(6);
  @$pb.TagNumber(7)
  set scoreSummary($0.ScoreSummary value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasScoreSummary() => $_has(6);
  @$pb.TagNumber(7)
  void clearScoreSummary() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.ScoreSummary ensureScoreSummary() => $_ensure(6);
}

class GetReceiptDraftRequest extends $pb.GeneratedMessage {
  factory GetReceiptDraftRequest({
    $core.String? receiptId,
  }) {
    final result = create();
    if (receiptId != null) result.receiptId = receiptId;
    return result;
  }

  GetReceiptDraftRequest._();

  factory GetReceiptDraftRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetReceiptDraftRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetReceiptDraftRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.documents.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiptId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReceiptDraftRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReceiptDraftRequest copyWith(
          void Function(GetReceiptDraftRequest) updates) =>
      super.copyWith((message) => updates(message as GetReceiptDraftRequest))
          as GetReceiptDraftRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReceiptDraftRequest create() => GetReceiptDraftRequest._();
  @$core.override
  GetReceiptDraftRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetReceiptDraftRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetReceiptDraftRequest>(create);
  static GetReceiptDraftRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiptId => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiptId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReceiptId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiptId() => $_clearField(1);
}

class GetReceiptDraftResponse extends $pb.GeneratedMessage {
  factory GetReceiptDraftResponse({
    ReceiptDraft? draft,
  }) {
    final result = create();
    if (draft != null) result.draft = draft;
    return result;
  }

  GetReceiptDraftResponse._();

  factory GetReceiptDraftResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetReceiptDraftResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetReceiptDraftResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.documents.v1'),
      createEmptyInstance: create)
    ..aOM<ReceiptDraft>(1, _omitFieldNames ? '' : 'draft',
        subBuilder: ReceiptDraft.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReceiptDraftResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReceiptDraftResponse copyWith(
          void Function(GetReceiptDraftResponse) updates) =>
      super.copyWith((message) => updates(message as GetReceiptDraftResponse))
          as GetReceiptDraftResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReceiptDraftResponse create() => GetReceiptDraftResponse._();
  @$core.override
  GetReceiptDraftResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetReceiptDraftResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetReceiptDraftResponse>(create);
  static GetReceiptDraftResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ReceiptDraft get draft => $_getN(0);
  @$pb.TagNumber(1)
  set draft(ReceiptDraft value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDraft() => $_has(0);
  @$pb.TagNumber(1)
  void clearDraft() => $_clearField(1);
  @$pb.TagNumber(1)
  ReceiptDraft ensureDraft() => $_ensure(0);
}

class ListReceiptDraftsRequest extends $pb.GeneratedMessage {
  factory ListReceiptDraftsRequest({
    $core.int? pageSize,
  }) {
    final result = create();
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListReceiptDraftsRequest._();

  factory ListReceiptDraftsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListReceiptDraftsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListReceiptDraftsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.documents.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'pageSize')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListReceiptDraftsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListReceiptDraftsRequest copyWith(
          void Function(ListReceiptDraftsRequest) updates) =>
      super.copyWith((message) => updates(message as ListReceiptDraftsRequest))
          as ListReceiptDraftsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListReceiptDraftsRequest create() => ListReceiptDraftsRequest._();
  @$core.override
  ListReceiptDraftsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListReceiptDraftsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListReceiptDraftsRequest>(create);
  static ListReceiptDraftsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);
}

class ListReceiptDraftsResponse extends $pb.GeneratedMessage {
  factory ListReceiptDraftsResponse({
    $core.Iterable<ReceiptDraft>? drafts,
  }) {
    final result = create();
    if (drafts != null) result.drafts.addAll(drafts);
    return result;
  }

  ListReceiptDraftsResponse._();

  factory ListReceiptDraftsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListReceiptDraftsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListReceiptDraftsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'primerpeso.documents.v1'),
      createEmptyInstance: create)
    ..pPM<ReceiptDraft>(1, _omitFieldNames ? '' : 'drafts',
        subBuilder: ReceiptDraft.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListReceiptDraftsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListReceiptDraftsResponse copyWith(
          void Function(ListReceiptDraftsResponse) updates) =>
      super.copyWith((message) => updates(message as ListReceiptDraftsResponse))
          as ListReceiptDraftsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListReceiptDraftsResponse create() => ListReceiptDraftsResponse._();
  @$core.override
  ListReceiptDraftsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListReceiptDraftsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListReceiptDraftsResponse>(create);
  static ListReceiptDraftsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ReceiptDraft> get drafts => $_getList(0);
}

class ReceiptServiceApi {
  final $pb.RpcClient _client;

  ReceiptServiceApi(this._client);

  $async.Future<UploadReceiptResponse> uploadReceipt(
          $pb.ClientContext? ctx, UploadReceiptRequest request) =>
      _client.invoke<UploadReceiptResponse>(ctx, 'ReceiptService',
          'UploadReceipt', request, UploadReceiptResponse());
  $async.Future<GetReceiptDraftResponse> getReceiptDraft(
          $pb.ClientContext? ctx, GetReceiptDraftRequest request) =>
      _client.invoke<GetReceiptDraftResponse>(ctx, 'ReceiptService',
          'GetReceiptDraft', request, GetReceiptDraftResponse());
  $async.Future<ListReceiptDraftsResponse> listReceiptDrafts(
          $pb.ClientContext? ctx, ListReceiptDraftsRequest request) =>
      _client.invoke<ListReceiptDraftsResponse>(ctx, 'ReceiptService',
          'ListReceiptDrafts', request, ListReceiptDraftsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
