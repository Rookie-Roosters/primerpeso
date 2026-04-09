import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forui/forui.dart';
import 'package:mix/mix.dart';

import '../core/theme/app_theme.dart';
import '../core/theme/green_tokens.dart';
import '../core/widgets/mobile_frame.dart';
import 'router.dart';

/// Root widget for PrimerPeso.
///
/// Wrapping order matters here:
///   - `MixScope` is outermost so Mix tokens reach every descendant,
///     including the [MobileFrame] bezel that wraps everything else.
///   - `MaterialApp.router` provides the Navigator, intl + page mechanics.
///     We pin a neutral Material theme; Forui handles the visible chrome.
///   - The `builder:` chain wraps every routed page in `FTheme` (so Forui
///     widgets resolve their styles) and then in `MobileFrame` (so the
///     web build draws a fixed mobile canvas on wide windows).
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final fTheme = buildAppTheme();
    return MixScope(
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
          child: MobileFrame(child: child!),
        ),
      ),
    );
  }
}
