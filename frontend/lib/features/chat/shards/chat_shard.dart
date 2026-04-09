import 'dart:async';
import 'dart:convert';

import 'package:shard/shard.dart';

import '../../../core/agui/agui_event.dart';
import '../data/chat_repository.dart';
import '../domain/chat_message.dart';
import '../domain/chat_state.dart';

/// Callback the agent uses to drive navigation via tool calls.
///
/// Wired in [ChatScreen] so the shard remains testable: a unit test can
/// pass a noop callback and assert that `open_dashboard` triggers it
/// without spinning up a router.
typedef ChatNavigateCallback =
    void Function(String toolName, Map<String, dynamic> args);

/// Streams an AG-UI run into a [ChatState].
///
/// We use [Shard] (not `StreamShard`) because the SSE stream is per-`send()`
/// rather than per-shard-lifetime: a new subscription is created on every
/// user turn and torn down on `RUN_FINISHED` / error / dispose.
class ChatShard extends Shard<ChatState> {
  ChatShard({required this.repository, required this.onNavigate})
    : super(const ChatState.initial());

  final ChatRepository repository;
  final ChatNavigateCallback onNavigate;

  StreamSubscription<AgUiEvent>? _sub;

  /// Per-message-id buffer for streaming tool-call argument deltas.
  final Map<String, StringBuffer> _toolArgsBuffers = {};

  /// `toolCallId` → `toolName`, captured at TOOL_CALL_START.
  final Map<String, String> _toolNames = {};

  /// Identity equality is enough — the shard always emits a fresh
  /// [ChatState] on every meaningful change, and reference compare keeps
  /// `emit` cheap during high-frequency token deltas.
  @override
  bool stateEquals(ChatState a, ChatState b) => identical(a, b);

  /// Sends a user turn and starts streaming the agent reply.
  ///
  /// Idempotent during a stream: if a run is already in flight the call
  /// is ignored. Trim/blank guarding lives at the call site.
  Future<void> send(String text) async {
    if (state.isStreaming) return;
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final userMessage = ChatMessage(
      id: 'u-${DateTime.now().microsecondsSinceEpoch}',
      role: ChatRole.user,
      content: trimmed,
    );

    final nextMessages = [...state.messages, userMessage];
    emit(
      state.copyWith(
        messages: nextMessages,
        runStatus: RunStatus.streaming,
        clearError: true,
        clearDraft: true,
      ),
    );

    await _sub?.cancel();
    _sub = repository
        .sendMessages(nextMessages)
        .listen(
          _handleEvent,
          onError: _handleError,
          onDone: _handleDone,
          cancelOnError: false,
        );
  }

  void _handleEvent(AgUiEvent event) {
    switch (event) {
      case TextMessageStart(:final messageId, :final role):
        emit(
          state.copyWith(
            draftAssistant: ChatMessage(
              id: messageId,
              role: role == 'assistant'
                  ? ChatRole.assistant
                  : ChatRole.assistant,
              content: '',
            ),
          ),
        );

      case TextMessageContent(:final messageId, :final delta):
        final draft = state.draftAssistant;
        if (draft == null || draft.id != messageId) return;
        emit(
          state.copyWith(
            draftAssistant: draft.copyWith(content: draft.content + delta),
          ),
        );

      case TextMessageEnd(:final messageId):
        final draft = state.draftAssistant;
        if (draft == null || draft.id != messageId) return;
        emit(
          state.copyWith(
            messages: [...state.messages, draft],
            clearDraft: true,
          ),
        );

      case ToolCallStart(:final toolCallId, :final name):
        _toolNames[toolCallId] = name;
        _toolArgsBuffers[toolCallId] = StringBuffer();

      case ToolCallArgs(:final toolCallId, :final argsDelta):
        _toolArgsBuffers[toolCallId]?.write(argsDelta);

      case ToolCallEnd(:final toolCallId):
        final name = _toolNames.remove(toolCallId) ?? 'unknown';
        final raw = _toolArgsBuffers.remove(toolCallId)?.toString() ?? '';
        Map<String, dynamic> args = const {};
        if (raw.isNotEmpty) {
          try {
            final decoded = jsonDecode(raw);
            if (decoded is Map<String, dynamic>) args = decoded;
          } catch (e, st) {
            addError(e, st);
          }
        }
        final toolMessage = ChatMessage(
          id: 't-$toolCallId',
          role: ChatRole.tool,
          content: raw,
          toolName: name,
        );
        emit(state.copyWith(messages: [...state.messages, toolMessage]));
        // Fire-and-forget: navigation is a side effect, never blocks the
        // event loop.
        onNavigate(name, args);

      case StateDelta(:final patch):
        emit(state.copyWith(agentState: {...state.agentState, ...patch}));

      case RunStarted():
        // No-op: streaming flag was set by send().
        break;

      case RunFinished():
        emit(state.copyWith(runStatus: RunStatus.idle));

      case RunError(:final message):
        emit(
          state.copyWith(
            runStatus: RunStatus.error,
            errorMessage: message,
            clearDraft: true,
          ),
        );

      case UnknownEvent(:final rawType):
        addError('Unknown AG-UI event: $rawType');
    }
  }

  void _handleError(Object error, StackTrace stackTrace) {
    addError(error, stackTrace);
    emit(
      state.copyWith(
        runStatus: RunStatus.error,
        errorMessage: error.toString(),
        clearDraft: true,
      ),
    );
  }

  void _handleDone() {
    if (state.runStatus == RunStatus.streaming) {
      emit(state.copyWith(runStatus: RunStatus.idle));
    }
  }

  /// Clears any current error so the composer can be re-enabled after the
  /// user dismisses the alert.
  void clearError() {
    if (state.errorMessage == null && state.runStatus != RunStatus.error) {
      return;
    }
    emit(state.copyWith(runStatus: RunStatus.idle, clearError: true));
  }

  void addSystemMessage(String content) {
    final trimmed = content.trim();
    if (trimmed.isEmpty) return;
    final message = ChatMessage(
      id: 's-${DateTime.now().microsecondsSinceEpoch}',
      role: ChatRole.system,
      content: trimmed,
    );
    emit(state.copyWith(messages: [...state.messages, message]));
  }

  @override
  void dispose() {
    _sub?.cancel();
    repository.close();
    super.dispose();
  }
}
