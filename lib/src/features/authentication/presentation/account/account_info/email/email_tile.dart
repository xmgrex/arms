import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

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
        firebaseUser!.email == null ? 'No email' : firebaseUser.email!,
      ),
      subtitle:const Text('Email'),
      trailing: SizedBox(
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            firebaseUser.emailVerified
                ? Text('Verified', style: TextStyles.body.success)
                : Text('Unverified', style: TextStyles.body.error),
            gapW16,
            const Icon(Icons.arrow_forward_ios, size: Sizes.p12),
          ],
        ),
      ),
    );
  }
}
