//
//  Generated code. Do not modify.
//  source: primerpeso/agent/v1/agent.proto
//

import "package:connectrpc/connect.dart" as connect;
import "agent.pb.dart" as primerpesoagentv1agent;

abstract final class AgentService {
  /// Fully-qualified name of the AgentService service.
  static const name = 'primerpeso.agent.v1.AgentService';

  static const run = connect.Spec(
    '/$name/Run',
    connect.StreamType.server,
    primerpesoagentv1agent.RunRequest.new,
    primerpesoagentv1agent.RunEvent.new,
  );
}
