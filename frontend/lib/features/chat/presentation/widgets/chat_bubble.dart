import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/green_tokens.dart';
import '../../../../core/theme/typography.dart';
import '../../domain/chat_message.dart';

/// A single chat message bubble.
///
/// User messages: filled deep-green stadium pill with white Inter text,
/// right-aligned. Assistant messages: white `HeroCard.compact`, left-aligned.
/// Tool messages: white card with a primary-green hairline border and a small
/// "Herramienta · X" eyebrow. System messages: tinted danger-red surface.
class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, super.key});

  final ChatMessage message;

  static const double _maxBubbleWidth = 300.0;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;
    final isTool = message.role == ChatRole.tool;
    final isSystem = message.role == ChatRole.system;

    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;

    final textColor = switch (message.role) {
      ChatRole.user => surface,
      ChatRole.assistant => ink,
      ChatRole.tool => inkMuted,
      ChatRole.system => dangerRed,
    };

    final label = isTool ? 'Herramienta · ${message.toolName ?? ''}' : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxBubble = math.min(
          _maxBubbleWidth,
          math.max(0.0, constraints.maxWidth - 72),
        );

        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  label,
                  style: PTypography.label.copyWith(
                    color: primaryGreen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            _MessageContent(
              content: message.content.isEmpty && !isSystem
                  ? '…'
                  : message.content,
              role: message.role,
              textColor: textColor,
              alignRight: isUser,
            ),
          ],
        );

        return Align(
          alignment: alignment,
          child: Padding(
            padding: EdgeInsets.only(
              left: isUser ? 56 : 16,
              right: isUser ? 16 : 56,
              top: 4,
              bottom: 4,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxBubble),
              child: _BubbleSurface(
                role: message.role,
                isTool: isTool,
                child: content,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BubbleSurface extends StatelessWidget {
  const _BubbleSurface({
    required this.role,
    required this.isTool,
    required this.child,
  });

  final ChatRole role;
  final bool isTool;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (role == ChatRole.user) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: primaryGreen,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A0E5B3C),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: child,
        ),
      );
    }

    if (role == ChatRole.system) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: dangerRed.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: dangerRed.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: child,
        ),
      );
    }

    // Assistant + tool — small white card with the shared soft shadow.
    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(22),
        border: isTool ? Border.all(color: lightGreenTint, width: 1.2) : null,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0E000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: child,
      ),
    );
  }
}

class _MessageContent extends StatelessWidget {
  const _MessageContent({
    required this.content,
    required this.role,
    required this.textColor,
    required this.alignRight,
  });

  final String content;
  final ChatRole role;
  final Color textColor;
  final bool alignRight;

  @override
  Widget build(BuildContext context) {
    final useMarkdown = role == ChatRole.assistant || role == ChatRole.system;
    final base = PTypography.body.copyWith(color: textColor);

    if (!useMarkdown) {
      return Text(
        content,
        textAlign: alignRight ? TextAlign.right : TextAlign.left,
        softWrap: true,
        locale: const Locale('es'),
        style: base.copyWith(
          fontWeight: role == ChatRole.user ? FontWeight.w500 : FontWeight.w400,
        ),
      );
    }

    return MarkdownBody(
      data: content,
      selectable: false,
      onTapLink: (text, href, title) {
        final raw = href?.trim() ?? '';
        if (raw.isEmpty) return;
        final uri = Uri.tryParse(raw);
        if (uri == null) return;
        unawaited(launchUrl(uri, mode: LaunchMode.externalApplication));
      },
      styleSheet: MarkdownStyleSheet(
        p: base,
        listBullet: base,
        a: base.copyWith(
          color: primaryGreen,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w600,
        ),
        strong: base.copyWith(fontWeight: FontWeight.w700),
        em: base.copyWith(fontStyle: FontStyle.italic),
      ),
      softLineBreak: true,
    );
  }
}
