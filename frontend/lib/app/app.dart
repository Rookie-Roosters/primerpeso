import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forui/forui.dart';
import 'package:mix/mix.dart';
import 'package:shard/shard.dart';

import '../core/api/app_services.dart';
import '../core/app_scope.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/green_tokens.dart';
import '../core/widgets/mobile_frame.dart';
import '../features/auth/data/secure_token_storage.dart';
import '../features/auth/shards/auth_shard.dart';
import 'router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppServices _services;
  late final AuthShard _authShard;

  @override
  void initState() {
    super.initState();
    _services = AppServices.create();
    _authShard = AuthShard(
      repository: _services.authRepository,
      storage: SecureTokenStorage(),
    );
    unawaited(_authShard.bootstrap());
  }

  @override
  void dispose() {
    _authShard.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fTheme = buildAppTheme();
    return AppScope(
      services: _services,
      child: ShardProvider<AuthShard>.value(
        value: _authShard,
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
            routerConfig: appRouter,
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
      ),
    );
  }
}
