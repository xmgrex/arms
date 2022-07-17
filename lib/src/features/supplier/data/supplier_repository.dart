import 'package:arms/src/constants/demo_data/black_short_sleeve_shirt.dart';
import 'package:arms/src/features/products/domain/sku.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/service/shared_prefs_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:x_kit/x_kit.dart';

import '../../../constants/dame_data.dart';
import '../../../constants/demo_data/blue_short_sleeve_shirt.dart';
import '../../../constants/demo_data/compression_inner_long_sleeves.dart';
import '../../../constants/demo_data/gray_short_sleeve_shirt.dart';
import '../../../constants/demo_data/hybrid_knit_jacket.dart';
import '../../../constants/demo_data/white_short_sleeve_shirt.dart';
import '../domain/sku_inventory_count_paramas.dart';
import '../domain/supplier.dart';

class SupplierRepository {
  SupplierRepository(this.ref);

  final Ref ref;

  final List<SKU> _skus = [
    ...kBlackShortSleeveShirts,
    ...kWhiteShortSleeveShirts,
    ...kBlueShortSleeveShirts,
    ...kGrayShortSleeveShirts,
    ...kHybridKnitJacketsList,
    ...kCompressionInnerLongSleevesList,
  ];

  Future<List<Supplier>> fetchSuppliersList() async {
    final sharedPrefs = ref.watch(sharedPrefsManagerProvider);
    final defaultAddressId = await sharedPrefs.getDefaultAddressId();

    final user = ref.watch(appUserStateProvider);
    if (user == null || user.addresses.isEmpty) {
      return Future.error('Userがnull もしくは、住所が登録されていません.');
    }
    final address = user.addresses.firstWhere(
      (element) => element.id == defaultAddressId,
    );
    final geoFirePoint = GeoFirePoint(address.latitude!, address.longitude!);
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(kSuppliers);
  }

  Future<SKU> fetchSKUInventoryCount(String supplierId, SKU sku) async {
    final productId = sku.productId;
    await Future.delayed(const Duration(seconds: 3));
    SKU? v;
    for (final _sku in _skus) {
      if (_sku.id == sku.id) {
        v = _sku;
        break;
      }
    }
    return Future.value(v);
  }
}

final supplierRepositoryProvider = Provider<SupplierRepository>((ref) {
  return SupplierRepository(ref);
});

final skuInventoryCountProvider = FutureProvider.autoDispose
    .family<SKU, SkuInventoryCountParams>((ref, params) {
  final repository = ref.watch(supplierRepositoryProvider);
  return repository.fetchSKUInventoryCount(params.supplierId, params.sku);
});
