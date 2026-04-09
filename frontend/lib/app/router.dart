import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../features/chat/presentation/chat_screen.dart';
import '../features/dashboard/presentation/score_screen.dart';
import '../features/dashboard/presentation/tracker_screen.dart';
import '../features/history/presentation/history_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/simulator/presentation/cat_screen.dart';
import '../features/simulator/presentation/credit_screen.dart';
import '../features/simulator/presentation/paycheck_screen.dart';
import 'app_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

/// Root [GoRouter] — [StatefulShellRoute] keeps tracker, chat, and score alive;
/// secondary routes use the root navigator so they cover the bottom bar.
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/chat',
  redirect: (context, state) {
    if (state.uri.path == '/dashboard') {
      return '/tracker';
    }
    return null;
  },
  errorBuilder: (context, state) => _RouteErrorPage(error: state.error),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tracker',
              builder: (context, state) => const TrackerScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chat',
              builder: (context, state) => const ChatScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/score',
              builder: (context, state) => const ScoreScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/history',
      builder: (context, state) => const HistoryScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/simulator/paycheck',
      builder: (context, state) => const PaycheckScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/simulator/credit',
      builder: (context, state) => const CreditScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/simulator/cat',
      builder: (context, state) => const CatScreen(),
    ),
  ],
);

class _RouteErrorPage extends StatelessWidget {
  const _RouteErrorPage({required this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FAlert(
              variant: FAlertVariant.destructive,
              title: const Text('Ruta no encontrada'),
              subtitle: Text(error?.toString() ?? 'Esa pantalla aún no existe.'),
            ),
            const SizedBox(height: 16),
            FButton(
              onPress: () => context.go('/chat'),
              child: const Text('Volver al chat'),
            ),
          ],
        ),
      ),
    );
  }
}
