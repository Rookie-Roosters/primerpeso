// Smoke test: the app boots into the auth gate on the chat route.

import 'package:flutter_test/flutter_test.dart';

import 'package:primerpeso/app/app.dart';

void main() {
  testWidgets('App boots into the auth gate', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pump();

    expect(find.text('Entra para hablar con Peso'), findsOneWidget);
  });
}
