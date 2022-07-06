import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:arms/src/app/dark_theme.dart';
import 'package:arms/src/app/light_theme.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';
import '../localizations/label_overrides.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future(() async {
      final isDark = await AdaptiveTheme.getThemeMode().then((value) {
        return value!.isDark;
      });
      ref.watch(themeModeProvider.notifier).update((state) => state = isDark);
    });
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
          darkTheme: darkTheme,
        );
      },
    );
  }
}


ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.nunitoSans().fontFamily,
    appBarTheme: appBarTheme(),
    // textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: lightColorScheme(),
    bottomNavigationBarTheme: bottomNavigationBarTheme()
  );
}

ColorScheme colorScheme() {
  return ColorScheme(
    brightness: Brightness.light,
    primary: kPrimaryColor,
    secondary: kPrimaryColor.withOpacity(0.3),
    tertiary: kPrimaryColor.withOpacity(0.5),
    onPrimary: Colors.white,
    onTertiary: Colors.black,
    onSecondary: Colors.white,
    primaryContainer: kPrimaryColor,
    secondaryContainer: kPrimaryColor,
    tertiaryContainer: kPrimaryColor,
    onPrimaryContainer: Colors.black,
    onSecondaryContainer: Colors.black,
    onTertiaryContainer: Colors.black,
    error: const Color(0xFFB00020),
    background: Colors.white,
    surface: Colors.white,
    onError: Colors.white,
    onBackground: Colors.black,
    onSurface: Colors.black,
    errorContainer: const Color(0xFFFCD8DF),
    outline: kSecondaryColor,
    surfaceVariant: Colors.white,
    onErrorContainer: Colors.black,
    shadow: Colors.black,
    onSurfaceVariant: Colors.black,
    inverseSurface: const Color(0xFF121212)
  );
}

BottomNavigationBarThemeData bottomNavigationBarTheme() {
  return const BottomNavigationBarThemeData(
    elevation: 8.0,
    selectedItemColor: Colors.black,
    selectedIconTheme: IconThemeData(color: Colors.black),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

// TextTheme textTheme() {
//   return TextTheme(
//     bodyText1: TextStyle(color: kTextColor),
//     bodyText2: TextStyle(color: kTextColor),
//   );
// }

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 30,
    iconTheme: IconThemeData(color: Colors.black),
  );
}
