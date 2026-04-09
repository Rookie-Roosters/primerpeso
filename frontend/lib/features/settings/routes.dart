import 'package:go_router/go_router.dart';

import 'presentation/settings_screen.dart';

List<GoRoute> settingsRoutes() => [
  GoRoute(
    path: '/settings',
    builder: (context, state) => const SettingsScreen(),
  ),
];
