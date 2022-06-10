import 'package:arms/src/features/cart/data/cart_repository.dart';
import 'package:arms/src/features/cart/domain/cart.dart';
import 'package:collection/collection.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_screen_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../domain/product_option.dart';
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

  void initialOptionValues(List<ProductOption> options) {
    var values = <OptionValue>[];
    for (var option in options) {
      values.add(option.values.first);
    }
    state = state.copyWith(selectedOptionValuesList: values);
    logger.info(state.selectedOptionValuesList.toList());
  }

  void selectOptionValue(OptionValue value) {
    var newValues = <OptionValue>[];
    for (var selectValue in state.selectedOptionValuesList) {
      if (selectValue.optionId == value.optionId) {
        newValues.add(value);
      } else {
        newValues.add(selectValue);
      }
    }
    state = state.copyWith(selectedOptionValuesList: newValues);

    final selectedOptionValuesList = state.selectedOptionValuesList.map((e) {
      return [e.id, e.optionId];
    }).toList();
    final deepEq = const DeepCollectionEquality().equals;
    for (var sku in state.skusList!) {
      final optionValues = sku.optionValues.map((e) {
        return [e.id, e.optionId];
      }).toList();
      if (deepEq(optionValues, selectedOptionValuesList)) {
        state = state.copyWith(selectSKU: sku);
      }
    }
    HapticFeedback.selectionClick();
  }

  void setSKUsList(List<SKU> skusList) {
    final selectedOptionValuesList = state.selectedOptionValuesList.map((e) {
      return [e.id, e.optionId];
    }).toList();
    final deepEq = const DeepCollectionEquality().equals;
    for (var sku in skusList) {
      final optionValues = sku.optionValues.map((e) {
        return [e.id, e.optionId];
      }).toList();
      logger.info(sku.optionValues.toString());
      if (deepEq(optionValues, selectedOptionValuesList)) {
        state = state.copyWith(selectSKU: sku);
      }
    }
    state = state.copyWith(skusList: skusList);
  }

  OptionValue searchSelectOptionValue(ProductOption option) {
    late OptionValue value;
    for (var v in state.selectedOptionValuesList) {
      if (v.optionId == option.id) {
        value = v;
      }
    }
    return value;
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
