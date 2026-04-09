import '../../../core/agui/agui_client.dart';
import '../../../core/agui/agui_event.dart';
import '../domain/chat_message.dart';

typedef ChatStateBuilder = Map<String, dynamic> Function();

class ChatRepository {
  ChatRepository({
    required this.client,
    required this.threadId,
    required this.stateBuilder,
    this.tools = const [],
  });

  final AgUiClient client;
  final String threadId;
  final ChatStateBuilder stateBuilder;
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
      state: stateBuilder(),
      tools: tools,
    );
    return client.run(input);
  }

  void close() => client.close();
}
