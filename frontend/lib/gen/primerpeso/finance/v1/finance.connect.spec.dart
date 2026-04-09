//
//  Generated code. Do not modify.
//  source: primerpeso/finance/v1/finance.proto
//

import "package:connectrpc/connect.dart" as connect;
import "finance.pb.dart" as primerpesofinancev1finance;

abstract final class FinanceService {
  /// Fully-qualified name of the FinanceService service.
  static const name = 'primerpeso.finance.v1.FinanceService';

  static const confirmExpense = connect.Spec(
    '/$name/ConfirmExpense',
    connect.StreamType.unary,
    primerpesofinancev1finance.ConfirmExpenseRequest.new,
    primerpesofinancev1finance.ConfirmExpenseResponse.new,
  );

  static const listExpenses = connect.Spec(
    '/$name/ListExpenses',
    connect.StreamType.unary,
    primerpesofinancev1finance.ListExpensesRequest.new,
    primerpesofinancev1finance.ListExpensesResponse.new,
  );

  static const getScoreSummary = connect.Spec(
    '/$name/GetScoreSummary',
    connect.StreamType.unary,
    primerpesofinancev1finance.GetScoreSummaryRequest.new,
    primerpesofinancev1finance.GetScoreSummaryResponse.new,
  );
}
