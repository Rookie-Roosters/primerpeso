// Smoke test: first boot goes through welcome.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:primerpeso/app/app.dart';
import 'package:primerpeso/core/session/app_session.dart';

void main() {
  testWidgets('App boots into welcome', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final session = await AppSession.bootstrap();
    await tester.pumpWidget(App(session: session));
    await tester.pump();

    expect(find.text('Bienvenido a PrimerPeso'), findsOneWidget);
  });
}
