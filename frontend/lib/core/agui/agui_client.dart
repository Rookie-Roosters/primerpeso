import 'dart:async';

import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart'
    as structpb;

import '../../features/auth/data/auth_repository.dart';
import '../../gen/primerpeso/agent/v1/agent.connect.client.dart';
import '../../gen/primerpeso/agent/v1/agent.pb.dart' as agentv1;
import 'agui_event.dart';

class AgUiMessage {
  const AgUiMessage({
    required this.id,
    required this.role,
    required this.content,
  });

  final String id;
  final String role;
  final String content;
}

class AgUiToolDefinition {
  const AgUiToolDefinition({
    required this.name,
    required this.description,
    this.parameters = const {},
  });

  final String name;
  final String description;
  final Map<String, dynamic> parameters;
}

class AgUiRunInput {
  const AgUiRunInput({
    required this.threadId,
    required this.runId,
    required this.messages,
    this.state = const {},
    this.tools = const [],
  });

  final String threadId;
  final String runId;
  final List<AgUiMessage> messages;
  final Map<String, dynamic> state;
  final List<AgUiToolDefinition> tools;
}

abstract class AgUiClient {
  Stream<AgUiEvent> run(AgUiRunInput input);
  void close();
}

class ConnectAgUiClient implements AgUiClient {
  ConnectAgUiClient({required this.client, required this.accessTokenProvider});

  final AgentServiceClient client;
  final String? Function() accessTokenProvider;

  @override
  Stream<AgUiEvent> run(AgUiRunInput input) async* {
    final request = agentv1.RunRequest(
      threadId: input.threadId,
      runId: input.runId,
      messages: input.messages
          .map(
            (message) => agentv1.ChatMessage(
              id: message.id,
              role: message.role,
              content: message.content,
            ),
          )
          .toList(),
      tools: input.tools
          .map(
            (tool) => agentv1.ToolDefinition(
              name: tool.name,
              description: tool.description,
              parameters: _structFromJson(tool.parameters),
            ),
          )
          .toList(),
    );
    if (input.state.isNotEmpty) {
      request.state = _structFromJson(input.state);
    }

    final stream = client.run(
      request,
      headers: authHeaders(accessTokenProvider()),
    );
    await for (final event in stream) {
      yield AgUiEvent.fromProto(event);
    }
  }

  @override
  void close() {}
}

structpb.Struct _structFromJson(Map<String, dynamic> value) {
  final struct = structpb.Struct();
  struct.mergeFromProto3Json(value);
  return struct;
}
