//
//  Generated code. Do not modify.
//  source: primerpeso/savings/v1/savings.proto
//

import "package:connectrpc/connect.dart" as connect;
import "savings.pb.dart" as primerpesosavingsv1savings;

abstract final class SavingsService {
  /// Fully-qualified name of the SavingsService service.
  static const name = 'primerpeso.savings.v1.SavingsService';

  static const createApartado = connect.Spec(
    '/$name/CreateApartado',
    connect.StreamType.unary,
    primerpesosavingsv1savings.CreateApartadoRequest.new,
    primerpesosavingsv1savings.CreateApartadoResponse.new,
  );

  static const getApartado = connect.Spec(
    '/$name/GetApartado',
    connect.StreamType.unary,
    primerpesosavingsv1savings.GetApartadoRequest.new,
    primerpesosavingsv1savings.GetApartadoResponse.new,
  );

  static const listApartados = connect.Spec(
    '/$name/ListApartados',
    connect.StreamType.unary,
    primerpesosavingsv1savings.ListApartadosRequest.new,
    primerpesosavingsv1savings.ListApartadosResponse.new,
  );

  static const updateApartado = connect.Spec(
    '/$name/UpdateApartado',
    connect.StreamType.unary,
    primerpesosavingsv1savings.UpdateApartadoRequest.new,
    primerpesosavingsv1savings.UpdateApartadoResponse.new,
  );

  static const deleteApartado = connect.Spec(
    '/$name/DeleteApartado',
    connect.StreamType.unary,
    primerpesosavingsv1savings.DeleteApartadoRequest.new,
    primerpesosavingsv1savings.DeleteApartadoResponse.new,
  );

  static const createFinancialGoal = connect.Spec(
    '/$name/CreateFinancialGoal',
    connect.StreamType.unary,
    primerpesosavingsv1savings.CreateFinancialGoalRequest.new,
    primerpesosavingsv1savings.CreateFinancialGoalResponse.new,
  );

  static const getFinancialGoal = connect.Spec(
    '/$name/GetFinancialGoal',
    connect.StreamType.unary,
    primerpesosavingsv1savings.GetFinancialGoalRequest.new,
    primerpesosavingsv1savings.GetFinancialGoalResponse.new,
  );

  static const listFinancialGoals = connect.Spec(
    '/$name/ListFinancialGoals',
    connect.StreamType.unary,
    primerpesosavingsv1savings.ListFinancialGoalsRequest.new,
    primerpesosavingsv1savings.ListFinancialGoalsResponse.new,
  );

  static const updateFinancialGoal = connect.Spec(
    '/$name/UpdateFinancialGoal',
    connect.StreamType.unary,
    primerpesosavingsv1savings.UpdateFinancialGoalRequest.new,
    primerpesosavingsv1savings.UpdateFinancialGoalResponse.new,
  );

  static const deleteFinancialGoal = connect.Spec(
    '/$name/DeleteFinancialGoal',
    connect.StreamType.unary,
    primerpesosavingsv1savings.DeleteFinancialGoalRequest.new,
    primerpesosavingsv1savings.DeleteFinancialGoalResponse.new,
  );

  static const createRecurringPaymentReminder = connect.Spec(
    '/$name/CreateRecurringPaymentReminder',
    connect.StreamType.unary,
    primerpesosavingsv1savings.CreateRecurringPaymentReminderRequest.new,
    primerpesosavingsv1savings.CreateRecurringPaymentReminderResponse.new,
  );

  static const getRecurringPaymentReminder = connect.Spec(
    '/$name/GetRecurringPaymentReminder',
    connect.StreamType.unary,
    primerpesosavingsv1savings.GetRecurringPaymentReminderRequest.new,
    primerpesosavingsv1savings.GetRecurringPaymentReminderResponse.new,
  );

  static const listRecurringPaymentReminders = connect.Spec(
    '/$name/ListRecurringPaymentReminders',
    connect.StreamType.unary,
    primerpesosavingsv1savings.ListRecurringPaymentRemindersRequest.new,
    primerpesosavingsv1savings.ListRecurringPaymentRemindersResponse.new,
  );

  static const updateRecurringPaymentReminder = connect.Spec(
    '/$name/UpdateRecurringPaymentReminder',
    connect.StreamType.unary,
    primerpesosavingsv1savings.UpdateRecurringPaymentReminderRequest.new,
    primerpesosavingsv1savings.UpdateRecurringPaymentReminderResponse.new,
  );

  static const deleteRecurringPaymentReminder = connect.Spec(
    '/$name/DeleteRecurringPaymentReminder',
    connect.StreamType.unary,
    primerpesosavingsv1savings.DeleteRecurringPaymentReminderRequest.new,
    primerpesosavingsv1savings.DeleteRecurringPaymentReminderResponse.new,
  );
}
