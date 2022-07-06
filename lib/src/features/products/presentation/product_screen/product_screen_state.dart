import 'package:arms/src/features/products/domain/color_option.dart';
import 'package:arms/src/features/products/domain/size_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/sku.dart';

class ProductScreenState {
  ProductScreenState({
    this.value = const AsyncValue.data(null),
    this.selectSKU,
    this.skusList = const [],
    this.filteredSKUs = const [],
    this.selectColor,
    this.selectSize,
  });

  final AsyncValue<void> value;
  final SKU? selectSKU;
  final List<SKU> skusList;
  final List<SKU> filteredSKUs;
  final ColorOption? selectColor;
  final SizeOption? selectSize;

  ProductScreenState copyWith({
    AsyncValue<void>? value,
    SKU? selectSKU,
    List<SKU>? skusList,
    List<SKU>? filteredSKUs,
    ColorOption? selectColor,
    SizeOption? selectSize,
  }) {
    return ProductScreenState(
      value: value ?? this.value,
      selectSKU: selectSKU ?? this.selectSKU,
      skusList: skusList ?? this.skusList,
      filteredSKUs: filteredSKUs ?? this.filteredSKUs,
      selectColor: selectColor ?? this.selectColor,
      selectSize: selectSize ?? this.selectSize,
    );
  }
}
