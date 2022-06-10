import 'package:arms/src/service/firebase/firestore.dart';
import 'package:arms/src/service/shered_prefs_manager.dart';
import 'package:firebase_services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/domain/app_user.dart';
import '../domain/shipping_address.dart';

class AddressRepository {
  AddressRepository(this.sharedPrefsManager, this.service);
  final SharedPrefsManager sharedPrefsManager;
  final FirestoreService service;

  Future<String?> getDefaultAddressId() async {
    return sharedPrefsManager.getDefaultAddressId();
  }

  Future<void> setDefaultAddress(ShippingAddress address) async {
    await sharedPrefsManager.setDefaultAddress(address);
  }

  Future<void> addShippingAddress(AppUser user) async {
    await service.writers.set(
      path: FirestorePath.user(user.uid),
      data: user.toMap(),
    );
  }

  Future<void> editShippingAddress(AppUser appUser) async {
    await service.writers.update(
      path: FirestorePath.user(appUser.uid),
      data: appUser.toMap(),
    );
  }
}

final addressRepositoryProvider = Provider.autoDispose((ref) {
  final sharedPrefsManager = ref.watch(sharedPrefsManagerProvider);
  final firestoreService = ref.watch(firestoreServiceProvider);
  return AddressRepository(sharedPrefsManager, firestoreService);
});

