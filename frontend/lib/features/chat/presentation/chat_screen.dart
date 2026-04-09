import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:shard/shard.dart';

import '../../../core/agui/agui_client.dart';
import '../../../core/agui/fake_agui_server.dart';
import '../../../core/theme/green_tokens.dart';
import '../data/chat_repository.dart';
import '../domain/chat_state.dart';
import '../shards/chat_shard.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_composer.dart';
import 'widgets/chat_header.dart';

/// Maps AG-UI tool calls onto router navigation.
///
/// Hard-coded for the skeleton; once the agent grows we'll move this into
/// a registry the chat shard reads from.
const _toolRouteMap = <String, String>{
  'open_dashboard': '/tracker',
  'open_paycheck_simulator': '/simulator/paycheck',
  'open_credit_simulator': '/simulator/credit',
  'open_cat_simulator': '/simulator/cat',
  'open_history': '/history',
  'open_settings': '/settings',
};

const _shellPaths = {'/tracker', '/chat', '/score'};

/// Whether to use the in-memory fake AG-UI server.
///
/// Wired here (not in `main.dart`) so the chat screen owns the
/// transport selection. Flip to false once a real backend is reachable.
const bool kUseFakeAgUi = true;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingValue _composerValue = TextEditingValue.empty;

  late final AgUiClient _agUi;

  @override
  void initState() {
    super.initState();
    _agUi = kUseFakeAgUi
        ? FakeAgUiClient()
        : HttpAgUiClient(endpoint: Uri.parse('http://localhost:8080/agent/run'));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleNavigate(String toolName, Map<String, dynamic> args) {
    final route = _toolRouteMap[toolName];
    if (route == null) return;
    if (!mounted) return;
    if (_shellPaths.contains(route)) {
      context.go(route);
    } else {
      context.push(route);
    }
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
          threadId: 'thread-${DateTime.now().millisecondsSinceEpoch}',
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
                  final shard = ShardProvider.of<ChatShard>(context, listen: false);
                  final items = [
                    ...state.messages,
                    if (state.draftAssistant != null) state.draftAssistant!,
                  ];
                  if (items.isEmpty) {
                    return _EmptyChatHint(
                      onSend: (text) => _send(shard, text),
                    );
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
                  final shard = ShardProvider.of<ChatShard>(context, listen: false);
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
            style: TextStyle(
              color: inkMuted,
              fontSize: 15,
              height: 1.5,
            ),
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
