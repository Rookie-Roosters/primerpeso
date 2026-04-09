//
//  Generated code. Do not modify.
//  source: primerpeso/agent/v1/agent.proto
//

import "package:connectrpc/connect.dart" as connect;
import "agent.pb.dart" as primerpesoagentv1agent;
import "agent.connect.spec.dart" as specs;

extension type AgentServiceClient (connect.Transport _transport) {
  Stream<primerpesoagentv1agent.RunEvent> run(
    primerpesoagentv1agent.RunRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).server(
      specs.AgentService.run,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
