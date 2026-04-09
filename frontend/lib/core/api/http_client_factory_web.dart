import 'package:connectrpc/connect.dart' as connect;
import 'package:connectrpc/web.dart' as connect_web;

connect.HttpClient createHttpClientImpl() {
  return connect_web.createHttpClient(credentials: 'include');
}
