import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../../core/theme/green_tokens.dart';
import '../../../../core/ui/pill_button.dart';

/// Bottom composer for the chat surface.
///
/// The whole row sits inside a stadium-shaped white "input pill" that floats
/// above the warm gradient. We keep the Forui `FTextField` with a managed
/// controller (per the project rule on lifted Forui controllers) so IME and
/// dead-key composition stay stable on web (e.g. Spanish accents). The
/// surrounding visual is fully restyled — only the input widget itself is
/// Forui.
///
/// The send button is disabled while [isStreaming] is true so a second run
/// can't race the first.
class ChatComposer extends StatelessWidget {
  const ChatComposer({
    required this.controller,
    required this.onSubmit,
    required this.onAttach,
    required this.isStreaming,
    required this.isUploading,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onSubmit;
  final VoidCallback onAttach;
  final bool isStreaming;
  final bool isUploading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) {
          final canSend =
              !isStreaming && !isUploading && value.text.trim().isNotEmpty;
          final canAttach = !isStreaming && !isUploading;

          return DecoratedBox(
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: borderSubtle, width: 1.2),
              boxShadow: cardShadowSoft,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PillIconButton(
                    icon: FIcons.paperclip,
                    onPressed: canAttach ? onAttach : null,
                    busy: isUploading,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: _ComposerInput(
                        controller: controller,
                        onSubmit: () {
                          if (canSend) onSubmit();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  PillIconButton(
                    icon: FIcons.arrowUp,
                    onPressed: canSend ? onSubmit : null,
                    filled: true,
                    busy: isStreaming,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ComposerInput extends StatelessWidget {
  const _ComposerInput({required this.controller, required this.onSubmit});

  final TextEditingController controller;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return FTextField(
      control: FTextFieldControl.managed(controller: controller),
      hint: 'Pregúntale a Peso…',
      maxLines: 4,
      minLines: 1,
      textInputAction: TextInputAction.send,
      onSubmit: (_) => onSubmit(),
    );
  }
}
