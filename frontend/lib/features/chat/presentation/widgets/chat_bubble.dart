import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';

import '../../../../core/theme/green_tokens.dart';
import '../../domain/chat_message.dart';

/// A single chat message bubble.
///
/// User messages: filled deep-green pill with white text, right-aligned.
/// Assistant messages: white card with a subtle shadow, left-aligned.
/// Tool messages: white card with a teal border and monospace-style label.
/// System messages: light-red tint for errors.
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

    final bubbleColor = switch (message.role) {
      ChatRole.user => primaryGreen,
      ChatRole.assistant => surface,
      ChatRole.tool => surface,
      ChatRole.system => const Color(0xFFFCE9E6),
    };

    final textColor = switch (message.role) {
      ChatRole.user => surface,
      ChatRole.assistant => ink,
      ChatRole.tool => inkMuted,
      ChatRole.system => dangerRed,
    };

    final label = isTool ? 'Herramienta · ${message.toolName ?? ''}' : null;
    final addShadow = !isUser && !isSystem;
    final addBorder = isTool;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxBubble = math.min(
          _maxBubbleWidth,
          math.max(0.0, constraints.maxWidth - 72),
        );

        var style = BoxStyler()
            .color(bubbleColor)
            .borderRadius(BorderRadiusMix.all(const Radius.circular(18)))
            .padding(EdgeInsetsMix.symmetric(horizontal: 14, vertical: 10))
            .constraints(BoxConstraintsMix(maxWidth: maxBubble));

        if (addShadow) {
          style = style.shadow(
            BoxShadowMix(
              color: const Color(0x10000000),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          );
        }

        if (addBorder) {
          style = style.border(
            BorderMix.all(BorderSideMix(color: midGreen, width: 1)),
          );
        }

        return Align(
          alignment: alignment,
          child: Padding(
            padding: EdgeInsets.only(
              left: isUser ? 56 : 16,
              right: isUser ? 16 : 56,
              top: 3,
              bottom: 3,
            ),
            child: Box(
              style: style,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (label != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: midGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  Text(
                    message.content.isEmpty && !isSystem
                        ? '…'
                        : message.content,
                    textAlign: isUser ? TextAlign.right : TextAlign.left,
                    softWrap: true,
                    locale: const Locale('es'),
                    strutStyle: const StrutStyle(
                      fontSize: 15,
                      height: 1.45,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      height: 1.45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
