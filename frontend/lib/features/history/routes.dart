import 'package:go_router/go_router.dart';

import 'presentation/history_screen.dart';

List<GoRoute> historyRoutes() => [
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
    ];
