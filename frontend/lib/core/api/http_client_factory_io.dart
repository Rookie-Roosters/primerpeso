import 'dart:io';

import 'package:connectrpc/connect.dart' as connect;
import 'package:connectrpc/io.dart' as connect_io;

connect.HttpClient createHttpClientImpl() {
  final client = HttpClient();
  return connect_io.createHttpClient(client);
}
