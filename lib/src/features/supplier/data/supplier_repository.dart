import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/service/shared_prefs_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import '../../../constants/dame_data.dart';
import '../domain/supplier.dart';

class SupplierRepository {
  SupplierRepository(this.ref);
  final Ref ref;


  Future<List<Supplier>> fetchSuppliersList() async {
    final sharedPrefs = ref.watch(sharedPrefsManagerProvider);
    final defaultAddressId = await sharedPrefs.getDefaultAddressId();

    final user = ref.watch(appUserStateProvider);
    final address = user!.addresses.firstWhere(
          (element) => element.id == defaultAddressId,
    );
    final geoFirePoint = GeoFirePoint(address.latitude!, address.longitude!);
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(kSuppliers);
  }
}

final supplierRepositoryProvider = Provider<SupplierRepository>((ref) {
  return SupplierRepository(ref);
});