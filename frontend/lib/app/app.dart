import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:mix/mix.dart';

import '../core/api/app_services.dart';
import '../core/app_scope.dart';
import '../core/session/app_session.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/green_tokens.dart';
import '../core/widgets/mobile_frame.dart';
import 'router.dart';

class App extends StatefulWidget {
  const App({required this.session, super.key});

  final AppSession session;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppServices _services;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _services = AppServices.create(deviceId: widget.session.deviceId);
    _router = buildAppRouter(widget.session);
  }

  @override
  Widget build(BuildContext context) {
    final fTheme = buildAppTheme();
    return AppScope(
      services: _services,
      session: widget.session,
      child: MixScope(
        colors: appColorTokens,
        spaces: appSpaceTokens,
        radii: appRadiusTokens,
        child: MaterialApp.router(
          title: 'PrimerPeso',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryGreen,
              primary: primaryGreen,
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: warmSurface,
            useMaterial3: true,
          ),
          routerConfig: _router,
          supportedLocales: FLocalizations.supportedLocales,
          localizationsDelegates: const [
            FLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          builder: (context, child) => FTheme(
            data: fTheme,
            child: Material(
              type: MaterialType.transparency,
              child: MobileFrame(child: child!),
            ),
          ),
        ),
      ),
    );
  }
}
