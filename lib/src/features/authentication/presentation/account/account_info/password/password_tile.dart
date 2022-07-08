import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../../../generated/l10n.dart';

class PasswordTile extends ConsumerWidget {
  const PasswordTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () => context.pushNamed(AppRoute.editPasswordScreen.name),
      title: Text(S.of(context).editPassword),
      trailing: const Icon(Icons.arrow_forward_ios, size: Sizes.p12),
    );
  }
}
