import 'package:fixnum/fixnum.dart';

import '../../../gen/primerpeso/documents/v1/documents.pb.dart' as documentsv1;
import '../../../gen/primerpeso/finance/v1/finance.connect.client.dart';
import '../../../gen/primerpeso/finance/v1/finance.pb.dart' as financev1;
import '../../../core/api/request_headers.dart';

class FinanceRepository {
  FinanceRepository({required this.client, required this.deviceId});

  final FinanceServiceClient client;
  final String deviceId;

  Future<financev1.GetScoreSummaryResponse> getScoreSummary() {
    return client.getScoreSummary(
      financev1.GetScoreSummaryRequest(),
      headers: deviceHeaders(deviceId),
    );
  }

  Future<financev1.ConfirmExpenseResponse> confirmExpense({
    required documentsv1.ReceiptDraft draft,
    required String merchantName,
    required String displayTitle,
    required String category,
    required int amountUnits,
  }) {
    return client.confirmExpense(
      financev1.ConfirmExpenseRequest(
        receiptId: draft.id,
        merchantName: merchantName,
        displayTitle: displayTitle,
        category: category,
        amount: financev1.Money(
          currencyCode: draft.total.currencyCode,
          units: Int64(amountUnits),
          nanos: draft.total.nanos,
        ),
        occurredAt: draft.purchasedAt,
      ),
      headers: deviceHeaders(deviceId),
    );
  }

  Future<List<financev1.Expense>> listExpenses({int pageSize = 100}) async {
    final response = await client.listExpenses(
      financev1.ListExpensesRequest(pageSize: pageSize),
      headers: deviceHeaders(deviceId),
    );
    return response.expenses;
  }
}
