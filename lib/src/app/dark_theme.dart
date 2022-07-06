import 'package:arms/src/utils/colors.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_kit/x_kit.dart';

TextTheme textTheme() {
  return TextTheme(
    displayLarge: TextStyles.display.large,
    displayMedium: TextStyles.display,
    displaySmall: TextStyles.display.small,
    headlineLarge: TextStyles.headline.large,
    headlineMedium: TextStyles.headline,
    headlineSmall: TextStyles.headline.small,
    titleLarge: TextStyles.title.large,
    titleMedium: TextStyles.title,
    titleSmall: TextStyles.title.small,
    labelLarge: TextStyles.label.large,
    labelMedium: TextStyles.label,
    labelSmall: TextStyles.label.small,
    bodyLarge: TextStyles.body.large,
    bodyMedium: TextStyles.body,
    bodySmall: TextStyles.body.small,
  ).copyWith(
    button: TextStyles.link.copyWith(fontWeight: FontWeight.w600),
  );
}

ColorScheme darkColorScheme() {
  return ColorScheme(
    brightness: Brightness.light,
    primary: DarkColors.primary,
    secondary: DarkColors.secondary,
    tertiary: DarkColors.tertiary,
    onPrimary: DarkColors.onPrimary,
    onSecondary: DarkColors.onSecondary,
    onTertiary: DarkColors.onTertiary,
    primaryContainer: DarkColors.primaryContainer,
    secondaryContainer: DarkColors.secondaryContainer,
    tertiaryContainer: DarkColors.tertiaryContainer,
    error: DarkColors.error,
    onError: DarkColors.onError,
    background: DarkColors.background,
    surface: DarkColors.surface,
    onBackground: DarkColors.onBackground,
    onSurface: DarkColors.onSurface,
    outline: DarkColors.outline,
    surfaceVariant: DarkColors.surfaceVariant,
    inverseSurface: DarkColors.inverseSurface,
  );
}

final darkTheme = FlexThemeData.dark(
  fontFamily: GoogleFonts.nunitoSans().fontFamily,
  textTheme: textTheme(),
  scheme: FlexScheme.materialBaseline,
  colorScheme: darkColorScheme(),
  usedColors: 1,
  appBarElevation: 0.5,
  subThemesData: const FlexSubThemesData(
    blendOnColors: false,
    blendTextTheme: false,
    elevatedButtonRadius: 2.0,
    outlinedButtonRadius: 2.0,
    elevatedButtonSchemeColor: SchemeColor.tertiary,
    inputDecoratorSchemeColor: SchemeColor.onSecondaryContainer,
    inputDecoratorRadius: 2.0,
    inputDecoratorUnfocusedBorderIsColored: false,
    cardRadius: 2.0,
    dialogRadius: 2.0,
    timePickerDialogRadius: 2.0,
    appBarBackgroundSchemeColor: SchemeColor.onPrimary,
    tabBarItemSchemeColor: SchemeColor.secondary,
    tabBarIndicatorSchemeColor: SchemeColor.secondary,
    bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.inverseSurface,
    bottomNavigationBarUnselectedLabelSchemeColor: SchemeColor.outline,
    bottomNavigationBarSelectedIconSchemeColor: SchemeColor.inverseSurface,
    bottomNavigationBarUnselectedIconSchemeColor: SchemeColor.outline,
    bottomNavigationBarBackgroundSchemeColor: SchemeColor.background,
    bottomNavigationBarElevation: 8.0,
    bottomNavigationBarSelectedLabelSize: 12,
    bottomNavigationBarUnselectedLabelSize: 11,
    bottomNavigationBarLabelTextStyle: TextStyle(fontWeight: FontWeight.w600),
    navigationBarBackgroundSchemeColor: SchemeColor.background,
    navigationRailSelectedLabelSchemeColor: SchemeColor.secondary,
    navigationRailSelectedIconSchemeColor: SchemeColor.secondary,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
// useMaterial3: true,
).copyWith(
  colorScheme: darkColorScheme(),
  splashColor: DarkColors.onSurface.withOpacity(.25),
  inputDecorationTheme: const InputDecorationTheme(),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(
          color: SystemColors.grey400,
        ),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0))),
    ),
  ),
);

