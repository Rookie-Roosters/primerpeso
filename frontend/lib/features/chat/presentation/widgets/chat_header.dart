import 'package:flutter/widgets.dart';

import '../../../../core/ui/screen_header.dart';

/// Top-of-chat title block — uses the shared `ScreenHeader` so it matches
/// every other screen in the revamped UI.
class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenHeader(
      title: 'Peso',
      subtitle: 'Tu compañero financiero',
    );
  }
}
