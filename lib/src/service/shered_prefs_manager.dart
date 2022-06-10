import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/address/domain/shipping_address.dart';

enum SharedPrefsKey {
  defaultAddress,
  defaultCard,
}

final sharedPrefsManagerProvider = Provider((ref) => SharedPrefsManager());

class SharedPrefsManager {

  Future<void> setDefaultAddress(ShippingAddress address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefsKey.defaultAddress.name, address.id);
  }

  Future<String?> getDefaultAddressId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefsKey.defaultAddress.name);
  }

}