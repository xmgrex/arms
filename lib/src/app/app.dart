import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:arms/src/app/dark_theme.dart';
import 'package:arms/src/app/light_theme.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:arms/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/i10n.dart';
import '../localizations/label_overrides.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final goRouter = ref.watch(goRouterProvider);
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.system,
      light: lightTheme,
      dark: darkTheme,
      builder: (theme, darkTheme) {
        return MaterialApp.router(
            localizationsDelegates: [
              FlutterFireUILocalizations.delegate,
              FlutterFireUIJaLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ja', ''),
              Locale('en', ''),
            ],
            debugShowCheckedModeBanner: false,
            routerDelegate: goRouter.routerDelegate,
            routeInformationParser: goRouter.routeInformationParser,
            title: 'Arms',
            theme: theme,
            darkTheme: darkTheme);
      },
    );
  }
}
