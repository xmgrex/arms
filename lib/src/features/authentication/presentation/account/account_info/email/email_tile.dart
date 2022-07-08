import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../../../generated/l10n.dart';
import '../../auth_notifier.dart';

class EmailTile extends ConsumerWidget {
  const EmailTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseUser = ref.watch(firebaseUserNotifierProvider);
    return ListTile(
      onTap: () => context.pushNamed(AppRoute.editEmailScreen.name),
      title: Text(
        firebaseUser!.email == null ? S.of(context).noEmail: firebaseUser.email!,
      ),
      subtitle: Text(S.of(context).email),
      trailing: SizedBox(
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            firebaseUser.emailVerified
                ? Text(S.of(context).verified, style: TextStyles.body.success)
                : Text(S.of(context).unverified, style: TextStyles.body.error),
            gapW16,
            const Icon(Icons.arrow_forward_ios, size: Sizes.p12),
          ],
        ),
      ),
    );
  }
}
