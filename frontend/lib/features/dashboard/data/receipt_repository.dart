import 'dart:typed_data';

import '../../../gen/primerpeso/documents/v1/documents.connect.client.dart';
import '../../../gen/primerpeso/documents/v1/documents.pb.dart' as documentsv1;
import '../../../core/api/request_headers.dart';

class ReceiptRepository {
  ReceiptRepository({required this.client, required this.deviceId});

  final ReceiptServiceClient client;
  final String deviceId;

  Future<documentsv1.UploadReceiptResponse> uploadReceipt({
    required Uint8List content,
    required String filename,
    required String mimeType,
  }) async {
    return client.uploadReceipt(
      documentsv1.UploadReceiptRequest(
        content: content,
        filename: filename,
        mimeType: mimeType,
      ),
      headers: deviceHeaders(deviceId),
    );
  }
}
