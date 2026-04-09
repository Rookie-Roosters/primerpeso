import 'package:flutter/widgets.dart';

import '../../../../core/theme/green_tokens.dart';

/// Top-of-chat title block — matches Tracker / Score (large title + muted subtitle).
class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(24, 22, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Peso',
            style: TextStyle(
              color: ink,
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
              height: 1.0,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Tu compañero financiero',
            style: TextStyle(
              color: inkMuted,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
