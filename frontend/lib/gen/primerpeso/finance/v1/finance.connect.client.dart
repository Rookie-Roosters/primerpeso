//
//  Generated code. Do not modify.
//  source: primerpeso/finance/v1/finance.proto
//

import "package:connectrpc/connect.dart" as connect;
import "finance.pb.dart" as primerpesofinancev1finance;
import "finance.connect.spec.dart" as specs;

extension type FinanceServiceClient (connect.Transport _transport) {
  Future<primerpesofinancev1finance.ConfirmExpenseResponse> confirmExpense(
    primerpesofinancev1finance.ConfirmExpenseRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.FinanceService.confirmExpense,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesofinancev1finance.ListExpensesResponse> listExpenses(
    primerpesofinancev1finance.ListExpensesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.FinanceService.listExpenses,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesofinancev1finance.GetScoreSummaryResponse> getScoreSummary(
    primerpesofinancev1finance.GetScoreSummaryRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.FinanceService.getScoreSummary,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
