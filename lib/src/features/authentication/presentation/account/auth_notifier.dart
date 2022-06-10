import 'package:arms/src/features/top_level_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseUserNotifierProvider =
    StateNotifierProvider<FirebaseUserNotifier, User?>(
  (ref) {
    final auth = ref.watch(authProvider);
    return FirebaseUserNotifier(initialUser: auth.currentUser);
  },
);

class FirebaseUserNotifier extends StateNotifier<User?> {
  FirebaseUserNotifier({User? initialUser}) : super(initialUser) {
    _auth.userChanges().listen((user) {
      state = user;
    });
  }

  final _auth = FirebaseAuth.instance;

  /// FirebaseAuthの匿名認証でサインインする
  Future<void> signInWithAnonymous() async {
    final userCredential = await _auth.signInAnonymously();
    state = userCredential.user;
  }

  /// アカウントを削除する
  Future<void> deleteAccount() async {
    await state?.delete();
  }

  /// Firebase Auth User の表示名を更新する
  Future<void> updateDisplayName(String newName) async {
    await state?.updateDisplayName(newName);
  }

  Future<void> updateEmail(String newEmail) async {
    await state?.updateEmail(newEmail);
  }
}
