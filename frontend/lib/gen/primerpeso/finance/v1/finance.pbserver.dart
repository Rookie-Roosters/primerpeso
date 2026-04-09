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

import 'package:protobuf/protobuf.dart' as $pb;

import 'finance.pb.dart' as $1;
import 'finance.pbjson.dart';

export 'finance.pb.dart';

abstract class FinanceServiceBase extends $pb.GeneratedService {
  $async.Future<$1.ConfirmExpenseResponse> confirmExpense(
      $pb.ServerContext ctx, $1.ConfirmExpenseRequest request);
  $async.Future<$1.ListExpensesResponse> listExpenses(
      $pb.ServerContext ctx, $1.ListExpensesRequest request);
  $async.Future<$1.GetScoreSummaryResponse> getScoreSummary(
      $pb.ServerContext ctx, $1.GetScoreSummaryRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ConfirmExpense':
        return $1.ConfirmExpenseRequest();
      case 'ListExpenses':
        return $1.ListExpensesRequest();
      case 'GetScoreSummary':
        return $1.GetScoreSummaryRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ConfirmExpense':
        return confirmExpense(ctx, request as $1.ConfirmExpenseRequest);
      case 'ListExpenses':
        return listExpenses(ctx, request as $1.ListExpensesRequest);
      case 'GetScoreSummary':
        return getScoreSummary(ctx, request as $1.GetScoreSummaryRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => FinanceServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => FinanceServiceBase$messageJson;
}
