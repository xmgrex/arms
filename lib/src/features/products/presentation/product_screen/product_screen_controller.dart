import 'package:arms/src/features/cart/data/cart_repository.dart';
import 'package:arms/src/features/cart/domain/cart.dart';
import 'package:arms/src/features/products/data/product_repository.dart';
import 'package:arms/src/features/products/domain/color_option.dart';
import 'package:arms/src/features/products/domain/size_option.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_screen_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:x_kit/x_kit.dart';

import '../../../supplier/data/supplier_repository.dart';
import '../../../supplier/domain/supplier.dart';
import '../../domain/product.dart';
import '../../domain/sku.dart';

final productScreenControllerProvider = StateNotifierProvider.autoDispose<
    ProductScreenController, ProductScreenState>((ref) {
  return ProductScreenController(ref.read);
});

final fetchSuppliersAndSKUsProvider =
    FutureProvider.autoDispose.family<void, String>((ref, productId) async {
  final controller = ref.watch(productScreenControllerProvider.notifier);
  return controller.fetchSuppliersListAndSKUsList(productId);
});

class ProductScreenController extends StateNotifier<ProductScreenState> {
  ProductScreenController(
    this._read,
  ) : super(ProductScreenState());

  final Reader _read;

  Future<void> fetchSuppliersListAndSKUsList(String productId) async {
    var suppliersList = <Supplier>[];
    var skusList = <SKU>[];

    state = state.copyWith(value: const AsyncValue.loading());
    final result = await AsyncValue.guard(() async {
      suppliersList =
          await _read(supplierRepositoryProvider).fetchSuppliersList();
      skusList = await _read(productsRepositoryProvider).fetchSKUsList(
        suppliersList.first.id,
        productId,
      );
    });
    // setSKUsList(skusList);
    final sku = skusList.firstWhere(
          (e) => e.inventory > 0,
      orElse: () => skusList.first,
    );
    final filteredSKUs = <SKU>[];
    for (final sku in skusList) {
      if (sku.color == state.selectColor) {
        filteredSKUs.add(sku);
      }
    }

    state = state..copyWith(
      selectSKU: sku,
      selectColor: sku.color,
      selectSize: sku.size,
      filteredSKUs: filteredSKUs,
      value: result,
      suppliers: suppliersList,
      selectSupplier: suppliersList.first,
    );
  }

  void setSKU() {
    for (final sku in state.skusList) {
      if (sku.color == state.selectColor && sku.size == state.selectSize) {
        state = state.copyWith(selectSKU: sku);
        break;
      }
    }
    logger.finest(state.selectSKU);
  }

  void filteringSKUsList() {
    final skusList = state.skusList;
    final filteredSKUs = <SKU>[];
    for (final sku in skusList) {
      if (sku.color == state.selectColor) {
        filteredSKUs.add(sku);
      }
    }
    state = state.copyWith(filteredSKUs: filteredSKUs);
  }

  void setSKUsList(List<SKU> skusList) {
    state = state.copyWith(skusList: skusList);
    final sku = skusList.firstWhere(
      (e) => e.inventory > 0,
      orElse: () => skusList.first,
    );
    selectColor(sku.color);
    selectSize(sku.size);
  }

  void selectSize(SizeOption? size) {
    state = state.copyWith(selectSize: size);
    setSKU();
    HapticFeedback.selectionClick();
  }

  void selectColor(ColorOption? color) {
    state = state.copyWith(selectColor: color);
    filteringSKUsList();
    setSKU();
    HapticFeedback.selectionClick();
  }

  Future<void> addToCart(int quantity, Product product) async {
    if (state.selectSKU != null && quantity > 0) {
      state = state.copyWith(value: const AsyncValue.loading());
      final cartItem = CartItem.fromSKU(state.selectSKU!, quantity, product);
      final result = await AsyncValue.guard(() {
        return _read(cartRepositoryProvider).addToCart(cartItem);
      });
      state = state.copyWith(value: result);
      HapticFeedback.heavyImpact();
    }
  }
}
