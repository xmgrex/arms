import 'package:arms/src/features/products/domain/color_option.dart';
import 'package:arms/src/features/products/domain/size_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../supplier/domain/supplier.dart';
import '../../domain/sku.dart';

class ProductScreenState {
  ProductScreenState({
    this.value = const AsyncValue.loading(),
    this.selectSKU,
    this.skusList = const [],
    this.filteredSKUs = const [],
    this.selectColor,
    this.selectSize,
    this.suppliers = const [],
    this.selectSupplier,
  });

  final AsyncValue<void> value;
  final SKU? selectSKU;
  final List<SKU> skusList;
  final List<SKU> filteredSKUs;
  final ColorOption? selectColor;
  final SizeOption? selectSize;
  final List<Supplier>? suppliers;
  final Supplier? selectSupplier;

  ProductScreenState copyWith({
    AsyncValue<void>? value,
    SKU? selectSKU,
    List<SKU>? skusList,
    List<SKU>? filteredSKUs,
    ColorOption? selectColor,
    SizeOption? selectSize,
    List<Supplier>? suppliers,
    Supplier? selectSupplier,
  }) {
    return ProductScreenState(
      value: value ?? this.value,
      selectSKU: selectSKU ?? this.selectSKU,
      skusList: skusList ?? this.skusList,
      filteredSKUs: filteredSKUs ?? this.filteredSKUs,
      selectColor: selectColor ?? this.selectColor,
      selectSize: selectSize ?? this.selectSize,
      suppliers: suppliers ?? this.suppliers,
      selectSupplier: selectSupplier ?? this.selectSupplier,
    );
  }
}
