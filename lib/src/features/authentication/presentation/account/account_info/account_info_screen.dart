import 'package:arms/src/common_widget/common_widget.dart';

import 'package:arms/src/features/authentication/presentation/account/account_info/email/email_tile.dart';
import 'package:arms/src/features/authentication/presentation/account/account_info/password/password_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

// import '../../../../top_level_providers.dart';
import 'display_name/display_name_tile.dart';

class AccountInfoScreen extends ConsumerWidget {
  const AccountInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appUser = ref.watch(appUserStateProvider);
    return Scaffold(
      appBar: AppBar(
        leading: backPageButton(context: context),
        title: Text('Account info', style: TextStyles.title.bold),
      ),
      body: Column(
        children: [
          const EmailTile(),
          divider(context, padding: 16.0),
          const DisplayNameTile(),
          divider(context, padding: 16.0),
          const PasswordTile(),
        ],
      ),
    );
  }
}
