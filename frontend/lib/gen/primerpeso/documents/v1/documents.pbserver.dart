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

import 'documents.pb.dart' as $2;
import 'documents.pbjson.dart';

export 'documents.pb.dart';

abstract class ReceiptServiceBase extends $pb.GeneratedService {
  $async.Future<$2.UploadReceiptResponse> uploadReceipt(
      $pb.ServerContext ctx, $2.UploadReceiptRequest request);
  $async.Future<$2.GetReceiptDraftResponse> getReceiptDraft(
      $pb.ServerContext ctx, $2.GetReceiptDraftRequest request);
  $async.Future<$2.ListReceiptDraftsResponse> listReceiptDrafts(
      $pb.ServerContext ctx, $2.ListReceiptDraftsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'UploadReceipt':
        return $2.UploadReceiptRequest();
      case 'GetReceiptDraft':
        return $2.GetReceiptDraftRequest();
      case 'ListReceiptDrafts':
        return $2.ListReceiptDraftsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'UploadReceipt':
        return uploadReceipt(ctx, request as $2.UploadReceiptRequest);
      case 'GetReceiptDraft':
        return getReceiptDraft(ctx, request as $2.GetReceiptDraftRequest);
      case 'ListReceiptDrafts':
        return listReceiptDrafts(ctx, request as $2.ListReceiptDraftsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => ReceiptServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => ReceiptServiceBase$messageJson;
}
