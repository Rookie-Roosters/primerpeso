import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/connect.dart' as connect_protocol;
import 'package:flutter/foundation.dart';

import '../../gen/primerpeso/agent/v1/agent.connect.client.dart';
import '../../gen/primerpeso/documents/v1/documents.connect.client.dart';
import '../../gen/primerpeso/finance/v1/finance.connect.client.dart';
import '../../gen/primerpeso/identity/v1/identity.connect.client.dart';
import '../finance/ledger_refresh_notifier.dart';
import '../../features/dashboard/data/finance_repository.dart';
import '../../features/dashboard/data/receipt_repository.dart';
import 'http_client_factory.dart';

class AppServices {
  AppServices._({
    required this.deviceId,
    required this.identityClient,
    required this.agentClient,
    required this.receiptClient,
    required this.financeClient,
    required this.receiptRepository,
    required this.financeRepository,
    required this.ledgerRefresh,
  });

  factory AppServices.create({required String deviceId}) {
    final transport = connect_protocol.Transport(
      baseUrl: _defaultApiBaseUrl(),
      codec: const ProtoCodec(),
      httpClient: createPlatformHttpClient(),
    );

    final identityClient = IdentityServiceClient(transport);
    final agentClient = AgentServiceClient(transport);
    final receiptClient = ReceiptServiceClient(transport);
    final financeClient = FinanceServiceClient(transport);

    return AppServices._(
      deviceId: deviceId,
      identityClient: identityClient,
      agentClient: agentClient,
      receiptClient: receiptClient,
      financeClient: financeClient,
      receiptRepository: ReceiptRepository(
        client: receiptClient,
        deviceId: deviceId,
      ),
      financeRepository: FinanceRepository(
        client: financeClient,
        deviceId: deviceId,
      ),
      ledgerRefresh: LedgerRefreshNotifier(),
    );
  }

  final String deviceId;
  final IdentityServiceClient identityClient;
  final AgentServiceClient agentClient;
  final ReceiptServiceClient receiptClient;
  final FinanceServiceClient financeClient;

  final ReceiptRepository receiptRepository;
  final FinanceRepository financeRepository;
  final LedgerRefreshNotifier ledgerRefresh;
}

String _defaultApiBaseUrl() {
  const fromEnvironment = String.fromEnvironment('PRIMERPESO_API_BASE_URL');
  if (fromEnvironment.isNotEmpty) {
    return fromEnvironment;
  }

  if (kIsWeb) {
    return 'http://localhost:8080';
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return 'http://10.0.2.2:8080';
    default:
      return 'http://localhost:8080';
  }
}
