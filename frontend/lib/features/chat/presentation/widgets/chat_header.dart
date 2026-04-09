import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/green_tokens.dart';

/// Top-of-chat header — Peso avatar + name/status on the left, settings on
/// the right, separated from the message list by a hairline divider.
class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: warmSurface,
        border: Border(bottom: BorderSide(color: borderSubtle, width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: Row(
          children: [
            // Agent avatar tile
            DecoratedBox(
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Padding(
                padding: EdgeInsets.all(9),
                child: Icon(FIcons.bot, size: 20, color: surface),
              ),
            ),
            const SizedBox(width: 12),
            // Name + status
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Peso',
                  style: TextStyle(
                    color: ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        color: midGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const SizedBox(width: 6, height: 6),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Tu compañero financiero',
                      style: TextStyle(
                        color: inkMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            // Settings button
            GestureDetector(
              onTap: () => context.push('/settings'),
              behavior: HitTestBehavior.opaque,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4F2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(FIcons.settings, size: 18, color: inkMuted),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
