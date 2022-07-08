import 'package:arms/src/common_widget/common_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../../../generated/l10n.dart';
import '../../auth_notifier.dart';
import 'edit_email_screen_notifier.dart';

class EditEmailScreen extends ConsumerWidget {
  const EditEmailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseUser = ref.watch(firebaseUserNotifierProvider);
    final currentEmailController = TextEditingController(
      text: firebaseUser == null ? '' : firebaseUser.email,
    );
    final newEmailController = TextEditingController();
    final passwordController = TextEditingController();
    final editEmailFormKey = GlobalKey<FormState>();
    final state = ref.watch(editEmailScreenNotifierProvider);
    final notifier = ref.watch(editEmailScreenNotifierProvider.notifier);
    ref.listen<AsyncValue>(
      editEmailScreenNotifierProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    Future<void> _submit() async {
      if (editEmailFormKey.currentState!.validate()) {
      final currentEmail = currentEmailController.text;
      final newEmail = newEmailController.text;
      final password = passwordController.text;
      await notifier
          .submit(currentEmail, newEmail, password)
          .then((_) {
        context.pop();
      });
      }
    }

    return LoadingOverlay(
      loadingWidget: const LoadingWidget(),
      isLoading: state.isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: backPageButton(context: context),
          title: Text(S.of(context).editEmail),
        ),
        body: Form(
          key: editEmailFormKey,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              children: [
                _textField(
                  label: S.of(context).currentEmail,
                  textEditingController: currentEmailController,
                  onSubmitted: (_) => _submit(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).pleaseEnterCurrentEmail;
                    }
                    return null;
                  },
                ),
                gapH8,
                _textField(
                  label: S.of(context).newEmail,
                  textEditingController: newEmailController,
                  onSubmitted: (_) => _submit(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).pleaseEnterNewEmail;
                    }
                    return null;
                  },
                ),
                gapH8,
                _textField(
                  label: S.of(context).password,
                  textEditingController: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  onSubmitted: (_) => _submit(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).pleaseEnterPassword;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _textField({
  required String label,
  required TextEditingController textEditingController,
  Widget? suffixIcon,
  bool? obscureText,
  TextInputType? keyboardType,
  Function(String v)? onSubmitted,
  String? Function(String? v)? validator,
}) {
  return TextFormField(
    onFieldSubmitted: onSubmitted,
    keyboardType: keyboardType ?? TextInputType.emailAddress,
    maxLines: 1,
    controller: textEditingController,
    validator: validator,
    obscureText: obscureText ?? false,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      hintText: label,
    ),
  );
}
