import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:arms/src/common_widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';


class AccessibilitySettingsScreen extends ConsumerWidget {
  const AccessibilitySettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkOn = Theme.of(context).brightness != Brightness.light;

    return Scaffold(
      appBar: AppBar(
        leading: backPageButton(context: context),
        title: const Text('Accessibility'),
      ),
      body: SettingsList(sections: [
        SettingsSection(title: const Text('General'), tiles: [
          SettingsTile.switchTile(
            initialValue: isDarkOn,
            onToggle: (value) {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
            title: const Text('DarkMode'),
          ),
        ])
      ]),
    );
  }
}
