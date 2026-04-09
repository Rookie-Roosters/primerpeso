import 'package:flutter/widgets.dart';

import 'api/app_services.dart';
import 'finance/ledger_refresh_notifier.dart';
import 'session/app_session.dart';

class AppScope extends InheritedWidget {
  const AppScope({
    required this.services,
    required this.session,
    required super.child,
    super.key,
  });

  final AppServices services;
  final AppSession session;

  static AppScope maybeScope(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'No AppScope found in context');
    return scope!;
  }

  static AppServices of(BuildContext context) => maybeScope(context).services;

  static AppSession sessionOf(BuildContext context) =>
      maybeScope(context).session;

  static LedgerRefreshNotifier ledgerRefreshOf(BuildContext context) =>
      maybeScope(context).services.ledgerRefresh;

  @override
  bool updateShouldNotify(AppScope oldWidget) {
    return oldWidget.services != services || oldWidget.session != session;
  }
}
