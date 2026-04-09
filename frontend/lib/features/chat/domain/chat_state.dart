import 'chat_message.dart';

/// High-level streaming state of the chat.
enum RunStatus { idle, streaming, error }

/// Immutable snapshot consumed by the chat surface.
///
/// `messages` is the committed history. `draftAssistant` is the in-flight
/// assistant turn (non-null only while [runStatus] == [RunStatus.streaming])
/// — it gets committed into `messages` on `TEXT_MESSAGE_END`. `agentState`
/// accumulates `STATE_DELTA` patches; the chat surface ignores it today but
/// future surfaces (dashboard, score) will read from it.
class ChatState {
  const ChatState({
    required this.messages,
    required this.draftAssistant,
    required this.runStatus,
    required this.agentState,
    required this.errorMessage,
  });

  const ChatState.initial()
      : messages = const [],
        draftAssistant = null,
        runStatus = RunStatus.idle,
        agentState = const {},
        errorMessage = null;

  final List<ChatMessage> messages;
  final ChatMessage? draftAssistant;
  final RunStatus runStatus;
  final Map<String, dynamic> agentState;
  final String? errorMessage;

  bool get isStreaming => runStatus == RunStatus.streaming;

  ChatState copyWith({
    List<ChatMessage>? messages,
    ChatMessage? draftAssistant,
    bool clearDraft = false,
    RunStatus? runStatus,
    Map<String, dynamic>? agentState,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      draftAssistant:
          clearDraft ? null : (draftAssistant ?? this.draftAssistant),
      runStatus: runStatus ?? this.runStatus,
      agentState: agentState ?? this.agentState,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
