import 'package:connectrpc/connect.dart' as connect;

import 'http_client_factory_io.dart'
    if (dart.library.js_interop) 'http_client_factory_web.dart'
    as impl;

connect.HttpClient createPlatformHttpClient() => impl.createHttpClientImpl();
