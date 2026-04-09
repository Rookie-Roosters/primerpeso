//
//  Generated code. Do not modify.
//  source: primerpeso/savings/v1/savings.proto
//

import "package:connectrpc/connect.dart" as connect;
import "savings.pb.dart" as primerpesosavingsv1savings;
import "savings.connect.spec.dart" as specs;

extension type SavingsServiceClient (connect.Transport _transport) {
  Future<primerpesosavingsv1savings.CreateApartadoResponse> createApartado(
    primerpesosavingsv1savings.CreateApartadoRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.createApartado,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.GetApartadoResponse> getApartado(
    primerpesosavingsv1savings.GetApartadoRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.getApartado,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.ListApartadosResponse> listApartados(
    primerpesosavingsv1savings.ListApartadosRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.listApartados,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.UpdateApartadoResponse> updateApartado(
    primerpesosavingsv1savings.UpdateApartadoRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.updateApartado,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.DeleteApartadoResponse> deleteApartado(
    primerpesosavingsv1savings.DeleteApartadoRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.deleteApartado,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.CreateFinancialGoalResponse> createFinancialGoal(
    primerpesosavingsv1savings.CreateFinancialGoalRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.createFinancialGoal,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.GetFinancialGoalResponse> getFinancialGoal(
    primerpesosavingsv1savings.GetFinancialGoalRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.getFinancialGoal,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.ListFinancialGoalsResponse> listFinancialGoals(
    primerpesosavingsv1savings.ListFinancialGoalsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.listFinancialGoals,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.UpdateFinancialGoalResponse> updateFinancialGoal(
    primerpesosavingsv1savings.UpdateFinancialGoalRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.updateFinancialGoal,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.DeleteFinancialGoalResponse> deleteFinancialGoal(
    primerpesosavingsv1savings.DeleteFinancialGoalRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.deleteFinancialGoal,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.CreateRecurringPaymentReminderResponse> createRecurringPaymentReminder(
    primerpesosavingsv1savings.CreateRecurringPaymentReminderRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.createRecurringPaymentReminder,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.GetRecurringPaymentReminderResponse> getRecurringPaymentReminder(
    primerpesosavingsv1savings.GetRecurringPaymentReminderRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.getRecurringPaymentReminder,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.ListRecurringPaymentRemindersResponse> listRecurringPaymentReminders(
    primerpesosavingsv1savings.ListRecurringPaymentRemindersRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.listRecurringPaymentReminders,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.UpdateRecurringPaymentReminderResponse> updateRecurringPaymentReminder(
    primerpesosavingsv1savings.UpdateRecurringPaymentReminderRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.updateRecurringPaymentReminder,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesosavingsv1savings.DeleteRecurringPaymentReminderResponse> deleteRecurringPaymentReminder(
    primerpesosavingsv1savings.DeleteRecurringPaymentReminderRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.SavingsService.deleteRecurringPaymentReminder,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
