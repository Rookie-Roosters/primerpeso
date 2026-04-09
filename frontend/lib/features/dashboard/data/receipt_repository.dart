import 'dart:typed_data';

import '../../../gen/primerpeso/documents/v1/documents.connect.client.dart';
import '../../../gen/primerpeso/documents/v1/documents.pb.dart' as documentsv1;
import '../../auth/data/auth_repository.dart';

class ReceiptRepository {
  ReceiptRepository({required this.client});

  final ReceiptServiceClient client;

  Future<documentsv1.ReceiptDraft> uploadReceipt({
    required String accessToken,
    required Uint8List content,
    required String filename,
    required String mimeType,
  }) async {
    final response = await client.uploadReceipt(
      documentsv1.UploadReceiptRequest(
        content: content,
        filename: filename,
        mimeType: mimeType,
      ),
      headers: authHeaders(accessToken),
    );
    return response.draft;
  }
}
