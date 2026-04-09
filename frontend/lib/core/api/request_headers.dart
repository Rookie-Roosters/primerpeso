import 'package:connectrpc/connect.dart' as connect;

connect.Headers deviceHeaders(String deviceId) {
  final headers = connect.Headers();
  headers['X-Device-ID'] = deviceId;
  return headers;
}
