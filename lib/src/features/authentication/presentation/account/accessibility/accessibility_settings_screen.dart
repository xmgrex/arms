import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:arms/src/common_widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../top_level_providers.dart';

class AccessibilitySettingsScreen extends ConsumerWidget {
  const AccessibilitySettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isDark = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(
        leading: backPageButton(context: context),
        title: Text('Accessibility', style: TextStyles.title.bold),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('General'),
            tiles: [
              // SettingsTile.switchTile(
              //   initialValue: isDark,
              //   onToggle: (value) {
              //     print(value);
              //     if (value) {
              //       AdaptiveTheme.of(context).setDark();
              //     } else {
              //       AdaptiveTheme.of(context).setLight();
              //     }
              //     ref.watch(themeModeProvider.notifier).update((state) {
              //       return state = value;
              //     });
              //   },
              //   title: const Text('DarkMode'),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
