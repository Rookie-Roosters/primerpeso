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

import 'savings.pb.dart' as $2;
import 'savings.pbjson.dart';

export 'savings.pb.dart';

abstract class SavingsServiceBase extends $pb.GeneratedService {
  $async.Future<$2.CreateApartadoResponse> createApartado(
      $pb.ServerContext ctx, $2.CreateApartadoRequest request);
  $async.Future<$2.GetApartadoResponse> getApartado(
      $pb.ServerContext ctx, $2.GetApartadoRequest request);
  $async.Future<$2.ListApartadosResponse> listApartados(
      $pb.ServerContext ctx, $2.ListApartadosRequest request);
  $async.Future<$2.UpdateApartadoResponse> updateApartado(
      $pb.ServerContext ctx, $2.UpdateApartadoRequest request);
  $async.Future<$2.DeleteApartadoResponse> deleteApartado(
      $pb.ServerContext ctx, $2.DeleteApartadoRequest request);
  $async.Future<$2.CreateFinancialGoalResponse> createFinancialGoal(
      $pb.ServerContext ctx, $2.CreateFinancialGoalRequest request);
  $async.Future<$2.GetFinancialGoalResponse> getFinancialGoal(
      $pb.ServerContext ctx, $2.GetFinancialGoalRequest request);
  $async.Future<$2.ListFinancialGoalsResponse> listFinancialGoals(
      $pb.ServerContext ctx, $2.ListFinancialGoalsRequest request);
  $async.Future<$2.UpdateFinancialGoalResponse> updateFinancialGoal(
      $pb.ServerContext ctx, $2.UpdateFinancialGoalRequest request);
  $async.Future<$2.DeleteFinancialGoalResponse> deleteFinancialGoal(
      $pb.ServerContext ctx, $2.DeleteFinancialGoalRequest request);
  $async.Future<$2.CreateRecurringPaymentReminderResponse>
      createRecurringPaymentReminder($pb.ServerContext ctx,
          $2.CreateRecurringPaymentReminderRequest request);
  $async.Future<$2.GetRecurringPaymentReminderResponse>
      getRecurringPaymentReminder(
          $pb.ServerContext ctx, $2.GetRecurringPaymentReminderRequest request);
  $async.Future<$2.ListRecurringPaymentRemindersResponse>
      listRecurringPaymentReminders($pb.ServerContext ctx,
          $2.ListRecurringPaymentRemindersRequest request);
  $async.Future<$2.UpdateRecurringPaymentReminderResponse>
      updateRecurringPaymentReminder($pb.ServerContext ctx,
          $2.UpdateRecurringPaymentReminderRequest request);
  $async.Future<$2.DeleteRecurringPaymentReminderResponse>
      deleteRecurringPaymentReminder($pb.ServerContext ctx,
          $2.DeleteRecurringPaymentReminderRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'CreateApartado':
        return $2.CreateApartadoRequest();
      case 'GetApartado':
        return $2.GetApartadoRequest();
      case 'ListApartados':
        return $2.ListApartadosRequest();
      case 'UpdateApartado':
        return $2.UpdateApartadoRequest();
      case 'DeleteApartado':
        return $2.DeleteApartadoRequest();
      case 'CreateFinancialGoal':
        return $2.CreateFinancialGoalRequest();
      case 'GetFinancialGoal':
        return $2.GetFinancialGoalRequest();
      case 'ListFinancialGoals':
        return $2.ListFinancialGoalsRequest();
      case 'UpdateFinancialGoal':
        return $2.UpdateFinancialGoalRequest();
      case 'DeleteFinancialGoal':
        return $2.DeleteFinancialGoalRequest();
      case 'CreateRecurringPaymentReminder':
        return $2.CreateRecurringPaymentReminderRequest();
      case 'GetRecurringPaymentReminder':
        return $2.GetRecurringPaymentReminderRequest();
      case 'ListRecurringPaymentReminders':
        return $2.ListRecurringPaymentRemindersRequest();
      case 'UpdateRecurringPaymentReminder':
        return $2.UpdateRecurringPaymentReminderRequest();
      case 'DeleteRecurringPaymentReminder':
        return $2.DeleteRecurringPaymentReminderRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'CreateApartado':
        return createApartado(ctx, request as $2.CreateApartadoRequest);
      case 'GetApartado':
        return getApartado(ctx, request as $2.GetApartadoRequest);
      case 'ListApartados':
        return listApartados(ctx, request as $2.ListApartadosRequest);
      case 'UpdateApartado':
        return updateApartado(ctx, request as $2.UpdateApartadoRequest);
      case 'DeleteApartado':
        return deleteApartado(ctx, request as $2.DeleteApartadoRequest);
      case 'CreateFinancialGoal':
        return createFinancialGoal(
            ctx, request as $2.CreateFinancialGoalRequest);
      case 'GetFinancialGoal':
        return getFinancialGoal(ctx, request as $2.GetFinancialGoalRequest);
      case 'ListFinancialGoals':
        return listFinancialGoals(ctx, request as $2.ListFinancialGoalsRequest);
      case 'UpdateFinancialGoal':
        return updateFinancialGoal(
            ctx, request as $2.UpdateFinancialGoalRequest);
      case 'DeleteFinancialGoal':
        return deleteFinancialGoal(
            ctx, request as $2.DeleteFinancialGoalRequest);
      case 'CreateRecurringPaymentReminder':
        return createRecurringPaymentReminder(
            ctx, request as $2.CreateRecurringPaymentReminderRequest);
      case 'GetRecurringPaymentReminder':
        return getRecurringPaymentReminder(
            ctx, request as $2.GetRecurringPaymentReminderRequest);
      case 'ListRecurringPaymentReminders':
        return listRecurringPaymentReminders(
            ctx, request as $2.ListRecurringPaymentRemindersRequest);
      case 'UpdateRecurringPaymentReminder':
        return updateRecurringPaymentReminder(
            ctx, request as $2.UpdateRecurringPaymentReminderRequest);
      case 'DeleteRecurringPaymentReminder':
        return deleteRecurringPaymentReminder(
            ctx, request as $2.DeleteRecurringPaymentReminderRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => SavingsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => SavingsServiceBase$messageJson;
}
