import '../../gen/primerpeso/agent/v1/agent.pb.dart' as agentv1;

// AG-UI (Agent-User Interaction) protocol event types.
//
// The backend streams typed ConnectRPC protobuf events. We translate them into
// lightweight UI events so the chat shard stays transport-agnostic.

sealed class AgUiEvent {
  const AgUiEvent({this.threadId, this.runId});

  final String? threadId;
  final String? runId;

  factory AgUiEvent.fromProto(agentv1.RunEvent event) {
    switch (event.whichEvent()) {
      case agentv1.RunEvent_Event.runStarted:
        final value = event.runStarted;
        return RunStarted(threadId: value.threadId, runId: value.runId);
      case agentv1.RunEvent_Event.runFinished:
        final value = event.runFinished;
        return RunFinished(threadId: value.threadId, runId: value.runId);
      case agentv1.RunEvent_Event.runError:
        final value = event.runError;
        return RunError(
          threadId: value.threadId,
          runId: value.runId,
          message: value.message,
          code: value.hasCode() ? value.code : null,
        );
      case agentv1.RunEvent_Event.textMessageStart:
        final value = event.textMessageStart;
        return TextMessageStart(
          threadId: value.threadId,
          runId: value.runId,
          messageId: value.messageId,
          role: value.role,
        );
      case agentv1.RunEvent_Event.textMessageContent:
        final value = event.textMessageContent;
        return TextMessageContent(
          threadId: value.threadId,
          runId: value.runId,
          messageId: value.messageId,
          delta: value.delta,
        );
      case agentv1.RunEvent_Event.textMessageEnd:
        final value = event.textMessageEnd;
        return TextMessageEnd(
          threadId: value.threadId,
          runId: value.runId,
          messageId: value.messageId,
        );
      case agentv1.RunEvent_Event.toolCallStart:
        final value = event.toolCallStart;
        return ToolCallStart(
          threadId: value.threadId,
          runId: value.runId,
          toolCallId: value.toolCallId,
          name: value.name,
        );
      case agentv1.RunEvent_Event.toolCallArgs:
        final value = event.toolCallArgs;
        return ToolCallArgs(
          threadId: value.threadId,
          runId: value.runId,
          toolCallId: value.toolCallId,
          argsDelta: value.delta,
        );
      case agentv1.RunEvent_Event.toolCallEnd:
        final value = event.toolCallEnd;
        return ToolCallEnd(
          threadId: value.threadId,
          runId: value.runId,
          toolCallId: value.toolCallId,
        );
      case agentv1.RunEvent_Event.stateDelta:
        final value = event.stateDelta;
        final patch = <String, dynamic>{};
        final deltaJson = value.hasDelta() ? value.delta.toProto3Json() : null;
        if (deltaJson is Map) {
          patch.addAll(Map<String, dynamic>.from(deltaJson));
        }
        final scoreJson = value.hasScoreSummary()
            ? value.scoreSummary.toProto3Json()
            : null;
        if (scoreJson != null) {
          patch['scoreSummary'] = scoreJson;
        }
        return StateDelta(
          threadId: value.threadId,
          runId: value.runId,
          patch: patch,
        );
      case agentv1.RunEvent_Event.notSet:
        return const UnknownEvent(rawType: 'notSet', raw: {});
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
  const TextMessageEnd({super.threadId, super.runId, required this.messageId});

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
  const ToolCallEnd({super.threadId, super.runId, required this.toolCallId});

  final String toolCallId;
}

final class StateDelta extends AgUiEvent {
  const StateDelta({super.threadId, super.runId, required this.patch});

  final Map<String, dynamic> patch;
}

final class UnknownEvent extends AgUiEvent {
  const UnknownEvent({required this.rawType, required this.raw});

  final String rawType;
  final Map<String, dynamic> raw;
}
