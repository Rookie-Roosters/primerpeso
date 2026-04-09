//
//  Generated code. Do not modify.
//  source: primerpeso/documents/v1/documents.proto
//

import "package:connectrpc/connect.dart" as connect;
import "documents.pb.dart" as primerpesodocumentsv1documents;
import "documents.connect.spec.dart" as specs;

extension type ReceiptServiceClient (connect.Transport _transport) {
  Future<primerpesodocumentsv1documents.UploadReceiptResponse> uploadReceipt(
    primerpesodocumentsv1documents.UploadReceiptRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ReceiptService.uploadReceipt,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesodocumentsv1documents.GetReceiptDraftResponse> getReceiptDraft(
    primerpesodocumentsv1documents.GetReceiptDraftRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ReceiptService.getReceiptDraft,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<primerpesodocumentsv1documents.ListReceiptDraftsResponse> listReceiptDrafts(
    primerpesodocumentsv1documents.ListReceiptDraftsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ReceiptService.listReceiptDrafts,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
