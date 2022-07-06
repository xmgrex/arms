import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../utils/super_icons.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Account Settings',
                  style: TextStyles.title.large.bold,
                ),
              ),
              _SettingsListTile(
                icon: SuperIcons.lock,
                title: 'Account info',
                onTap: () {
                  context.goNamed(AppRoute.accountInfoScreen.name);
                },
              ),
              divider(context),
              _SettingsListTile(
                icon: SuperIcons.location,
                title: 'Addresses',
                onTap: () {
                  context.goNamed(AppRoute.chooseAddressScreen.name);
                },
              ),
              divider(context),
              _SettingsListTile(
                icon: SuperIcons.wallet,
                title: 'Payment methods',
                onTap: () {
                  context.goNamed(AppRoute.paymentMethodsScreen.name);
                },
              ),
              divider(context),
              _SettingsListTile(
                icon: SuperIcons.bell,
                title: 'Notifications',
                onTap: () {},
              ),
              divider(context),
              _SettingsListTile(
                icon: XIcons.accessibility,
                title: 'Accessibility',
                onTap: () {
                  context.goNamed(AppRoute.accessibilitySettingsScreen.name);
                },
              ),
              divider(context),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 64.0),
                  child: SignOutButton(variant: ButtonVariant.outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsListTile extends StatelessWidget {
  const _SettingsListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 0.0,
      ),
      minLeadingWidth: Sizes.p20,
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black, size: Sizes.p20),
      ),
      title: Text(title, style: TextStyles.body.bold),
      trailing: const Icon(Icons.arrow_forward_ios, size: Sizes.p12),
    );
  }
}
