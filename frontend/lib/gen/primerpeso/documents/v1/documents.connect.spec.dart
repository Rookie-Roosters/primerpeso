//
//  Generated code. Do not modify.
//  source: primerpeso/documents/v1/documents.proto
//

import "package:connectrpc/connect.dart" as connect;
import "documents.pb.dart" as primerpesodocumentsv1documents;

abstract final class ReceiptService {
  /// Fully-qualified name of the ReceiptService service.
  static const name = 'primerpeso.documents.v1.ReceiptService';

  static const uploadReceipt = connect.Spec(
    '/$name/UploadReceipt',
    connect.StreamType.unary,
    primerpesodocumentsv1documents.UploadReceiptRequest.new,
    primerpesodocumentsv1documents.UploadReceiptResponse.new,
  );

  static const getReceiptDraft = connect.Spec(
    '/$name/GetReceiptDraft',
    connect.StreamType.unary,
    primerpesodocumentsv1documents.GetReceiptDraftRequest.new,
    primerpesodocumentsv1documents.GetReceiptDraftResponse.new,
  );

  static const listReceiptDrafts = connect.Spec(
    '/$name/ListReceiptDrafts',
    connect.StreamType.unary,
    primerpesodocumentsv1documents.ListReceiptDraftsRequest.new,
    primerpesodocumentsv1documents.ListReceiptDraftsResponse.new,
  );
}
