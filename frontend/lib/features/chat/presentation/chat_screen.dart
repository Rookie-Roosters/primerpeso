import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shard/shard.dart';

import '../../../core/agui/agui_client.dart';
import '../../../core/app_scope.dart';
import '../../../core/theme/green_tokens.dart';
import '../../../gen/primerpeso/agent/v1/agent.connect.client.dart';
import '../../../gen/primerpeso/documents/v1/documents.pb.dart' as documentsv1;
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
const _ledgerMutationTools = {
  'register_expense',
  'register_income',
  'update_movement',
  'delete_movement',
  'undo_last_registration',
};

const _shellPaths = {'/tracker', '/chat', '/score'};

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = AppScope.of(context);
    final session = AppScope.sessionOf(context);
    return _ChatSurface(
      key: ValueKey(session.deviceId),
      agentClient: services.agentClient,
      profileId: session.deviceId,
      displayName: 'Usuario',
      deviceId: session.deviceId,
    );
  }
}

class _ChatSurface extends StatefulWidget {
  const _ChatSurface({
    required this.agentClient,
    required this.profileId,
    required this.displayName,
    required this.deviceId,
    super.key,
  });

  final AgentServiceClient agentClient;
  final String profileId;
  final String displayName;
  final String deviceId;

  @override
  State<_ChatSurface> createState() => _ChatSurfaceState();
}

