/// Single message displayed in the chat surface.
///
/// Mirrors AG-UI message roles (`user` / `assistant` / `tool`) plus a local
/// `system` for client-side notices like errors. The shard converts streaming
/// AG-UI events into a stable list of these.
enum ChatRole { user, assistant, tool, system }

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    this.toolName,
  });

  /// Stable id (matches AG-UI `messageId` for assistant turns).
  final String id;
  final ChatRole role;
  final String content;

  /// Set on tool-call bubbles so the UI can render which tool ran.
  final String? toolName;

  ChatMessage copyWith({String? content}) => ChatMessage(
        id: id,
        role: role,
        content: content ?? this.content,
        toolName: toolName,
      );
}
