import '../../../core/agui/agui_client.dart';
import '../../../core/agui/agui_event.dart';
import '../domain/chat_message.dart';

/// Thin facade over [AgUiClient] that turns local [ChatMessage]s into an
/// AG-UI run input.
///
/// Holds the conversation `threadId` so multi-turn runs share context, and
/// generates a fresh `runId` per send. Tool definitions are static for now —
/// the chat surface tells the agent what it can suggest opening.
class ChatRepository {
  ChatRepository({
    required this.client,
    required this.threadId,
    this.tools = const [],
  });

  final AgUiClient client;
  final String threadId;
  final List<AgUiToolDefinition> tools;

  int _runCounter = 0;

  Stream<AgUiEvent> sendMessages(List<ChatMessage> messages) {
    _runCounter += 1;
    final runId = '$threadId-run-$_runCounter';
    final input = AgUiRunInput(
      threadId: threadId,
      runId: runId,
      messages: messages
          .where((m) => m.role == ChatRole.user || m.role == ChatRole.assistant)
          .map(
            (m) => AgUiMessage(
              id: m.id,
              role: m.role == ChatRole.user ? 'user' : 'assistant',
              content: m.content,
            ),
          )
          .toList(),
      tools: tools,
    );
    return client.run(input);
  }

  void close() => client.close();
}
