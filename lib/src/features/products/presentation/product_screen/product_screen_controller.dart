import 'package:arms/src/features/cart/data/cart_repository.dart';
import 'package:arms/src/features/cart/domain/cart.dart';
import 'package:arms/src/features/products/domain/color_option.dart';
import 'package:arms/src/features/products/domain/size_option.dart';
import 'package:collection/collection.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_screen_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../domain/product.dart';
import '../../domain/sku.dart';

final productScreenControllerProvider = StateNotifierProvider.autoDispose<
    ProductScreenController, ProductScreenState>((ref) {
  return ProductScreenController(ref.read);
});

class ProductScreenController extends StateNotifier<ProductScreenState> {
  ProductScreenController(
    this._read,
  ) : super(ProductScreenState());

  final Reader _read;

  void setSKU() {
    for(final sku in state.skusList) {
      if (sku.color == state.selectColor && sku.size == state.selectSize) {
        state = state.copyWith(selectSKU: sku);
        break;
      }
    }
    logger.finest(state.selectSKU);
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

  void filteringSKUsList() {
    final skusList = state.skusList;
    final filteredSKUs = <SKU>[];
    for(final sku in skusList) {
      if(sku.color == state.selectColor) {
        logger.info(sku);
        filteredSKUs.add(sku);
      }
    }
    state = state.copyWith(filteredSKUs: filteredSKUs);
  }

  void setSKUsList(List<SKU> skusList, Product product) {
    state = state.copyWith(skusList: skusList);
    final sku = skusList.firstWhere((e) => e.inventory > 0);
    selectColor(sku.color);
    selectSize(sku.size);

  }

  Future<void> addToCart(int quantity, Product product) async {
    if (state.selectSKU != null && quantity > 0) {
      state = state.copyWith(value: const AsyncValue.loading());
      final cartItem = CartItem.fromSKU(state.selectSKU!, quantity, product);
      final value = await AsyncValue.guard(() {
        return _read(cartRepositoryProvider).addToCart(cartItem);
      });
      state = state.copyWith(value: value);
      HapticFeedback.heavyImpact();
    }
  }
}
