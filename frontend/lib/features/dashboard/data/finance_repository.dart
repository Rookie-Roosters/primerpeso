import 'package:fixnum/fixnum.dart';

import '../../../gen/primerpeso/documents/v1/documents.pb.dart' as documentsv1;
import '../../../gen/primerpeso/finance/v1/finance.connect.client.dart';
import '../../../gen/primerpeso/finance/v1/finance.pb.dart' as financev1;
import '../../auth/data/auth_repository.dart';

class FinanceRepository {
  FinanceRepository({required this.client});

  final FinanceServiceClient client;

  Future<financev1.GetScoreSummaryResponse> getScoreSummary(
    String accessToken,
  ) {
    return client.getScoreSummary(
      financev1.GetScoreSummaryRequest(),
      headers: authHeaders(accessToken),
    );
  }

  Future<financev1.ConfirmExpenseResponse> confirmExpense({
    required String accessToken,
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
      headers: authHeaders(accessToken),
    );
  }
}
