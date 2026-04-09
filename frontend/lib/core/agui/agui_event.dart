// AG-UI (Agent-User Interaction) protocol event types.
//
// Models the day-one set the chat surface needs to render token-streaming
// assistant turns and react to agent-driven navigation. The protocol uses a
// JSON object with a `type` discriminator; new event types arrive as
// `UnknownEvent` so the client never breaks when the backend evolves.
//
// Reference: https://docs.ag-ui.com — protocol is transport-agnostic; we
// consume it over SSE in `AgUiClient`.

sealed class AgUiEvent {
  const AgUiEvent({this.threadId, this.runId});

  final String? threadId;
  final String? runId;

  /// Decodes a single AG-UI event JSON object.
  ///
  /// Unknown `type` values become an [UnknownEvent] rather than throwing,
  /// so the chat shard can log and keep streaming.
  factory AgUiEvent.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String? ?? '';
    final threadId = json['threadId'] as String?;
    final runId = json['runId'] as String?;

    switch (type) {
      case 'RUN_STARTED':
        return RunStarted(threadId: threadId, runId: runId);
      case 'RUN_FINISHED':
        return RunFinished(threadId: threadId, runId: runId);
      case 'RUN_ERROR':
        return RunError(
          threadId: threadId,
          runId: runId,
          message: json['message'] as String? ?? 'Unknown error',
          code: json['code'] as String?,
        );
      case 'TEXT_MESSAGE_START':
        return TextMessageStart(
          threadId: threadId,
          runId: runId,
          messageId: json['messageId'] as String? ?? '',
          role: json['role'] as String? ?? 'assistant',
        );
      case 'TEXT_MESSAGE_CONTENT':
        return TextMessageContent(
          threadId: threadId,
          runId: runId,
          messageId: json['messageId'] as String? ?? '',
          delta: json['delta'] as String? ?? '',
        );
      case 'TEXT_MESSAGE_END':
        return TextMessageEnd(
          threadId: threadId,
          runId: runId,
          messageId: json['messageId'] as String? ?? '',
        );
      case 'TOOL_CALL_START':
        return ToolCallStart(
          threadId: threadId,
          runId: runId,
          toolCallId: json['toolCallId'] as String? ?? '',
          name: json['toolCallName'] as String? ??
              json['name'] as String? ??
              '',
        );
      case 'TOOL_CALL_ARGS':
        return ToolCallArgs(
          threadId: threadId,
          runId: runId,
          toolCallId: json['toolCallId'] as String? ?? '',
          argsDelta: json['delta'] as String? ?? '',
        );
      case 'TOOL_CALL_END':
        return ToolCallEnd(
          threadId: threadId,
          runId: runId,
          toolCallId: json['toolCallId'] as String? ?? '',
        );
      case 'STATE_DELTA':
        final patch = json['delta'];
        return StateDelta(
          threadId: threadId,
          runId: runId,
          patch: patch is Map<String, dynamic> ? patch : const {},
        );
      default:
        return UnknownEvent(rawType: type, raw: json);
    }
  }
}

final class RunStarted extends AgUiEvent {
  const RunStarted({super.threadId, super.runId});
}

final class RunFinished extends AgUiEvent {
  const RunFinished({super.threadId, super.runId});
}

final class RunError extends AgUiEvent {
  const RunError({
    super.threadId,
    super.runId,
    required this.message,
    this.code,
  });

  final String message;
  final String? code;
}

final class TextMessageStart extends AgUiEvent {
  const TextMessageStart({
    super.threadId,
    super.runId,
    required this.messageId,
    required this.role,
  });

  final String messageId;
  final String role;
}

final class TextMessageContent extends AgUiEvent {
  const TextMessageContent({
    super.threadId,
    super.runId,
    required this.messageId,
    required this.delta,
  });

  final String messageId;
  final String delta;
}

final class TextMessageEnd extends AgUiEvent {
  const TextMessageEnd({
    super.threadId,
    super.runId,
    required this.messageId,
  });

  final String messageId;
}

final class ToolCallStart extends AgUiEvent {
  const ToolCallStart({
    super.threadId,
    super.runId,
    required this.toolCallId,
    required this.name,
  });

  final String toolCallId;
  final String name;
}

final class ToolCallArgs extends AgUiEvent {
  const ToolCallArgs({
    super.threadId,
    super.runId,
    required this.toolCallId,
    required this.argsDelta,
  });

  final String toolCallId;
  final String argsDelta;
}

final class ToolCallEnd extends AgUiEvent {
  const ToolCallEnd({
    super.threadId,
    super.runId,
    required this.toolCallId,
  });

  final String toolCallId;
}

final class StateDelta extends AgUiEvent {
  const StateDelta({
    super.threadId,
    super.runId,
    required this.patch,
  });

  final Map<String, dynamic> patch;
}

final class UnknownEvent extends AgUiEvent {
  const UnknownEvent({required this.rawType, required this.raw});

  final String rawType;
  final Map<String, dynamic> raw;
}
