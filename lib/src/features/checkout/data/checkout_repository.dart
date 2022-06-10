import 'package:arms/src/service/shered_prefs_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutRepository {
  CheckoutRepository(this.sharedPrefsManager);
  final SharedPrefsManager sharedPrefsManager;

  Future<String?> getDefaultAddressId() async {
    return sharedPrefsManager.getDefaultAddressId();
  }

}

final checkoutRepositoryProvider = Provider((ref) {
  final sharedPrefsManager = ref.watch(sharedPrefsManagerProvider);
  return CheckoutRepository(sharedPrefsManager);
});