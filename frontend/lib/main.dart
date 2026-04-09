import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'core/session/app_session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final session = await AppSession.bootstrap();
  runApp(App(session: session));
}
