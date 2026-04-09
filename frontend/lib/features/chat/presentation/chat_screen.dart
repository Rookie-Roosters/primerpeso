import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:shard/shard.dart';

import '../../../core/agui/agui_client.dart';
import '../../../core/app_scope.dart';
import '../../../core/theme/green_tokens.dart';
import '../../../gen/primerpeso/agent/v1/agent.connect.client.dart';
import '../../auth/domain/auth_state.dart';
import '../../auth/presentation/auth_gate_screen.dart';
import '../../auth/shards/auth_shard.dart';
import '../data/chat_repository.dart';
import '../domain/chat_state.dart';
import '../shards/chat_shard.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_composer.dart';
import 'widgets/chat_header.dart';

/// Maps AG-UI tool calls onto router navigation.
const _toolRouteMap = <String, String>{
  'open_tracker': '/tracker',
  'open_history': '/history',
  'open_score': '/score',
  'open_settings': '/settings',
};

const _shellPaths = {'/tracker', '/chat', '/score'};

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ShardBuilder<AuthShard, AuthState>(
      builder: (context, authState) {
        if (!authState.isAuthenticated || authState.accessToken == null) {
          return const AuthGateScreen();
        }

        final services = AppScope.of(context);
        return _AuthenticatedChatScreen(
          key: ValueKey(authState.profile?.userId ?? authState.accessToken),
          agentClient: services.agentClient,
          profileId: authState.profile?.userId ?? 'guest',
          displayName: authState.profile?.displayName ?? '',
        );
      },
    );
  }
}

class _AuthenticatedChatScreen extends StatefulWidget {
  const _AuthenticatedChatScreen({
    required this.agentClient,
    required this.profileId,
    required this.displayName,
    super.key,
  });

  final AgentServiceClient agentClient;
  final String profileId;
  final String displayName;

  @override
  State<_AuthenticatedChatScreen> createState() =>
      _AuthenticatedChatScreenState();
}

class _AuthenticatedChatScreenState extends State<_AuthenticatedChatScreen> {
  TextEditingValue _composerValue = TextEditingValue.empty;

  late final AgUiClient _agUi = ConnectAgUiClient(
    client: widget.agentClient,
    accessTokenProvider: () =>
        ShardProvider.of<AuthShard>(context, listen: false).state.accessToken,
  );

  void _handleNavigate(String toolName, Map<String, dynamic> args) {
    final route = _toolRouteMap[toolName];
    if (route == null || !mounted) return;
    if (_shellPaths.contains(route)) {
      context.go(route);
      return;
    }
    context.push(route);
  }

  void _send(ChatShard shard, [String? text]) {
    final content = text ?? _composerValue.text;
    if (content.trim().isEmpty) return;
    setState(() => _composerValue = TextEditingValue.empty);
    shard.send(content);
  }

  @override
  Widget build(BuildContext context) {
    return ShardProvider<ChatShard>(
      create: () => ChatShard(
        repository: ChatRepository(
          client: _agUi,
          threadId: 'thread-${widget.profileId}',
          stateBuilder: () => {
            'currentRoute': _currentRoute(context),
            'user': {'displayName': widget.displayName},
          },
          tools: const [
            AgUiToolDefinition(
              name: 'open_tracker',
              description: 'Abre el tracker de gastos y tickets.',
            ),
            AgUiToolDefinition(
              name: 'open_history',
              description: 'Abre el historial de movimientos confirmados.',
            ),
            AgUiToolDefinition(
              name: 'open_score',
              description: 'Abre la pantalla del score financiero.',
            ),
            AgUiToolDefinition(
              name: 'open_settings',
              description: 'Abre la configuración de la cuenta.',
            ),
          ],
        ),
        onNavigate: _handleNavigate,
      ),
      child: ColoredBox(
        color: warmSurface,
        child: Column(
          children: [
            const ChatHeader(),
            Expanded(
              child: ShardBuilder<ChatShard, ChatState>(
                builder: (context, state) {
                  final shard = ShardProvider.of<ChatShard>(
                    context,
                    listen: false,
                  );
                  final items = [
                    ...state.messages,
                    if (state.draftAssistant != null) state.draftAssistant!,
                  ];
                  if (items.isEmpty) {
                    return _EmptyChatHint(onSend: (text) => _send(shard, text));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: items.length,
                    itemBuilder: (context, i) => ChatBubble(message: items[i]),
                  );
                },
              ),
            ),
            ShardBuilder<ChatShard, ChatState>(
              buildWhen: (a, b) => a.errorMessage != b.errorMessage,
              builder: (context, state) {
                final err = state.errorMessage;
                if (err == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: FAlert(
                    variant: FAlertVariant.destructive,
                    title: const Text('No pude responder'),
                    subtitle: Text(err),
                  ),
                );
              },
            ),
            ColoredBox(
              color: warmSurface,
              child: ShardBuilder<ChatShard, ChatState>(
                buildWhen: (a, b) => a.runStatus != b.runStatus,
                builder: (context, state) {
                  final shard = ShardProvider.of<ChatShard>(
                    context,
                    listen: false,
                  );
                  return ChatComposer(
                    value: _composerValue,
                    onChanged: (v) => setState(() => _composerValue = v),
                    onSubmit: () => _send(shard),
                    isStreaming: state.isStreaming,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _currentRoute(BuildContext context) {
  try {
    return GoRouterState.of(context).uri.path;
  } catch (_) {
    return '/chat';
  }
}

class _EmptyChatHint extends StatelessWidget {
  const _EmptyChatHint({required this.onSend});

  final void Function(String) onSend;

  static const _suggestions = [
    '¿Cómo funciona el CAT?',
    'Simula mi primer sueldo',
    '¿Qué es el score crediticio?',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Peso avatar
          DecoratedBox(
            decoration: BoxDecoration(
              color: lightGreenTint,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Icon(FIcons.bot, size: 40, color: primaryGreen),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Hola, soy Peso.',
            style: TextStyle(
              color: ink,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Cuéntame qué decisión financiera\nquieres revisar hoy.',
            textAlign: TextAlign.center,
            style: TextStyle(color: inkMuted, fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 32),
          ..._suggestions.map(
            (text) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _SuggestionChip(text: text, onTap: () => onSend(text)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  const _SuggestionChip({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderSubtle, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(FIcons.chevronRight, size: 16, color: inkMuted),
            ],
          ),
        ),
      ),
    );
  }
}
