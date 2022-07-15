import 'package:arms/src/features/supplier/data/supplier_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import '../service/shared_prefs_manager.dart';
import 'authentication/domain/app_user.dart';
import 'authentication/presentation/account/app_user_notifier.dart';

final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.watch(authProvider).authStateChanges();
});

final appUserStateProvider = StateNotifierProvider<AppUserNotifier, AppUser?>(
  (ref) => AppUserNotifier(ref.read),
);

final nearbySuppliers = FutureProvider((ref) async {
  return ref.watch(supplierRepositoryProvider).fetchSuppliersList();
});

final themeModeProvider = StateProvider<bool>((_) => false);
