import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'agui_event.dart';
import 'sse_parser.dart';

/// A minimal AG-UI message in the request payload.
///
/// AG-UI accepts an OpenAI-style `messages` array. We model only the fields
/// the chat surface needs today; extend as the backend grows.
class AgUiMessage {
  const AgUiMessage({
    required this.id,
    required this.role,
    required this.content,
  });

  final String id;
  final String role;
  final String content;

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'content': content,
      };
}

/// A tool definition advertised to the agent.
class AgUiToolDefinition {
  const AgUiToolDefinition({
    required this.name,
    required this.description,
    this.parameters = const {},
  });

  final String name;
  final String description;
  final Map<String, dynamic> parameters;

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'parameters': parameters,
      };
}

/// AG-UI Run input — the request body POSTed to the agent endpoint.
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

  Map<String, dynamic> toJson() => {
        'threadId': threadId,
        'runId': runId,
        'messages': messages.map((m) => m.toJson()).toList(),
        'state': state,
        'tools': tools.map((t) => t.toJson()).toList(),
      };
}

/// Streams AG-UI events from an agent backend.
///
/// The interface is transport-agnostic so we can swap a real HTTP/SSE
/// implementation ([HttpAgUiClient]) with an in-memory fake during the
/// skeleton phase ([fake_agui_server.dart]).
abstract class AgUiClient {
  /// Single-subscription per call. Completes when the upstream stream
  /// closes (typically right after `RUN_FINISHED`); errors propagate.
  Stream<AgUiEvent> run(AgUiRunInput input);

  /// Releases any resources held by this client.
  void close();
}

/// HTTP/SSE implementation of [AgUiClient].
class HttpAgUiClient implements AgUiClient {
  HttpAgUiClient({required this.endpoint, http.Client? httpClient})
      : _http = httpClient ?? http.Client();

  /// HTTP endpoint that accepts an AG-UI run request and streams events.
  final Uri endpoint;
  final http.Client _http;

  @override
  Stream<AgUiEvent> run(AgUiRunInput input) async* {
    final request = http.Request('POST', endpoint)
      ..headers['accept'] = 'text/event-stream'
      ..headers['content-type'] = 'application/json'
      ..body = jsonEncode(input.toJson());

    final response = await _http.send(request);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AgUiTransportException(
        'AG-UI endpoint returned HTTP ${response.statusCode}',
        statusCode: response.statusCode,
      );
    }

    await for (final block in parseSse(response.stream)) {
      if (block.data.isEmpty) continue;
      final decoded = jsonDecode(block.data);
      if (decoded is! Map<String, dynamic>) continue;
      yield AgUiEvent.fromJson(decoded);
    }
  }

  @override
  void close() => _http.close();
}

class AgUiTransportException implements Exception {
  const AgUiTransportException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'AgUiTransportException: $message';
}
