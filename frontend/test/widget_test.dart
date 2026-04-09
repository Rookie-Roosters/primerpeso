// Smoke test: the app boots and the chat surface is the initial route.

import 'package:flutter_test/flutter_test.dart';

import 'package:primerpeso/app/app.dart';

void main() {
  testWidgets('App boots into the chat surface', (tester) async {
    await tester.pumpWidget(const App());
    // Let the fake AG-UI client + initial route settle.
    await tester.pump();

    // The empty-state hint in ChatScreen tells us we landed on /chat.
    expect(find.text('Hola, soy Peso.'), findsOneWidget);
  });
}
