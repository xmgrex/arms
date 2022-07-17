import '../../products/domain/sku.dart';

class SkuInventoryCountParams {
  const SkuInventoryCountParams({
    required this.supplierId,
    required this.sku,
  });

  final String supplierId;
  final SKU sku;

}