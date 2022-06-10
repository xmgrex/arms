import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/firebase/firestore.dart';
import 'authentication/domain/app_user.dart';
import 'authentication/presentation/account/app_user_notifier.dart';

final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.watch(authProvider).authStateChanges();
});

final appUserStateProvider = StateNotifierProvider<AppUserNotifier, AppUser?>(
  (ref) => AppUserNotifier(ref.read),
);