class _ChatSurfaceState extends State<_ChatSurface> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _composerController = TextEditingController();

  bool _isUploadingAttachment = false;
  String? _uploadError;

  late final AgUiClient _agUi = ConnectAgUiClient(
    client: widget.agentClient,
    deviceIdProvider: () => widget.deviceId,
  );

  void _handleNavigate(String toolName, Map<String, dynamic> args) {
    if (!mounted) return;
    if (_ledgerMutationTools.contains(toolName)) {
      AppScope.ledgerRefreshOf(context).markChanged();
    }
    final route = _toolRouteMap[toolName];
    if (route == null) return;
    if (_shellPaths.contains(route)) {
      context.go(route);
      return;
    }
    context.push(route);
  }

  void _send(ChatShard shard, [String? text]) {
    final content = text ?? _composerController.text;
    if (content.trim().isEmpty) return;
    _composerController.clear();
    shard.send(content);
  }

  Future<void> _attach(ChatShard shard) async {
    final receiptRepository = AppScope.of(context).receiptRepository;
    final source = await showModalBottomSheet<_AttachmentSource>(
      context: context,
      backgroundColor: surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(FIcons.camera),
              title: const Text('Tomar foto'),
              onTap: () => Navigator.of(context).pop(_AttachmentSource.camera),
            ),
            ListTile(
              leading: const Icon(FIcons.image),
              title: const Text('Elegir imagen'),
              onTap: () => Navigator.of(context).pop(_AttachmentSource.gallery),
            ),
            ListTile(
              leading: const Icon(FIcons.file),
              title: const Text('Subir PDF'),
              onTap: () => Navigator.of(context).pop(_AttachmentSource.pdf),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    setState(() {
      _isUploadingAttachment = true;
      _uploadError = null;
    });

    try {
      final attachment = await _pickAttachment(source);
      if (attachment == null) return;
      final result = await receiptRepository.uploadReceipt(
        content: attachment.bytes,
        filename: attachment.filename,
        mimeType: attachment.mimeType,
      );
      if (!mounted) return;
      if (_needsClarification(result)) {
        await context.push('/receipt-review', extra: result.draft);
      } else {
        AppScope.ledgerRefreshOf(context).markChanged();
        final draft = result.draft;
        shard.addSystemMessage(
          'Gasto registrado: ${draft.merchantName} por ${draft.total.units} ${draft.total.currencyCode}.',
        );
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _uploadError = error.toString());
    } finally {
      if (mounted) {
        setState(() => _isUploadingAttachment = false);
      }
    }
  }

  Future<_PickedAttachment?> _pickAttachment(_AttachmentSource source) async {
    if (source == _AttachmentSource.pdf) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['pdf'],
        withData: true,
      );
      final file = (result == null || result.files.isEmpty)
          ? null
          : result.files.first;
      if (file == null || file.bytes == null) return null;
      return _PickedAttachment(
        bytes: file.bytes!,
        filename: file.name,
        mimeType: 'application/pdf',
      );
    }

    final image = await _picker.pickImage(
      source: source == _AttachmentSource.camera
          ? ImageSource.camera
          : ImageSource.gallery,
      imageQuality: 92,
    );
    if (image == null) return null;
    return _PickedAttachment(
      bytes: await image.readAsBytes(),
      filename: image.name,
      mimeType: _mimeTypeForPath(image.path),
    );
  }

  @override
  void dispose() {
    _composerController.dispose();
    super.dispose();
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
            AgUiToolDefinition(
              name: 'register_expense',
              description:
                  'Registra un gasto manual cuando el usuario lo pide.',
            ),
            AgUiToolDefinition(
              name: 'register_income',
              description:
                  'Registra un ingreso manual cuando el usuario lo pide.',
            ),
            AgUiToolDefinition(
              name: 'list_recent_movements',
              description:
                  'Lista movimientos recientes (ingresos y gastos) para responder o decidir acciones de ledger.',
            ),
            AgUiToolDefinition(
              name: 'list_recent_expenses',
              description:
                  'Compatibilidad: lista movimientos recientes para historial financiero.',
            ),
            AgUiToolDefinition(
              name: 'search_aprende_y_crece',
              description:
                  'Consulta contenido de Aprende y Crece para educación financiera y devuelve fuentes con links específicos.',
            ),
            AgUiToolDefinition(
              name: 'update_movement',
              description:
                  'Actualiza un movimiento existente por referencia de comercio/tiempo/tipo.',
            ),
            AgUiToolDefinition(
              name: 'delete_movement',
              description:
                  'Elimina un movimiento existente por referencia de comercio/tiempo/tipo.',
            ),
            AgUiToolDefinition(
              name: 'undo_last_registration',
              description:
                  'Deshace el último movimiento registrado por petición del usuario.',
            ),
          ],
        ),
        onNavigate: _handleNavigate,
      ),
      child: ColoredBox(
        color: warmSurface,
        child: Column(
          children: [
            Expanded(
              child: ColoredBox(
                color: chatCanvas,
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ColoredBox(
                          color: warmSurface,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const ChatHeader(),
                              Container(
                                height: 1,
                                color: borderSubtle,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: items.isEmpty
                              ? SingleChildScrollView(
                                  child: _EmptyChatHint(
                                    onSend: (text) => _send(shard, text),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  itemCount: items.length,
                                  itemBuilder: (context, i) => ChatBubble(
                                    message: items[i],
                                  ),
                                ),
                        ),
                      ],
                    );
                  },
                ),
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
            if (_uploadError != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: FAlert(
                  variant: FAlertVariant.destructive,
                  title: const Text('No pude subir el archivo'),
                  subtitle: Text(_uploadError!),
                ),
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
                    controller: _composerController,
                    onSubmit: () => _send(shard),
                    onAttach: () => _attach(shard),
                    isStreaming: state.isStreaming,
                    isUploading: _isUploadingAttachment,
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

bool _needsClarification(documentsv1.UploadReceiptResponse response) {
  return response.decision ==
      documentsv1.ExtractionDecision.EXTRACTION_DECISION_NEEDS_CLARIFICATION;
}

enum _AttachmentSource { camera, gallery, pdf }

class _PickedAttachment {
  const _PickedAttachment({
    required this.bytes,
    required this.filename,
    required this.mimeType,
  });

  final Uint8List bytes;
  final String filename;
  final String mimeType;
}

String _mimeTypeForPath(String path) {
  final lower = path.toLowerCase();
  if (lower.endsWith('.png')) return 'image/png';
  if (lower.endsWith('.webp')) return 'image/webp';
  return 'image/jpeg';
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
    'Recordatorios',
    'Metas financieras',
    'Registrar gasto/ingreso',
    'Duda financiera',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            'Recordatorios, metas, movimientos o una duda:\nelige un atajo o escribe lo que necesites.',
            textAlign: TextAlign.center,
            style: TextStyle(color: inkMuted, fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 32),
          ..._suggestions.map(
            (text) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
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
