import 'package:arms/generated/l10n.dart';
import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/products/domain/sku.dart';
import 'package:arms/src/features/supplier/data/supplier_repository.dart';
import 'package:arms/src/features/supplier/domain/sku_inventory_count_paramas.dart';
import 'package:arms/src/features/supplier/domain/supplier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:x_kit/x_kit.dart';

class SupplierListItem extends StatelessWidget {
  const SupplierListItem({Key? key, required this.supplier, required this.sku})
      : super(key: key);

  final Supplier supplier;
  final SKU sku;

  @override
  Widget build(BuildContext context) {
    final params = SkuInventoryCountParams(supplierId: supplier.id, sku: sku);
    logger.finer(params.sku.id);
    return Consumer(
      builder: (c, ref, _) => AsyncValueWidget<SKU>(
        loading: () {
          return shimmer(context);
        },
        value: ref.watch(skuInventoryCountProvider(params)),
        data: (sku) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(supplier.name, style: TextStyles.body.bold),
                gapH16,
                _inventoryStatusWidget(context, sku),
                gapH4,
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _inventoryStatusWidget(BuildContext context, SKU sku) {
    final isStock = sku.inventory > 0;
    final icon = isStock
        ? const Icon(
            Icons.circle_outlined,
            color: Colors.greenAccent,
          )
        : Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.error,
          );
    final title = isStock ? S.of(context).inStock : S.of(context).noStock;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          icon,
          gapW8,
          Text(title, style: TextStyles.body),
        ],
      ),
    );
  }

  Widget shimmer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1200),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 24.0,
              width: 300.0,
              decoration: BoxDecoration(
                color: colorScheme.outline,
                borderRadius: BorderRadius.circular(Sizes.p4),
              ),
            ),
            gapH16,
            Row(
              children: [
                Container(
                  height: 32.0,
                  width: 32.0,
                  decoration: BoxDecoration(
                    color: colorScheme.outline,
                    borderRadius: BorderRadius.circular(Sizes.p64),
                  ),
                ),
                gapW4,
                Container(
                  height: 28.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    color: colorScheme.outline,
                    borderRadius: BorderRadius.circular(Sizes.p4),
                  ),
                ),
              ],
            ),
            gapH8,
            const Divider(),
          ],
        ),
      ),
      highlightColor: colorScheme.outline.withOpacity(.3),
      baseColor: colorScheme.onBackground.withOpacity(.1),
    );
  }
}
