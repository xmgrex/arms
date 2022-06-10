import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  Text('Account Settings', style: TextStyles.title.large.bold),
            ),
            _SettingsListTile(
              icon: Icons.lock,
              title: 'Account info',
              onTap: () {
                context.goNamed(AppRoute.accountInfoScreen.name);
              },
            ),
            _SettingsListTile(
              icon: XIcons.mapPin,
              title: 'Addresses',
              onTap: () {
                context.goNamed(AppRoute.chooseAddressScreen.name);
              },
            ),
            _SettingsListTile(
              icon: Icons.credit_card,
              title: 'Payment methods',
              onTap: () {
                context.goNamed(AppRoute.paymentMethodsScreen.name);
              },
            ),
            _SettingsListTile(
              icon: XIcons.bell,
              title: 'Notifications',
              onTap: () {},
            ),
            _SettingsListTile(
              icon: XIcons.accessibility,
              title: 'Accessibility',
              onTap: () {
                context.goNamed(AppRoute.accessibilitySettingsScreen.name);
              },
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 64.0),
                child: SignOutButton(variant: ButtonVariant.outlined),
              ),
            ),
          ],
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
      minLeadingWidth: Sizes.p20,
      onTap: onTap,
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurface,
        size: Sizes.p20,
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: Sizes.p12),
    );
  }
}
