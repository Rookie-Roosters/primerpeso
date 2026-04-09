import 'package:flutter/services.dart' show TextInputAction;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../../../core/theme/green_tokens.dart';

/// Bottom composer for the chat surface.
///
/// **Lifted controllers always.** The parent screen owns the
/// [TextEditingValue] and passes it down via [value] / [onChanged]; this
/// widget never instantiates a `TextEditingController`. The send button is
/// disabled while [isStreaming] is true so a second run can't race the first.
///
/// Visual: same canvas as the shell (`warmSurface`), separated from the
/// message list by a hairline border; send button animates between active
/// green and muted gray.
class ChatComposer extends StatelessWidget {
  const ChatComposer({
    required this.value,
    required this.onChanged,
    required this.onSubmit,
    required this.isStreaming,
    super.key,
  });

  final TextEditingValue value;
  final ValueChanged<TextEditingValue> onChanged;
  final VoidCallback onSubmit;
  final bool isStreaming;

  @override
  Widget build(BuildContext context) {
    final canSend = !isStreaming && value.text.trim().isNotEmpty;
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: warmSurface,
        border: Border(top: BorderSide(color: borderSubtle, width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: FTextField(
                control: FTextFieldControl.lifted(
                  value: value,
                  onChange: onChanged,
                ),
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
        ),
      ),
    );
  }
}
