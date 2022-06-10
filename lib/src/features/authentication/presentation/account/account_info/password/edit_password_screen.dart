import 'package:arms/src/common_widget/common_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/auth.dart';

import '../../auth_notifier.dart';

class EditPasswordScreen extends ConsumerWidget {
  const EditPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseUser = ref.watch(firebaseUserNotifierProvider);
    return Scaffold(
      appBar: AppBar(leading: backPageButton(context: context)),
      body: ForgotPasswordScreen(
        email: firebaseUser!.email,
      ),
    );
  }
}
