import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../../../generated/l10n.dart';
import '../../auth_notifier.dart';

class DisplayNameTile extends ConsumerWidget {
  const DisplayNameTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseUser = ref.watch(firebaseUserNotifierProvider);
    return ListTile(
      onTap: () => context.pushNamed(AppRoute.editDisplayNameScreen.name),
      title: Text(
        firebaseUser!.displayName == null
            ? S.of(context).noName
            : firebaseUser.displayName!,
      ),
      subtitle: Text(S.of(context).name),
      trailing: const Icon(Icons.arrow_forward_ios, size: Sizes.p12),
    );
  }
}
