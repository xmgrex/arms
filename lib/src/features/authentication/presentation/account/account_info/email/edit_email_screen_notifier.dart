import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../top_level_providers.dart';

final editEmailScreenNotifierProvider =
    StateNotifierProvider<EditEmailScreenNotifier, AsyncValue>((ref) {
  return EditEmailScreenNotifier(ref.read);
});

class EditEmailScreenNotifier extends StateNotifier<AsyncValue> {
  EditEmailScreenNotifier(this._read) : super(const AsyncValue.data(null));

  final Reader _read;

  Future<void> submit(
    String currentEmail,
    String newEmail,
    String password,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _read(authProvider)
          .signInWithEmailAndPassword(email: currentEmail, password: password)
          .then((credential) async {
        await credential.user?.updateEmail(newEmail).then((_) async {
          await credential.user?.sendEmailVerification();
        });
      });
    });
  }
}
