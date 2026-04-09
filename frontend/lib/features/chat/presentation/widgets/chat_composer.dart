import 'package:flutter/services.dart' show TextInputAction;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../../../core/theme/green_tokens.dart';

/// Bottom composer for the chat surface.
///
/// Uses a managed text field control with an external [TextEditingController]
/// to keep IME/dead-key composition stable on web (e.g. Spanish accents).
/// The send button is disabled while [isStreaming] is true so a second run
/// can't race the first.
///
/// Visual: same canvas as the shell (`warmSurface`), separated from the
/// message list by a hairline border; send button animates between active
/// green and muted gray.
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
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: warmSurface,
        border: Border(top: BorderSide(color: borderSubtle, width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) {
            final canSend =
                !isStreaming && !isUploading && value.text.trim().isNotEmpty;
            final canAttach = !isStreaming && !isUploading;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: FTextField(
                    control: FTextFieldControl.managed(controller: controller),
                    hint: 'Pregúntale a Peso…',
                    maxLines: 4,
                    minLines: 1,
                    textInputAction: TextInputAction.send,
                    onSubmit: (_) {
                      if (canSend) onSubmit();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: canAttach ? onAttach : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: canAttach
                          ? const Color(0xFFE0EBE5)
                          : const Color(0xFFF0F4F2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Icon(FIcons.paperclip, size: 18, color: inkMuted),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: canSend ? onSubmit : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: canSend ? primaryGreen : const Color(0xFFE0EBE5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Icon(
                        FIcons.arrowUp,
                        size: 20,
                        color: canSend ? surface : inkMuted,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
