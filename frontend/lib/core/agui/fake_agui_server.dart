import 'dart:async';

import 'agui_client.dart';
import 'agui_event.dart';

/// In-memory fake of an AG-UI server for the skeleton phase.
///
/// Yields a scripted token-by-token reply so the chat surface can be
/// developed and demoed without a running Go backend. Swap to a real
/// [AgUiClient] from `main.dart` once the agent endpoint is live.
class FakeAgUiClient implements AgUiClient {
  FakeAgUiClient();

  @override
  Stream<AgUiEvent> run(AgUiRunInput input) async* {
    final lastUserText = input.messages
        .lastWhere(
          (m) => m.role == 'user',
          orElse: () => const AgUiMessage(id: '', role: 'user', content: ''),
        )
        .content;

    yield RunStarted(threadId: input.threadId, runId: input.runId);
    await _tick();

    final messageId = 'fake-${DateTime.now().millisecondsSinceEpoch}';
    yield TextMessageStart(
      threadId: input.threadId,
      runId: input.runId,
      messageId: messageId,
      role: 'assistant',
    );

    final reply = _scriptedReply(lastUserText);
    // Single delta keeps spacing and wrapping predictable in the UI; swap
    // back to token streaming when the real SSE client is tuned.
    yield TextMessageContent(
      threadId: input.threadId,
      runId: input.runId,
      messageId: messageId,
      delta: reply,
    );
    await _tick(40);

    yield TextMessageEnd(
      threadId: input.threadId,
      runId: input.runId,
      messageId: messageId,
    );
    await _tick();
    yield RunFinished(threadId: input.threadId, runId: input.runId);
  }

  @override
  void close() {}

  String _scriptedReply(String userText) {
    final trimmed = userText.trim().toLowerCase();
    if (trimmed.isEmpty) {
      return 'Hola, soy Peso. Cuéntame en qué quieres trabajar tu primer peso hoy.';
    }
    if (trimmed.contains('hola') || trimmed.contains('hi')) {
      return '¡Hola! Soy Peso, tu compañero financiero. ¿Quieres revisar tu criterio score o simular un gasto?';
    }
    if (trimmed.contains('score') || trimmed.contains('criterio')) {
      return 'Tu criterio score se mueve con cada decisión. Abre el dashboard para verlo en detalle.';
    }
    return 'Recibido: "$userText". En cuanto el backend AG-UI esté en línea, esta respuesta vendrá del agente real.';
  }

  Future<void> _tick([int ms = 80]) =>
      Future<void>.delayed(Duration(milliseconds: ms));
}
