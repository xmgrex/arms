import 'package:arms/src/features/products/domain/product_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/product.dart';
import '../../domain/sku.dart';

class ProductScreenState {
  ProductScreenState({
    this.value = const AsyncValue.data(null),
    // this.product,
    this.selectSKU,
    this.skusList = const [],
    this.selectedOptionValuesList = const [],
  });

  final AsyncValue<void> value;
  // final Product? product;
  final SKU? selectSKU;
  final List<SKU>? skusList;
  final List<OptionValue> selectedOptionValuesList;

  ProductScreenState copyWith({
    AsyncValue<void>? value,
    // Product? product,
    SKU? selectSKU,
    List<SKU>? skusList,
    List<OptionValue>? selectedOptionValuesList,
  }) {
    return ProductScreenState(
      value: value ?? this.value,
      // product: product ?? this.product,
      selectSKU: selectSKU ?? this.selectSKU,
      skusList: skusList ?? this.skusList,
      selectedOptionValuesList:
          selectedOptionValuesList ?? this.selectedOptionValuesList,
    );
  }
}
